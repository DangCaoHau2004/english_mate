import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/models/learning/learning_progress.dart';
import 'package:english_mate/utils/auth_error_converter.dart';

class LearningProgressDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LearningProgressDatasource();
  Future<void> updateLearningProgress({
    required LearningProgress learningProgress,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(learningProgress.userId)
          .collection("progress")
          .doc(learningProgress.wordId)
          .set(learningProgress.toJson());
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> createCollectionWordProgress({
    required String userId,
    required List<String> wordIds,
  }) async {
    try {
      for (var wordId in wordIds) {
        await _firestore
            .collection("users")
            .doc(userId)
            .collection("progress")
            .doc(wordId)
            .set({"isStarred": false});
      }
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<bool> checkUnitFirstTimeLearningUnit({
    required String userId,
    required String unitId,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("progress")
          .where("unitId", isEqualTo: unitId)
          .limit(1)
          .get();
      return querySnapshot.docs.isEmpty;
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> setWordStarred({
    required String userId,
    required String wordId,
    required bool isStarred,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("progress")
          .doc(wordId)
          .update({"isStarred": isStarred});
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> updateDefaultUnitLearningProgress({
    required List<String> wordIds,
    required String userId,
    required String unitId,
  }) async {
    try {
      for (var wordId in wordIds) {
        await _firestore
            .collection("users")
            .doc(userId)
            .collection("progress")
            .doc(wordId)
            .update({
              "unitId": unitId,
              "updatedAt": DateTime.now(),
              "mastery": 0,
              "streakCorrect": 0,
              "totalAttempts": 0,
            });
      }
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<LearningProgress> getLearningProgressByWord({
    required String userId,
    required String wordId,
  }) async {
    try {
      final doc = await _firestore
          .collection("users")
          .doc(userId)
          .collection("progress")
          .doc(wordId)
          .get();
      return LearningProgress.fromFirestore(
        doc: doc,
        userId: userId,
        wordId: wordId,
      );
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<List<LearningProgress>> getLearningProgressByUnit({
    required String userId,
    required String unitId,
  }) {
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection("progress")
          .where("unitId", isEqualTo: unitId)
          .get()
          .then(
            (querySnapshot) => querySnapshot.docs
                .map(
                  (doc) => LearningProgress.fromFirestore(
                    doc: doc,
                    userId: userId,
                    wordId: doc.id,
                  ),
                )
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }
}
