import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/learning/session_word.dart';

class FlashCardState {
  final LearningStatus learningStatus;
  final List<SessionWord> sessionWords;
  final List<SessionWord> sessionWordsDefault;
  final int currentIndex;
  final bool isFlipped;
  final bool isFlippedDefault;
  final String? errorMessage;
  FlashCardState({
    required this.learningStatus,
    required this.sessionWords,
    this.isFlipped = false,
    this.currentIndex = 0,
    this.errorMessage,
    this.isFlippedDefault = false,
  }) : sessionWordsDefault = [...sessionWords];

  FlashCardState._({
    required this.learningStatus,
    required this.sessionWords,
    required this.sessionWordsDefault,
    required this.currentIndex,
    required this.isFlipped,
    required this.isFlippedDefault,
    required this.errorMessage,
  });
  FlashCardState copyWith({
    LearningStatus? learningStatus,
    List<SessionWord>? sessionWords,
    int? currentIndex,
    bool? isFlipped,
    String? errorMessage,
    bool? isFlippedDefault,
  }) {
    return FlashCardState._(
      learningStatus: learningStatus ?? this.learningStatus,
      sessionWords: sessionWords ?? this.sessionWords,
      sessionWordsDefault: sessionWordsDefault,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      errorMessage: errorMessage ?? this.errorMessage,
      isFlippedDefault: isFlippedDefault ?? this.isFlippedDefault,
    );
  }
}
