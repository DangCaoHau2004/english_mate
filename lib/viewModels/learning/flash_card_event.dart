abstract class FlashCardEvent {}

class SessionStarted extends FlashCardEvent {}

class CardFlipped extends FlashCardEvent {}

class WordMarkedAsKnown extends FlashCardEvent {}

class WordMarkedAsStillLearning extends FlashCardEvent {}

class AudioPlayed extends FlashCardEvent {}
