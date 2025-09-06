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
  final List<String> historyWordIds;
  final bool isFirstTime;
  FlashCardState({
    required this.learningStatus,
    required this.sessionWords,
    this.isFlipped = false,
    this.currentIndex = 0,
    this.errorMessage,
    this.isFlippedDefault = false,
    List<String>? historyWordIds,
    this.isFirstTime = true,
  }) : historyWordIds = [...(historyWordIds ?? [])],
       sessionWordsDefault = [...sessionWords];

  FlashCardState._({
    required this.learningStatus,
    required this.sessionWords,
    required this.sessionWordsDefault,
    required this.currentIndex,
    required this.isFlipped,
    required this.isFlippedDefault,
    required this.errorMessage,
    required this.historyWordIds,
    required this.isFirstTime,
  });
  FlashCardState copyWith({
    LearningStatus? learningStatus,
    List<SessionWord>? sessionWords,
    List<SessionWord>? sessionWordsDefault,
    int? currentIndex,
    bool? isFlipped,
    String? errorMessage,
    bool? isFlippedDefault,
    List<String>? historyWordIds,
    bool? isFirstTime,
  }) {
    return FlashCardState._(
      learningStatus: learningStatus ?? this.learningStatus,
      sessionWords: sessionWords ?? this.sessionWords,
      sessionWordsDefault: sessionWordsDefault ?? this.sessionWordsDefault,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      errorMessage: errorMessage ?? this.errorMessage,
      isFlippedDefault: isFlippedDefault ?? this.isFlippedDefault,
      historyWordIds: historyWordIds ?? this.historyWordIds,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }
}
