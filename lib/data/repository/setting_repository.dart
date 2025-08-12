import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  final SharedPreferences prefs;
  SettingRepository({required this.prefs});
  bool get isFlippedDefault => prefs.getBool('is_flipped_default') ?? false;

  bool get shuffleFlashcards => prefs.getBool('shuffle_flashcards') ?? false;

  Future<void> setIsFlippedDefault({required bool value}) async =>
      prefs.setBool('is_flipped_default', value);

  Future<void> setShuffleFlashcards({required bool value}) async =>
      prefs.setBool('shuffle_flashcards', value);
}
