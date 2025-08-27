import 'package:english_mate/core/enums/app_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingLocalDatasource {
  static const _kIsFlippedDefault = 'is_flipped_default';
  static const _kShuffleFlashcards = 'shuffle_flashcards';
  static const _kCurrentLanguage = 'app_theme_mode';
  final SharedPreferences prefs;
  SettingLocalDatasource({required this.prefs});

  bool get isFlippedDefault => prefs.getBool(_kIsFlippedDefault) ?? false;

  bool get shuffleFlashcards => prefs.getBool(_kShuffleFlashcards) ?? false;
  String get appThemeMode =>
      prefs.getString(_kCurrentLanguage) ?? AppThemeMode.light.name;
  Future<bool> setIsFlippedDefault({required bool value}) {
    return prefs.setBool(_kIsFlippedDefault, value);
  }

  Future<bool> setShuffleFlashcards({required bool value}) {
    return prefs.setBool(_kShuffleFlashcards, value);
  }

  Future<bool> setAppThemeMode({required String value}) {
    return prefs.setString(_kCurrentLanguage, value);
  }
}
