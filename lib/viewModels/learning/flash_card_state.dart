import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/viewModels/learning/session_word.dart';

// false là tiếng anh, true là tiếng việt
class FlashCardState {
  final LearningStatus learningStatus;
  final List<SessionWord> sessionWords;
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
  });

  FlashCardState copyWith({
    LearningStatus? learningStatus,
    List<SessionWord>? sessionWords,
    int? currentIndex,
    bool? isFlipped,
    String? errorMessage,
    bool? isFlippedDefault,
  }) {
    return FlashCardState(
      learningStatus: learningStatus ?? this.learningStatus,
      sessionWords: sessionWords ?? this.sessionWords,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      errorMessage: errorMessage ?? this.errorMessage,
      isFlippedDefault: isFlippedDefault ?? this.isFlippedDefault,
    );
  }
}
