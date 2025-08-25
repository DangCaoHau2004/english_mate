import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_event.dart';
import 'package:english_mate/viewModels/editProfile/editProfile/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  UserRepository userRepository;
  EditProfileBloc({required UserData userData, required this.userRepository})
    : super(EditProfileState(original: userData, editting: userData)) {
    on<EditProfileFullNameChanged>((event, emit) {
      UserData editting = UserData(
        uid: state.editting.uid,
        email: state.editting.email,
        fullName: event.fullName,
        authProvider: state.editting.authProvider,
        gender: state.editting.gender,
        dateOfBirth: state.editting.dateOfBirth,
        studyTime: state.editting.studyTime,
      );
      emit(state.copyWith(editting: editting));
    });
    on<EditProfileGenderChanged>((event, emit) {
      UserData editting = UserData(
        uid: state.editting.uid,
        email: state.editting.email,
        fullName: state.editting.fullName,
        authProvider: state.editting.authProvider,
        gender: event.gender,
        dateOfBirth: state.editting.dateOfBirth,
        studyTime: state.editting.studyTime,
      );
      emit(state.copyWith(editting: editting));
    });
    on<EditDateOfBirthChanged>((event, emit) {
      UserData editting = UserData(
        uid: state.editting.uid,
        email: state.editting.email,
        fullName: state.editting.fullName,
        authProvider: state.editting.authProvider,
        gender: state.editting.gender,
        dateOfBirth: event.dateOfBirth,
        studyTime: state.editting.studyTime,
      );
      emit(state.copyWith(editting: editting));
    });
    on<EditProfileSaveClicked>((event, emit) {
      emit(state.copyWith(status: UserInfoStatus.loading));
      try {
        userRepository.updateUserData(userData: state.editting);
        emit(
          state.copyWith(
            status: UserInfoStatus.success,
            original: state.editting,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.toString(),
            status: UserInfoStatus.failure,
          ),
        );
      }
    });
  }
}
