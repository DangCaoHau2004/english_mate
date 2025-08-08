import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/models/user_info_data.dart';

class SignInState {
  final UserData? userData;
  final String? email;
  final String? password;
  final SignInStatus status;
  final String? errorMessage;
  UserInfoData? userInfoData;
  SignInState({
    this.userData,
    this.email,
    this.password,
    this.status = SignInStatus.initial,
    this.errorMessage,
    this.userInfoData,
  });
  SignInState copyWith({
    UserData? userData,
    SignInStatus? status,
    String? errorMessage,
    String? email,
    String? password,
    bool? isNewUser,
    UserInfoData? userInfoData,
  }) {
    return SignInState(
      userData: userData ?? this.userData,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      userInfoData: userInfoData ?? this.userInfoData,
    );
  }
}
