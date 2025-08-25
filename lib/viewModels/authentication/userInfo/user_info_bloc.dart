import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/models/user_info_data.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_event.dart';
import 'package:english_mate/viewModels/authentication/userInfo/user_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserRepository _userRepository;

  UserInfoBloc({
    UserRepository? userRepository,
    required UserInfoData userInfoData,
  }) : _userRepository = userRepository ?? UserRepository(),
       super(
         UserInfoState(
           uid: userInfoData.uid,
           authProvider: userInfoData.authProvider,
           email: userInfoData.email,
         ),
       ) {
    on<UserInfoEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<UserInfoGenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<UserInfoNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.name));
    });

    on<UserInfoStudyTimeChanged>((event, emit) {
      emit(state.copyWith(studyTime: event.studyTime));
    });

    on<UserInfoDateOfBirthChanged>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });
    on<UserInfoStudyTimeSkipped>((event, emit) {
      emit(
        UserInfoState(
          uid: state.uid,
          email: state.email,
          fullName: state.fullName,
          authProvider: state.authProvider,
          gender: state.gender,
          dateOfBirth: state.dateOfBirth,
          status: state.status,
          errorMessage: state.errorMessage,
          studyTime: null, // gán trực tiếp vào hàm mà ko qua copy with
        ),
      );
    });

    on<UserInfoSubmitted>((event, emit) async {
      emit(state.copyWith(status: UserInfoStatus.loading));
      try {
        UserData userData = UserData(
          uid: state.uid,
          email: state.email!,
          fullName: state.fullName,
          authProvider: [state.authProvider],
          gender: state.gender,
          dateOfBirth: state.dateOfBirth!,
          studyTime: state.studyTime,
        );
        await _userRepository.createUserProfile(userData: userData);
        emit(
          state.copyWith(status: UserInfoStatus.success, userData: userData),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: UserInfoStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<UserInfoErrorOccurred>((event, emit) {
      emit(
        state.copyWith(
          errorMessage: event.errorMessage,
          status: UserInfoStatus.failure,
        ),
      );
    });
  }
}
