import 'package:english_mate/core/enums/app_enums.dart';
import 'package:flutter/material.dart';

abstract class UserInfoEvent {}

class UserInfoEmailChanged extends UserInfoEvent {
  final String email;
  UserInfoEmailChanged({required this.email});
}

class UserInfoGenderChanged extends UserInfoEvent {
  final Gender gender;
  UserInfoGenderChanged({required this.gender});
}

class UserInfoNameChanged extends UserInfoEvent {
  final String name;
  UserInfoNameChanged({required this.name});
}

class UserInfoDateOfBirthChanged extends UserInfoEvent {
  final DateTime dateOfBirth;
  UserInfoDateOfBirthChanged({required this.dateOfBirth});
}

class UserInfoStudyTimeChanged extends UserInfoEvent {
  final TimeOfDay? studyTime;
  UserInfoStudyTimeChanged({required this.studyTime});
}

class UserInfoStudyTimeSkipped extends UserInfoEvent {}

class UserInfoSubmitted extends UserInfoEvent {}

class UserInfoErrorOccurred extends UserInfoEvent {
  final String errorMessage;
  UserInfoErrorOccurred({required this.errorMessage});
}
