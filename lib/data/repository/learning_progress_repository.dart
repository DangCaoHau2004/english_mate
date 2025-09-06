import 'package:english_mate/data/network/learning_progress_datasource.dart';
import 'package:english_mate/models/learning/learning_progress.dart';

class LearningProgressRepository {
  final LearningProgressDatasource _learningProgressDatasource;
  LearningProgressRepository({
    required LearningProgressDatasource learningProgressDatasource,
  }) : _learningProgressDatasource = learningProgressDatasource;

  Future<void> updateListLearningProgress({
    required List<LearningProgress> learningProgress,
  }) async {
    for (var i = 0; i < learningProgress.length; i++) {
      await _learningProgressDatasource.updateLearningProgress(
        learningProgress: learningProgress[i],
      );
    }
  }

  Future<bool> checkUnitFirstTimeLearningUnit({
    required String userId,
    required String unitId,
  }) async {
    return _learningProgressDatasource.checkUnitFirstTimeLearningUnit(
      userId: userId,
      unitId: unitId,
    );
  }

  Future<void> setWordStarred({
    required String userId,
    required String wordId,
    required bool isStarred,
  }) async {
    await _learningProgressDatasource.setWordStarred(
      userId: userId,
      wordId: wordId,
      isStarred: isStarred,
    );
  }

  Future<void> createCollectionWordProgress({
    required String userId,
    required List<String> wordIds,
  }) async {
    await _learningProgressDatasource.createCollectionWordProgress(
      userId: userId,
      wordIds: wordIds,
    );
  }

  Future<void> updateDefaultUnitLearningProgress({
    required List<String> wordIds,
    required String userId,
    required String unitId,
  }) async {
    await _learningProgressDatasource.updateDefaultUnitLearningProgress(
      wordIds: wordIds,
      userId: userId,
      unitId: unitId,
    );
  }

  Future<void> updateLearningProgress({
    required LearningProgress learningProgress,
  }) async {
    await _learningProgressDatasource.updateLearningProgress(
      learningProgress: learningProgress,
    );
  }

  Future<List<LearningProgress>> getLearningProgressByUnit({
    required String userId,
    required String unitId,
  }) async {
    return _learningProgressDatasource.getLearningProgressByUnit(
      userId: userId,
      unitId: unitId,
    );
  }

  Future<LearningProgress> getLearningProgressByWord({
    required String userId,
    required String wordId,
  }) async {
    return _learningProgressDatasource.getLearningProgressByWord(
      userId: userId,
      wordId: wordId,
    );
  }
}
