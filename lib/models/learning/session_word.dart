import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/words/word.dart';

class SessionWord {
  final Word word;
  final WordStatus wordStatus;
  final bool isStarred;
  SessionWord({
    required this.word,
    this.wordStatus = WordStatus.stillLearning,
    this.isStarred = false,
  });

  SessionWord copyWith({WordStatus? wordStatus, bool? isStarred}) =>
      SessionWord(
        word: word,
        wordStatus: wordStatus ?? this.wordStatus,
        isStarred: isStarred ?? this.isStarred,
      );
}
