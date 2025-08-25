import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/user_data.dart';

class EditProfileState {
  UserData original;
  UserData editting;
  UserInfoStatus status;
  final String? errorMessage;
  EditProfileState({
    required this.original,
    required this.editting,
    this.status = UserInfoStatus.initial,
    this.errorMessage,
  });
  EditProfileState copyWith({
    UserData? original,
    UserData? editting,
    UserInfoStatus? status,
    String? errorMessage,
  }) {
    return EditProfileState(
      original: original ?? this.original,
      editting: editting ?? this.editting,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
