import 'package:english_mate/data/local/setting_local_datasource.dart';

class SettingRepository {
  final SettingLocalDatasource local;
  SettingRepository({required this.local});

  bool get isFlippedDefault => local.isFlippedDefault;

  bool get shuffleFlashcards => local.shuffleFlashcards;

  Future<bool> setIsFlippedDefault({required bool value}) {
    return local.setIsFlippedDefault(value: value);
  }

  Future<bool> setShuffleFlashcards({required bool value}) {
    return local.setShuffleFlashcards(value: value);
  }
}
