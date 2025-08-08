import 'package:english_mate/core/enums/app_enums.dart';
import 'package:flutter/material.dart';

class UserInfoState {
  final String uid;
  final String? email;
  final String fullName;
  final AppAuthProvider authProvider;
  final Gender gender;
  final DateTime? dateOfBirth;
  final UserInfoStatus status;
  final String? errorMessage;
  final TimeOfDay? studyTime;
  UserInfoState({
    required this.uid,
    this.email,
    this.fullName = "",
    required this.authProvider,
    this.gender = Gender.male,
    DateTime? dateOfBirth,
    this.status = UserInfoStatus.initial,
    this.errorMessage,
    this.studyTime,
  }) : dateOfBirth = dateOfBirth ?? DateTime.now();

  UserInfoState copyWith({
    String? fullName,
    AppAuthProvider? authProvider,
    String? email,
    Gender? gender,
    DateTime? dateOfBirth,
    UserInfoStatus? status,
    String? errorMessage,
    TimeOfDay? studyTime,
  }) {
    return UserInfoState(
      // uid ko đổi
      email: email ?? this.email,
      uid: uid,
      fullName: fullName ?? this.fullName,
      authProvider: authProvider ?? this.authProvider,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      status: status ?? this.status,
      errorMessage: errorMessage,
      studyTime: studyTime ?? this.studyTime,
    );
  }
}
