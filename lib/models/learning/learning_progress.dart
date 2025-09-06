import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/core/enums/app_enums.dart';

class LearningProgress {
  final String userId;
  final String wordId;
  final String unitId;
  final bool isStarred; // có là từ khó
  final int mastery;
  final int streakCorrect;
  final int totalAttempts;
  final DateTime updatedAt;

  LearningProgress({
    required this.userId,
    required this.wordId,
    required this.unitId,
    required this.isStarred,
    required this.mastery,
    required this.streakCorrect,
    required this.totalAttempts,
    required this.updatedAt,
  });

  LearningProgress copyWith({
    String? wordId,
    LearningProgressStatus? status,
    bool? isStarred,
    int? mastery,
    int? streakCorrect,
    int? totalAttempts,
    String? unitId,
  }) {
    return LearningProgress(
      userId: userId,
      wordId: wordId ?? this.wordId,
      unitId: unitId ?? this.unitId,
      isStarred: isStarred ?? this.isStarred,
      mastery: mastery ?? this.mastery,
      streakCorrect: streakCorrect ?? this.streakCorrect,
      totalAttempts: totalAttempts ?? this.totalAttempts,
      updatedAt: DateTime.now(),
    );
  }

  factory LearningProgress.fromFirestore({
    // Sửa: Bỏ một cặp dấu ngoặc nhọn {{}} thừa
    required DocumentSnapshot<Map<String, dynamic>> doc,
    required String userId,
    required String wordId,
  }) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Không có dữ liệu trong tài liệu!");
    }

    return LearningProgress(
      userId: userId,
      wordId: wordId,

      unitId: data['unitId'],

      isStarred: data['isStarred'] ?? false,

      mastery: data['mastery']?.toInt() ?? 0,

      streakCorrect: data['streakCorrect']?.toInt() ?? 0,
      totalAttempts: data['totalAttempts']?.toInt() ?? 0,
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wordId': wordId,
      'unitId': unitId,
      'isStarred': isStarred,
      'mastery': mastery,
      'streakCorrect': streakCorrect,
      'totalAttempts': totalAttempts,
      'updatedAt': DateTime.now(),
    };
  }
}
