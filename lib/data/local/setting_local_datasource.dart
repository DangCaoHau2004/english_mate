import 'package:shared_preferences/shared_preferences.dart';

class SettingLocalDatasource {
  static const _kIsFlippedDefault = 'is_flipped_default';
  static const _kShuffleFlashcards = 'shuffle_flashcards';

  final SharedPreferences prefs;
  SettingLocalDatasource({required this.prefs});

  bool get isFlippedDefault => prefs.getBool(_kIsFlippedDefault) ?? false;

  bool get shuffleFlashcards => prefs.getBool(_kShuffleFlashcards) ?? false;

  Future<bool> setIsFlippedDefault({required bool value}) {
    return prefs.setBool(_kIsFlippedDefault, value);
  }

  Future<bool> setShuffleFlashcards({required bool value}) {
    return prefs.setBool(_kShuffleFlashcards, value);
  }
}
