import 'package:english_mate/core/enums/app_enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpState {
  final String email;
  final String password;
  final SignUpStatus status;
  final String? errorMessage;
  SignUpState({
    this.email = "",
    this.password = "",
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  SignUpState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
    String? errorMessage,
    UserCredential? userCredential,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
