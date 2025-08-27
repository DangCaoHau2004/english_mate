import 'package:english_mate/core/enums/app_enums.dart';

class SettingsState {
  final bool isFlippedDefault;
  final bool isShuffleFlashCards;
  final AppThemeMode appThemeMode;
  SettingsState({
    required this.isFlippedDefault,
    required this.isShuffleFlashCards,
    required this.appThemeMode,
  });
  SettingsState copyWith({
    bool? isFlippedDefault,
    bool? isShuffleFlashCards,
    AppThemeMode? appThemeMode,
  }) {
    return SettingsState(
      isFlippedDefault: isFlippedDefault ?? this.isFlippedDefault,
      isShuffleFlashCards: isShuffleFlashCards ?? this.isShuffleFlashCards,
      appThemeMode: appThemeMode ?? this.appThemeMode,
    );
  }
}
