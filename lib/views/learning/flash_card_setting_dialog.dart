import 'package:english_mate/viewModels/learning/flashcard/flash_card_bloc.dart';
import 'package:english_mate/viewModels/learning/flashcard/flash_card_event.dart';
import 'package:english_mate/viewModels/learning/settings/settings_bloc.dart';
import 'package:english_mate/viewModels/learning/settings/settings_event.dart';
import 'package:english_mate/viewModels/learning/settings/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CardFaceLanguage { english, vietnamese }

class FlashCardSettingDialog extends StatefulWidget {
  const FlashCardSettingDialog({super.key});

  @override
  State<FlashCardSettingDialog> createState() => _FlashCardSettingDialogState();
}

class _FlashCardSettingDialogState extends State<FlashCardSettingDialog> {
  final List<Widget> _languageOptions = const [
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text("Tiếng Anh"),
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text("Tiếng Việt"),
    ),
  ];

  Widget _buildSettingRow({required String title, required Widget control}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        control,
      ],
    );
  }

  CardFaceLanguage _fromBool(bool isFlippedDefault) =>
      isFlippedDefault ? CardFaceLanguage.vietnamese : CardFaceLanguage.english;
  bool _toBool(CardFaceLanguage lang) => lang == CardFaceLanguage.vietnamese;

  void _shuffleCards(bool enabled) {
    // cập nhật setting
    context.read<SettingsBloc>().add(
      SettingsShuffleFlashCardsChanged(shuffleFlashCards: enabled),
    );
    // áp dụng ngay cho phiên hiện tại
    context.read<FlashCardBloc>().add(ShuffleToggled(enabled: enabled));
  }

  void _setFrontCardLanguage(CardFaceLanguage language) {
    final isFlipDefault = _toBool(language);
    // lưu setting
    context.read<SettingsBloc>().add(
      SettingsFlippedDefaultChanged(flippedDefault: isFlipDefault),
    );
    // áp dụng ngay cho flashcard
    context.read<FlashCardBloc>().add(DefaultFlipToggled(value: isFlipDefault));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      // chỉ cần rebuild khi các field liên quan đổi; nếu SettingsState chưa có ==, cân nhắc bỏ buildWhen
      buildWhen: (prev, curr) =>
          prev.isShuffleFlashCards != curr.isShuffleFlashCards ||
          prev.isFlippedDefault != curr.isFlippedDefault,
      builder: (context, state) {
        final selectedLang = _fromBool(state.isFlippedDefault);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Tùy chọn",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 32),

              _buildSettingRow(
                title: "Trộn thẻ",
                control: Switch(
                  value: state.isShuffleFlashCards,
                  onChanged: _shuffleCards,
                ),
              ),
              const Divider(height: 32),

              Text(
                "Thiết lập thẻ ghi nhớ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),

              Center(
                child: ToggleButtons(
                  onPressed: (int index) {
                    _setFrontCardLanguage(CardFaceLanguage.values[index]);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  isSelected: [
                    selectedLang == CardFaceLanguage.english,
                    selectedLang == CardFaceLanguage.vietnamese,
                  ],
                  selectedBorderColor: Theme.of(context).colorScheme.tertiary,
                  selectedColor: Theme.of(context).colorScheme.onTertiary,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  color: Theme.of(context).colorScheme.onPrimary,
                  children: _languageOptions,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
