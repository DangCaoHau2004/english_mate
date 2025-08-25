import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_event.dart';
import 'package:english_mate/viewModels/editProfile/linkedAccount/linked_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkedAccountBloc extends Bloc<LinkedAccountEvent, LinkedAccountState> {
  LinkedAccountBloc()
    : super(LinkedAccountState(linkedAccount: LinkedAccount.initial));
}
