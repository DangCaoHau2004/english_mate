abstract class SignInEvent {}

class SignInEmailChanged extends SignInEvent {
  String email;
  SignInEmailChanged({required this.email});
}

class SignInPasswordChanged extends SignInEvent {
  String password;
  SignInPasswordChanged({required this.password});
}

class SignInWithGoogle extends SignInEvent {}

class SignInWithEmailAndPassword extends SignInEvent {}
