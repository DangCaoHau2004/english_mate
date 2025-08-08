import 'package:english_mate/core/enums/app_enums.dart';

class UserInfoData {
  final String uid;
  final String? email;
  final AppAuthProvider authProvider;

  const UserInfoData({
    required this.uid,
    this.email,
    required this.authProvider,
  });
}
