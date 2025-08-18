import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGateState {
  final bool isLoggedIn;
  final bool? isNewUser;
  final UserInfoData? userInfoData;
  const AuthGateState({
    required this.isLoggedIn,
    required this.isNewUser,
    this.userInfoData,
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
      emit(
        AuthGateState(
          isLoggedIn: true,
          isNewUser: isNewUser,
          userInfoData: userInfoData,
        ),
      );
    });
  }
  void changeIsNewUser(bool isNewUser) {
    emit(
      AuthGateState(
        isLoggedIn: state.isLoggedIn,
        isNewUser: isNewUser,
        userInfoData: state.userInfoData,
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
