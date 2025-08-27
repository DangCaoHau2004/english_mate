import 'package:english_mate/core/enums/app_enums.dart';

abstract class SettingsEvent {}

class SettingsFlippedDefaultChanged extends SettingsEvent {
  bool flippedDefault;

  SettingsFlippedDefaultChanged({required this.flippedDefault});
}

class SettingsShuffleFlashCardsChanged extends SettingsEvent {
  bool shuffleFlashCards;

  SettingsShuffleFlashCardsChanged({required this.shuffleFlashCards});
}

class ThemeChanged extends SettingsEvent {
  AppThemeMode appThemeMode;

  ThemeChanged({required this.appThemeMode});
}
