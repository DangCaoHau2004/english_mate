import 'package:flutter/material.dart';

// Bước 1: Sử dụng enum để định nghĩa các lựa chọn một cách rõ ràng
// Điều này tốt hơn nhiều so với việc dùng List<bool> và nhớ index
enum CardFaceLanguage { english, vietnamese }

class FlashCardSettingDialog extends StatefulWidget {
  const FlashCardSettingDialog({super.key});

  @override
  State<FlashCardSettingDialog> createState() => _FlashCardSettingDialogState();
}

class _FlashCardSettingDialogState extends State<FlashCardSettingDialog> {
  // --- Biến trạng thái được đặt tên lại cho rõ ràng ---

  // State cho việc có trộn thẻ hay không
  bool _isShuffleEnabled = true;

  // State cho việc chọn ngôn ngữ mặt trước, sử dụng enum đã tạo
  CardFaceLanguage _frontCardLanguage = CardFaceLanguage.english;

  // Tách các widget con ra để dễ quản lý
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

  // Helper method để xây dựng một hàng cài đặt cho gọn gàng
  Widget _buildSettingRow({required String title, required Widget control}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
        control,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start, // Căn lề các mục con sang trái
        children: [
          // Tiêu đề Dialog
          Center(
            child: Text(
              "Tùy chọn",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 32),

          // --- Cài đặt Trộn thẻ ---
          _buildSettingRow(
            title: "Trộn thẻ",
            control: Switch(
              value: _isShuffleEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isShuffleEnabled = value;
                });
              },
            ),
          ),
          const Divider(height: 32),

          // --- Cài đặt Mặt trước thẻ ---
          Text(
            "Thiết lập thẻ ghi nhớ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),

          // ToggleButtons được căn giữa để trông đẹp hơn
          Center(
            child: ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  // Logic được đơn giản hóa nhờ có enum
                  _frontCardLanguage = CardFaceLanguage.values[index];
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              isSelected: [
                _frontCardLanguage == CardFaceLanguage.english,
                _frontCardLanguage == CardFaceLanguage.vietnamese,
              ],
              // --- Các thuộc tính style giữ nguyên ---
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
  }
}
