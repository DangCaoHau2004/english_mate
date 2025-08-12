class SettingsState {
  final bool isFlippedDefault;
  final bool isShuffleFlashCards;

  SettingsState({
    required this.isFlippedDefault,
    required this.isShuffleFlashCards,
  });
  SettingsState copyWith({bool? isFlippedDefault, bool? isShuffleFlashCards}) {
    return SettingsState(
      isFlippedDefault: isFlippedDefault ?? this.isFlippedDefault,
      isShuffleFlashCards: isShuffleFlashCards ?? this.isShuffleFlashCards,
    );
  }
}
