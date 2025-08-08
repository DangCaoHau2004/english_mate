import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/auth_repository.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_event.dart';
import 'package:english_mate/viewModels/authentication/signIn/sign_in_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignInBloc({
    required AuthRepository? authRepository,
    required UserRepository? userRepository,
  }) : _authRepository = authRepository ?? AuthRepository(),
       _userRepository = userRepository ?? UserRepository(),
       super(SignInState()) {
    on<SignInEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignInPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignInWithGoogle>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));
      try {
        UserCredential user = await _authRepository.signInWithGoogle();
        bool isNewUser = await _userRepository.isNewUser(user.user!.uid);

        if (isNewUser) {
          UserInfoData userInfoData = UserInfoData(
            authProvider: AppAuthProvider.google,
            uid: user.user!.uid,
            email: user.user!.email,
          );
          emit(
            state.copyWith(
              status: SignInStatus.profileRequired,
              userInfoData: userInfoData,
            ),
          );
        } else {
          UserData userData = await _userRepository.getUserData(
            uid: user.user!.uid,
          );
          emit(
            state.copyWith(status: SignInStatus.success, userData: userData),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });

    on<SignInWithEmailAndPassword>((event, emit) async {
      emit(state.copyWith(status: SignInStatus.loading));
      try {
        UserCredential user = await _authRepository.signInWithEmailAndPassword(
          email: state.email!,
          password: state.password!,
        );
        bool isNewUser = await _userRepository.isNewUser(user.user!.uid);
        if (isNewUser) {
          UserInfoData userInfoData = UserInfoData(
            authProvider: AppAuthProvider.email,
            uid: user.user!.uid,
            email: user.user!.email,
          );
          emit(
            state.copyWith(
              status: SignInStatus.profileRequired,
              userInfoData: userInfoData,
            ),
          );
        } else {
          UserData userData = await _userRepository.getUserData(
            uid: user.user!.uid,
          );
          emit(
            state.copyWith(status: SignInStatus.success, userData: userData),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: SignInStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
