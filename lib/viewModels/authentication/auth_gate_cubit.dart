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
}

class AuthGateCubit extends Cubit<AuthGateState> {
  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;
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
      emit(
        AuthGateState(
          isLoggedIn: true,
          isNewUser: null,
          userInfoData: userInfoData,
        ),
      );
      final isNewUser = await userRepository.isNewUser(user.uid);
      // nếu là người dùng cũ
      if (!isNewUser) {
        UserData? userData = await userRepository.getUserData(uid: user.uid);
        emit(
          AuthGateState(
            isLoggedIn: true,
            isNewUser: isNewUser,
            userInfoData: userInfoData,
            userData: userData,
          ),
        );
      } else {
        emit(
          AuthGateState(
            isLoggedIn: true,
            isNewUser: isNewUser,
            userInfoData: userInfoData,
          ),
        );
      }
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
}
