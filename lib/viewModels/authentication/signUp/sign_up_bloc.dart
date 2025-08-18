import 'package:english_mate/data/repository/auth_repository.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_event.dart';
import 'package:english_mate/viewModels/authentication/signUp/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_mate/core/enums/app_enums.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository _authRepository;
  SignUpBloc({required AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(SignUpState()) {
    on<SignUpEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<SignUpPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(state.copyWith(status: SignUpStatus.loading));
      try {
        await _authRepository.signUp(
          email: state.email,
          password: state.password,
        );

        emit(state.copyWith(status: SignUpStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: SignUpStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
