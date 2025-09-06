import 'package:audioplayers/audioplayers.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/data/repository/learning_progress_repository.dart';
import 'package:english_mate/models/learning/learning_progress.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_event.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_state.dart';
import 'package:english_mate/models/learning/session_word.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCardBloc extends Bloc<FlashCardEvent, FlashCardState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final LearningProgressRepository _learningProgressRepository;

  FlashCardBloc({
    required List<SessionWord> sessionWords,
    required bool isFlippedDefault,
    required LearningProgressRepository learningProgressRepository,
  }) : _learningProgressRepository = learningProgressRepository,
       super(
         FlashCardState(
           learningStatus: LearningStatus.inProgress,
           sessionWords: sessionWords,
           isFlipped: isFlippedDefault,
           isFlippedDefault: isFlippedDefault,
         ),
       ) {
    on<CheckUnitFirstTimeLearningUnit>((event, emit) async {
      emit(state.copyWith(learningStatus: LearningStatus.loading));
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        String unitId = state.sessionWordsDefault.first.word.unitId;
        bool isFirstTime = await _learningProgressRepository
            .checkUnitFirstTimeLearningUnit(userId: userId, unitId: unitId);
        if (isFirstTime) {
          List<String> wordIds = state.sessionWords
              .map((sw) => sw.word.wordId)
              .toList();

          await _learningProgressRepository.createCollectionWordProgress(
            userId: userId,
            wordIds: wordIds,
          );
          emit(
            state.copyWith(
              isFirstTime: isFirstTime,
              learningStatus: LearningStatus.initial,
            ),
          );
          return;
        }
        List<LearningProgress> progresses = await _learningProgressRepository
            .getLearningProgressByUnit(userId: userId, unitId: unitId);
        final byId = {for (final p in progresses) p.wordId: p};
        final sessionWords = List<SessionWord>.from(state.sessionWords);
        final sessionDefault = List<SessionWord>.from(
          state.sessionWordsDefault,
        );

        final nextSession = sessionWords.map((sw) {
          final progress = byId[sw.word.wordId];
          return sw.copyWith(isStarred: progress?.isStarred ?? sw.isStarred);
        });
        final nextDefault = sessionDefault.map((sw) {
          final progress = byId[sw.word.wordId];
          return sw.copyWith(isStarred: progress?.isStarred ?? sw.isStarred);
        });
        ;
        emit(
          state.copyWith(
            sessionWords: nextSession.toList(),
            sessionWordsDefault: nextDefault.toList(),

            learningStatus: LearningStatus.initial,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            errorMessage: e.toString(),
            learningStatus: LearningStatus.failure,
          ),
        );
      }
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
      // thêm word id vào history
      final newHistory = List<String>.from(state.historyWordIds)
        ..add(updatedWords[currentIndex].word.wordId);
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
      // Phát ra state mới
      if (nextIndex == -1) {
        // Không còn từ nào để học -> phiên học hoàn tất
        emit(
          state.copyWith(
            learningStatus: LearningStatus.complete,
            sessionWords: updatedWords,
            historyWordIds: newHistory,
          ),
        );
      } else {
        // Chuyển đến từ tiếp theo
        emit(
          state.copyWith(
            sessionWords: updatedWords,
            currentIndex: nextIndex,
            isFlipped: state.isFlippedDefault,
            historyWordIds: newHistory,
          ),
        );
      }
    });
    on<WordMarkedAsStillLearning>((event, emit) {
      final currentIndex = state.currentIndex;
      //thêm id vào history
      final newHistory = List<String>.from(state.historyWordIds)
        ..add(state.sessionWords[currentIndex].word.wordId);

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
          historyWordIds: newHistory,
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
    on<DefaultFlipToggled>((event, emit) {
      emit(state.copyWith(isFlippedDefault: event.value));
    });
    on<ShuffleToggled>((event, emit) {
      final order = <String, int>{
        for (var i = 0; i < state.sessionWordsDefault.length; i++)
          state.sessionWordsDefault[i].word.wordId: i,
      };

      // clone danh sách hiện tại rồi sắp xếp theo thứ tự gốc
      final reordered = List<SessionWord>.from(
        state.sessionWords,
      )..sort((a, b) => order[a.word.wordId]!.compareTo(order[b.word.wordId]!));

      // TẮT SHUFFLE: không đổi currentIndex
      if (!event.enabled) {
        emit(
          state.copyWith(
            sessionWords: reordered,
            currentIndex: state.currentIndex, // giữ nguyên index (số)
            isFlipped: state.isFlippedDefault,
          ),
        );
        return;
      }

      // BẬT SHUFFLE: trộn và đổi currentIndex
      reordered.shuffle();

      // lấy id current từ danh sách hiện tại trước khi trộn
      final currId = state.sessionWords.isEmpty
          ? null
          : state.sessionWords[state.currentIndex].word.wordId;

      int newIndex = -1;

      if (currId != null) {
        // ưu tiên phần tử stillLearning và khác currId
        newIndex = reordered.indexWhere(
          (sw) =>
              sw.word.wordId != currId &&
              sw.wordStatus == WordStatus.stillLearning,
        );
        if (newIndex == -1) {
          // nếu không có stillLearning thì lấy phần tử khác currId bất kỳ
          newIndex = state.currentIndex;
        }
      }

      // nếu danh sách chỉ có 1 phần tử hoặc không tìm ra cái khác -> rơi về 0 (hoặc giữ nguyên tùy ý)
      if (newIndex == -1) newIndex = 0;

      emit(
        state.copyWith(
          sessionWords: reordered,
          currentIndex: newIndex,
          isFlipped: state.isFlippedDefault,
        ),
      );
    });

    on<BackPressed>((event, emit) {
      if (state.historyWordIds.isEmpty || state.currentIndex == -1) return;
      String lastWordId = state.historyWordIds.last;
      int index = state.sessionWords.indexWhere(
        (sw) => sw.word.wordId == lastWordId,
      );
      // xóa bỏ từ cuối của history
      final newHistory = List<String>.from(state.historyWordIds)..removeLast();

      // sửa lại thành stillLearning
      final newWords = List<SessionWord>.from(state.sessionWords);
      newWords[index] = newWords[index].copyWith(
        wordStatus: WordStatus.stillLearning,
      );
      emit(
        state.copyWith(
          currentIndex: index,
          isFlipped: state.isFlippedDefault,
          historyWordIds: newHistory,
          sessionWords: newWords,
        ),
      );
    });
    on<SessionRefreshed>((event, emit) {
      List<SessionWord> newSessionWords = [];
      for (var i = 0; i < state.sessionWords.length; i++) {
        newSessionWords.add(
          state.sessionWords[i].copyWith(wordStatus: WordStatus.stillLearning),
        );
      }
      emit(
        state.copyWith(
          sessionWords: newSessionWords,
          historyWordIds: [],
          currentIndex: 0,
          isFlipped: state.isFlippedDefault,
          learningStatus: LearningStatus.inProgress,
        ),
      );
    });

    on<UpdateUnitLearningProgress>((event, emit) async {
      if (state.isFirstTime) {
        emit(state.copyWith(learningStatus: LearningStatus.loading));
        try {
          List<String> wordIds = state.sessionWords
              .map((sw) => sw.word.wordId)
              .toList();
          String userId = FirebaseAuth.instance.currentUser!.uid;
          _learningProgressRepository.updateDefaultUnitLearningProgress(
            wordIds: wordIds,
            userId: userId,
            unitId: state.sessionWordsDefault.first.word.unitId,
          );
          emit(state.copyWith(learningStatus: LearningStatus.complete));
        } catch (e) {
          emit(
            state.copyWith(
              learningStatus: LearningStatus.failure,
              errorMessage: e.toString(),
            ),
          );
        }
      }
    });

    on<SetWordStarred>((event, emit) async {
      try {
        final idx = state.currentIndex;
        if (idx < 0 || idx >= state.sessionWords.length) return;

        // Lấy item hiện tại từ STATE (tránh lệch so với event)
        final current = state.sessionWords[idx];
        final bool newValue = !current.isStarred;

        final next = List<SessionWord>.from(state.sessionWords);
        next[idx] = current.copyWith(isStarred: newValue);

        final nextDefault = List<SessionWord>.from(state.sessionWordsDefault);
        final dIdx = nextDefault.indexWhere(
          (sw) => sw.word.wordId == current.word.wordId,
        );
        if (dIdx != -1) {
          nextDefault[dIdx] = nextDefault[dIdx].copyWith(isStarred: newValue);
        }

        emit(
          state.copyWith(sessionWords: next, sessionWordsDefault: nextDefault),
        );

        final uid = FirebaseAuth.instance.currentUser!.uid;
        await _learningProgressRepository.setWordStarred(
          wordId: current.word.wordId,
          isStarred: newValue,
          userId: uid,
        );
      } catch (e) {
        emit(
          state.copyWith(
            learningStatus: LearningStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    });
  }
}
