import 'package:english_mate/core/enums/app_enums.dart';

abstract class EditProfileEvent {}

class EditProfileFullNameChanged extends EditProfileEvent {
  final String fullName;
  EditProfileFullNameChanged({required this.fullName});
}

class EditProfileSaveClicked extends EditProfileEvent {}

class EditProfileGenderChanged extends EditProfileEvent {
  final Gender gender;
  EditProfileGenderChanged({required this.gender});
}

class EditDateOfBirthChanged extends EditProfileEvent {
  final DateTime dateOfBirth;
  EditDateOfBirthChanged({required this.dateOfBirth});
}
