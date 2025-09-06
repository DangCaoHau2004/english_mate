import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/generated/fonts.gen.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/utils/string_utils.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_event.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_state.dart';
import 'package:english_mate/models/learning/session_word.dart';
import 'package:english_mate/viewModels/learning/settings/settings_bloc.dart';
import 'package:english_mate/views/learning/flash_card_setting_dialog.dart';
import 'package:english_mate/views/learning/report_word_dialog_view.dart';
import 'package:english_mate/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

class FlaskCardView extends StatefulWidget {
  const FlaskCardView({super.key});

  @override
  State<FlaskCardView> createState() => _FlaskCardViewState();
}

class _FlaskCardViewState extends State<FlaskCardView>
    with TickerProviderStateMixin {
  // Controller cho việc LẬT thẻ
  late AnimationController _flipController;
  // Controller cho việc VUỐT thẻ
  late AnimationController _swipeController;
  late Animation<Offset> _swipeAnimation;
  // State cho việc vuốt
  Offset _dragOffset = Offset.zero;
  int? _lastIndex;
  @override
  void initState() {
    super.initState();
    _lastIndex = context.read<FlashCardBloc>().state.currentIndex;
    final initialBlocState = context.read<FlashCardBloc>().state;

    // Khởi tạo controller cho việc lật
    _flipController = AnimationController(
      value: initialBlocState.isFlipped ? 1.0 : 0.0,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Khởi tạo controller cho việc vuốt
    _swipeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Listener cho animation vuốt
    _swipeController.addListener(() {
      setState(() {
        _dragOffset = _swipeAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    _swipeController.dispose();
    super.dispose();
  }

  // logic lật thẻ
  void _handleTap() {
    context.read<FlashCardBloc>().add(CardFlipped());
  }

  // hàm phát tiếng của từ
  void _playAudioPronunciation() {
    context.read<FlashCardBloc>().add(AudioPlayed());
  }

  // hàm lưu vào dạng từ có dấu sao
  void _saveWord(SessionWord sessionWord) {
    context.read<FlashCardBloc>().add(SetWordStarred(sessionWord: sessionWord));
  }

  // hàm quay trở lại thẻ trước đó
  void _goToPreviousCard() {
    context.read<FlashCardBloc>().add(BackPressed());
  }

  // hàm báo cáo từ
  void _reportWord() {
    final bloc = context.read<FlashCardBloc>();
    final curIndex = bloc.state.currentIndex;
    final word = bloc.state.sessionWords[curIndex].word;

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => ReportWordDialogView(word: word),
    );
  }

  // đặt lại từ
  void _resetWord() {
    context.read<FlashCardBloc>().add(SessionRefreshed());
  }

  // hàm mở chi tiết từ vựng
  void _openDetailOfWord() {
    int curIndex = context.read<FlashCardBloc>().state.currentIndex;
    Word word = context.read<FlashCardBloc>().state.sessionWords[curIndex].word;
    context.push(RoutePath.wordDetail, extra: word);
  }

  Widget _buildFront(SessionWord sessionWord) {
    String image = AssetHelper.getImage(sessionWord.word.image);
    String word = StringUtils.capitalizeFirstLetter(sessionWord.word.term);
    String example = StringUtils.capitalizeFirstLetter(
      sessionWord.word.example,
    );
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _playAudioPronunciation,
                  icon: const Icon(Icons.volume_up),
                ),

                IconButton(
                  onPressed: () {
                    _saveWord(sessionWord);
                  },
                  icon: sessionWord.isStarred
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_border),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(image, height: 300),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    word,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    example,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack(SessionWord sessionWord) {
    String word = StringUtils.capitalizeFirstLetter(sessionWord.word.term);
    String phonetic = sessionWord.word.phonetic;
    String definitionVi = StringUtils.capitalizeFirstLetter(
      sessionWord.word.definitionVi,
    );
    String pos = StringUtils.capitalizeFirstLetter(
      sessionWord.word.partOfSpeech,
    );
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Phần trên cùng: nút Xem chi tiết
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _openDetailOfWord,
                  child: const Text("Xem chi tiết"),
                ),
              ),

              const SizedBox(height: 8),

              // Phần nội dung căn giữa
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        word,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pos,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        phonetic,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: FontFamily.libertinusSans,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        definitionVi,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    final swipeThreshold = MediaQuery.of(context).size.width / 3;
    if (_dragOffset.dx.abs() > swipeThreshold) {
      final direction = _dragOffset.dx > 0 ? 'Phải' : 'Trái';
      _animateCardOffscreen(direction);
    } else {
      _animateCardBackToCenter();
    }
  }

  void _animateCardOffscreen(String direction) {
    final screenWidth = MediaQuery.of(context).size.width;
    final endDx = direction == 'Phải' ? screenWidth : -screenWidth;

    _swipeAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(endDx, _dragOffset.dy),
    ).animate(CurvedAnimation(parent: _swipeController, curve: Curves.easeIn));

    _swipeController.forward().then((_) {
      if (direction == 'Phải') {
        context.read<FlashCardBloc>().add(WordMarkedAsKnown());
      } else {
        context.read<FlashCardBloc>().add(WordMarkedAsStillLearning());
      }
    });
  }

  void _animateCardBackToCenter() {
    _swipeAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _swipeController, curve: Curves.elasticOut),
        );

    _swipeController.forward().then((_) {
      _swipeController.reset();
      setState(() {
        _dragOffset = Offset.zero;
      });
    });
  }

  void _openSetting() {
    final settingsBloc = context.read<SettingsBloc>();
    final flashCardBloc = context.read<FlashCardBloc>();

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: settingsBloc),
          BlocProvider.value(value: flashCardBloc),
        ],
        child: const Dialog(child: FlashCardSettingDialog()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlashCardBloc, FlashCardState>(
      listenWhen: (previous, current) {
        return previous.isFlipped != current.isFlipped ||
            previous.currentIndex != current.currentIndex;
      },
      listener: (context, state) {
        // tiếng anh là false còn tiếng việt là true
        final indexChanged = _lastIndex != state.currentIndex;

        if (indexChanged) {
          _flipController.stop();
          _flipController.value = state.isFlipped ? 1.0 : 0.0;
        } else {
          if (state.isFlipped) {
            _flipController.forward();
          } else {
            _flipController.reverse();
          }
        }

        _lastIndex = state.currentIndex;

        setState(() {
          _dragOffset = Offset.zero; // reset kéo
        });
      },
      buildWhen: (previous, current) {
        return previous.currentIndex != current.currentIndex ||
            previous.learningStatus != current.learningStatus ||
            previous.sessionWords != current.sessionWords;
      },
      builder: (context, state) {
        // Tính toán các giá trị cần thiết từ state
        final wordCount = state.sessionWords.length;
        final knowWord = state.sessionWords
            .where((word) => word.wordStatus == WordStatus.known)
            .length;
        final unKnowWord = wordCount - knowWord;
        bool isComplete = state.learningStatus == LearningStatus.complete;
        if (isComplete) {
          // ghi lại data các từ vựng lên firebase
          context.read<FlashCardBloc>().add(UpdateUnitLearningProgress());
        } else if (state.learningStatus == LearningStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Lỗi không xác định")),
          );
        }

        return state.learningStatus == LearningStatus.loading
            ? const LoadingScreen()
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  centerTitle: true,
                  title: Text(
                    wordCount > 0 ? "$knowWord/$wordCount" : "...",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  actions: [
                    IconButton(
                      onPressed: _openSetting,
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
                body: (isComplete || state.sessionWords.isEmpty)
                    // Hiển thị khi phiên học kết thúc hoặc chưa bắt đầu
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Chúc mừng, bạn đã hoàn thành!",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: _resetWord,
                              child: Text(
                                "Đặt lại",
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.tertiary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                    // Hiển thị giao diện học chính
                    : Column(
                        children: [
                          LinearProgressIndicator(
                            value: wordCount > 0 ? knowWord / wordCount : 0,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary.withAlpha(50),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.surface,
                            ),
                            minHeight: 5,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Cụm "Đang học"
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primaryContainer,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        unKnowWord.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primaryContainer,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Đang học',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primaryContainer,
                                          ),
                                    ),
                                  ],
                                ),
                                // Cụm "Đã biết"
                                Row(
                                  children: [
                                    Text(
                                      'Đã biết',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondaryContainer,
                                          ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        knowWord.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondaryContainer,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: GestureDetector(
                                onTap: _handleTap,
                                onHorizontalDragUpdate: _onDragUpdate,
                                onHorizontalDragEnd: _onDragEnd,
                                child: Transform.translate(
                                  offset: _dragOffset,
                                  child: Transform.rotate(
                                    angle:
                                        _dragOffset.dx /
                                        (MediaQuery.of(context).size.width / 2),
                                    child: AnimatedBuilder(
                                      animation: _flipController,
                                      builder: (context, child) {
                                        final sessionWord = state
                                            .sessionWords[state.currentIndex];
                                        final angle =
                                            _flipController.value * math.pi;
                                        final isFront =
                                            _flipController.value <= 0.5;

                                        Widget content = isFront
                                            ? _buildFront(sessionWord)
                                            : Transform(
                                                alignment: Alignment.center,
                                                transform: Matrix4.rotationY(
                                                  math.pi,
                                                ),
                                                child: _buildBack(sessionWord),
                                              );

                                        return Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.identity()
                                            ..setEntry(3, 2, 0.001)
                                            ..rotateY(angle),
                                          child: content,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: state.historyWordIds.isEmpty
                                      ? null
                                      : _goToPreviousCard,
                                  icon: const Icon(Icons.replay),
                                ),
                                Text(
                                  "Nhấn để lật hoặc vuốt",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                IconButton(
                                  onPressed: _reportWord,
                                  icon: const Icon(
                                    Icons.report_gmailerrorred_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              );
      },
    );
  }
}
