abstract class LinkedAccountEvent {}

class LinkedAccountGoogle extends LinkedAccountEvent {}

class LinkedAccountEmail extends LinkedAccountEvent {
  final String email;
  final String password;

  LinkedAccountEmail({required this.email, required this.password});
}

class UnLinkedAccountGoogle extends LinkedAccountEvent {}

class UnLinkedAccountEmail extends LinkedAccountEvent {}
