import 'package:english_mate/viewModels/learning/settings/settings_event.dart';
import 'package:english_mate/viewModels/learning/settings/settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_mate/data/repository/setting_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingRepository settingRepository;

  SettingsBloc({
    required this.settingRepository,
    required bool isFlippedDefault,
    required bool isShuffleFlashCards,
  }) : super(
         SettingsState(
           isFlippedDefault: isFlippedDefault,
           isShuffleFlashCards: isShuffleFlashCards,
         ),
       ) {
    on<SettingsFlippedDefaultChanged>((event, emit) {
      emit(state.copyWith(isFlippedDefault: event.flippedDefault));
      settingRepository.setIsFlippedDefault(value: event.flippedDefault);
    });
    on<SettingsShuffleFlashCardsChanged>((event, emit) {
      emit(state.copyWith(isShuffleFlashCards: event.shuffleFlashCards));
      settingRepository.setShuffleFlashcards(value: event.shuffleFlashCards);
    });
  }
}
