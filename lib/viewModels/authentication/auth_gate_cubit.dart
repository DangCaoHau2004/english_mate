import 'dart:async';

import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGateState {
  final bool isLoggedIn;
  final bool? isNewUser;
  final UserInfoData? userInfoData;
  final UserData? userData;
  const AuthGateState({
    required this.isLoggedIn,
    required this.isNewUser,
    this.userInfoData,
    this.userData,
  });
  AuthGateState copyWith({
    bool? isLoggedIn,
    bool? isNewUser,
    UserInfoData? userInfoData,
    UserData? userData,
  }) {
    return AuthGateState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isNewUser: isNewUser ?? this.isNewUser,
      userInfoData: userInfoData ?? this.userInfoData,
      userData: userData ?? this.userData,
    );
  }
}

class AuthGateCubit extends Cubit<AuthGateState> {
  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;
  StreamSubscription? _userDocSub;

  AuthGateCubit({required this.firebaseAuth, required this.userRepository})
    : super(const AuthGateState(isLoggedIn: false, isNewUser: null)) {
    firebaseAuth.userChanges().listen((user) async {
      if (user == null) {
        emit(const AuthGateState(isLoggedIn: false, isNewUser: null));
        return;
      }
      AppAuthProvider authProvider =
          user.providerData[0].providerId == "password"
          ? AppAuthProvider.email
          : AppAuthProvider.google;
      UserInfoData userInfoData = UserInfoData(
        uid: user.uid,
        authProvider: authProvider,
        email: user.email,
      );
      final prevUid = state.userInfoData?.uid;
      final sameUid = prevUid == user.uid;

      if (sameUid) {
        // cùng uid giữ nguyên userData & stream, chỉ cập nhật userInfo,
        // trong trường hợp link nó sẽ load lại cái này nếu bằng null thì sẽ lỗi
        emit(
          state.copyWith(
            isLoggedIn: true,
            isNewUser: state.isNewUser, // giữ nguyên
            userInfoData: userInfoData,
            // userData: giữ nguyên
          ),
        );
        return; // không động vào _userDocSub
      } else {
        // nếu đổi tài khoản mà 2 cái khác uid
        emit(
          AuthGateState(
            isLoggedIn: true,
            isNewUser: null,
            userInfoData: userInfoData,
            userData: null,
          ),
        );
      }

      // nếu là người dùng cũ
      _userDocSub = userRepository
          .watchUserDoc(uid: user.uid)
          .listen(
            (docMap) {
              if (docMap.data() == null) {
                // Chưa có document -> userData = null
                emit(state.copyWith(userData: null, isNewUser: true));
                return;
              }

              final data = UserData.fromFirestore(doc: docMap);
              emit(state.copyWith(userData: data, isNewUser: false));
            },
            onError: (e, st) {
              // Nếu lỗi (rules/mạng), vẫn giữ đăng nhập, nhưng không có userData
              emit(state.copyWith(userData: null, isNewUser: true));
            },
          );
    });
  }
  void changeIsNewUser() async {
    UserData userData = await userRepository.getUserData(
      uid: state.userInfoData!.uid,
    );
    emit(
      AuthGateState(
        isLoggedIn: state.isLoggedIn,
        isNewUser: false,
        userInfoData: state.userInfoData,
        userData: userData,
      ),
    );
  }

  void changeUserData(UserData userData) {
    emit(
      AuthGateState(
        isLoggedIn: state.isLoggedIn,
        isNewUser: state.isNewUser,
        userInfoData: state.userInfoData,
        userData: userData,
      ),
    );
  }

  void reset() {
    emit(
      const AuthGateState(
        isLoggedIn: false,
        isNewUser: null,
        userInfoData: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _userDocSub?.cancel();
    return super.close();
  }
}
