import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/user_repository.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_event.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkedAccountBloc extends Bloc<LinkedAccountEvent, LinkedAccountState> {
  UserRepository userRepository;
  LinkedAccountBloc({
    required this.userRepository,
    required List<AppAuthProvider> appAuthProvider,
  }) : super(
         LinkedAccountState(
           status: LinkedAccountStatus.initial,
           appAuthProvider: appAuthProvider,
         ),
       ) {
    on<LinkedAccountGoogle>((event, emit) async {
      try {
        emit(state.copyWith(status: LinkedAccountStatus.loading));
        await userRepository.linkedAccountWithGoogle();
        // thêm lại vào state
        state.appAuthProvider.add(AppAuthProvider.google);
        emit(state.copyWith(status: LinkedAccountStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: LinkedAccountStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<LinkedAccountEmail>((event, emit) async {
      emit(state.copyWith(status: LinkedAccountStatus.loading));
      try {
        await userRepository.linkedAccountWithEmail(
          email: event.email,
          password: event.password,
        );
        // thêm lại vào state
        state.appAuthProvider.add(AppAuthProvider.email);
        emit(state.copyWith(status: LinkedAccountStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: LinkedAccountStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<UnLinkedAccountGoogle>((event, emit) async {
      emit(state.copyWith(status: LinkedAccountStatus.loading));

      try {
        if (state.appAuthProvider.length == 1) {
          throw Exception(
            'Vui lòng liên kết với một tài khoản khác để tiếp tục',
          );
        }
        await userRepository.unLinkedAccount(
          authProvider: AppAuthProvider.google,
        );
        // thêm lại vào state
        state.appAuthProvider.remove(AppAuthProvider.google);
        emit(state.copyWith(status: LinkedAccountStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: LinkedAccountStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
    on<UnLinkedAccountEmail>((event, emit) async {
      emit(state.copyWith(status: LinkedAccountStatus.loading));
      try {
        if (state.appAuthProvider.length == 1) {
          throw Exception(
            'Vui lòng liên kết với một tài khoản khác để tiếp tục',
          );
        }
        await userRepository.unLinkedAccount(
          authProvider: AppAuthProvider.email,
        );
        // thêm lại vào state
        state.appAuthProvider.remove(AppAuthProvider.email);
        emit(state.copyWith(status: LinkedAccountStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: LinkedAccountStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
