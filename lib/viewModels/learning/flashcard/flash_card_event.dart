abstract class FlashCardEvent {}

class DefaultFlipToggled extends FlashCardEvent {
  final bool value;
  DefaultFlipToggled({required this.value});
}

class ShuffleToggled extends FlashCardEvent {
  final bool enabled;
  ShuffleToggled({required this.enabled});
}

class CardFlipped extends FlashCardEvent {}

class WordMarkedAsKnown extends FlashCardEvent {}

class WordMarkedAsStillLearning extends FlashCardEvent {}

class AudioPlayed extends FlashCardEvent {}

class BackPressed extends FlashCardEvent {}

class SessionRefreshed extends FlashCardEvent {}
