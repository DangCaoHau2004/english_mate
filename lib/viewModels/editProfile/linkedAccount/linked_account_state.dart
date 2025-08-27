import 'package:english_mate/core/enums/app_enums.dart';

class LinkedAccountState {
  final List<AppAuthProvider> appAuthProvider;
  LinkedAccountStatus status;
  final String? errorMessage;

  LinkedAccountState({
    required this.appAuthProvider,
    required this.status,
    this.errorMessage,
  });
  LinkedAccountState copyWith({
    List<AppAuthProvider>? appAuthProvider,
    LinkedAccountStatus? status,
    String? errorMessage,
  }) {
    return LinkedAccountState(
      appAuthProvider: appAuthProvider ?? this.appAuthProvider,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
