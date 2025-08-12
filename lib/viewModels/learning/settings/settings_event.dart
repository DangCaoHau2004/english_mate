abstract class SettingsEvent {}

class SettingsFlippedDefaultChanged extends SettingsEvent {
  bool flippedDefault;

  SettingsFlippedDefaultChanged({required this.flippedDefault});
}

class SettingsShuffleFlashCardsChanged extends SettingsEvent {
  bool shuffleFlashCards;

  SettingsShuffleFlashCardsChanged({required this.shuffleFlashCards});
}
