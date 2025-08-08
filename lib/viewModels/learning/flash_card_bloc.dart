import 'package:audioplayers/audioplayers.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/viewModels/learning/flash_card_event.dart';
import 'package:english_mate/viewModels/learning/flash_card_state.dart';
import 'package:english_mate/viewModels/learning/session_word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardBloc extends Bloc<FlashCardEvent, FlashCardState> {
  List<SessionWord> sessionWords;
  bool isFlippedDefault;

  final AudioPlayer _audioPlayer = AudioPlayer();

  FlashCardBloc({required this.sessionWords, required this.isFlippedDefault})
    : super(
        FlashCardState(
          learningStatus: LearningStatus.inProgress,
          sessionWords: sessionWords,
          isFlipped: isFlippedDefault,
          isFlippedDefault: isFlippedDefault,
        ),
      ) {
    on<SessionStarted>((event, emit) {
      // khởi động lại bài học
    });
    on<CardFlipped>((event, emit) {
      emit(state.copyWith(isFlipped: !state.isFlipped));
    });
    on<WordMarkedAsKnown>((event, emit) {
      // bản sao toàn bộ từ và index
      final updatedWords = List<SessionWord>.from(state.sessionWords);
      final currentIndex = state.currentIndex;

      // cập nhật trạng thái của từ hiện tại thành biết
      updatedWords[currentIndex] = updatedWords[currentIndex].copyWith(
        wordStatus: WordStatus.known,
      );

      // tìm kiếm index tiếp theo
      int nextIndex = updatedWords.indexWhere(
        (word) => word.wordStatus == WordStatus.stillLearning,
        currentIndex + 1,
      );

      // Nếu không tìm thấy từ cuối danh sách, quay lại tìm từ đầu
      if (nextIndex == -1) {
        nextIndex = updatedWords.indexWhere(
          (word) => word.wordStatus == WordStatus.stillLearning,
        );
      }
      // 4. Phát ra state mới
      if (nextIndex == -1) {
        // Không còn từ nào để học -> phiên học hoàn tất
        emit(
          state.copyWith(
            learningStatus: LearningStatus.complete,
            sessionWords: updatedWords,
          ),
        );
      } else {
        // Chuyển đến từ tiếp theo
        emit(
          state.copyWith(
            sessionWords: updatedWords,
            currentIndex: nextIndex,
            isFlipped: state.isFlippedDefault,
          ),
        );
      }
    });
    on<WordMarkedAsStillLearning>((event, emit) {
      final currentIndex = state.currentIndex;

      // tìm index từ tiếp theo
      int nextIndex = state.sessionWords.indexWhere(
        (word) => word.wordStatus == WordStatus.stillLearning,
        currentIndex + 1,
      );

      if (nextIndex == -1) {
        nextIndex = state.sessionWords.indexWhere(
          (word) => word.wordStatus == WordStatus.stillLearning,
        );
      }
      // nếu ko thể tìm index từ tiếp theo hoặc index nó chính bằng từ hiện tại thì ko làm gì cả
      if (nextIndex == currentIndex || nextIndex == -1) {
        return;
      }
      emit(
        state.copyWith(
          currentIndex: nextIndex,
          isFlipped: state.isFlippedDefault,
        ),
      );
    });
    on<AudioPlayed>((event, emit) {
      _audioPlayer.play(
        AssetSource(
          AssetHelper.getAudio(
            state.sessionWords[state.currentIndex].word.audioPronunciation,
          ),
        ),
      );
    });
  }
}
