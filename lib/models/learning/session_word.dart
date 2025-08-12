import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/words/word.dart';

class SessionWord {
  final Word word;
  final WordStatus wordStatus;
  SessionWord({required this.word, this.wordStatus = WordStatus.stillLearning});

  SessionWord copyWith({WordStatus? wordStatus}) =>
      SessionWord(word: word, wordStatus: wordStatus ?? this.wordStatus);
}
