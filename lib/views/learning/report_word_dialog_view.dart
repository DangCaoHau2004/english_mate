import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportWordDialogView extends StatefulWidget {
  final Word word;
  const ReportWordDialogView({super.key, required this.word});

  @override
  State<ReportWordDialogView> createState() => _ReportWordDialogViewState();
}

class _ReportWordDialogViewState extends State<ReportWordDialogView> {
  late final TextEditingController _feedbackController;
  late final TextEditingController _wordController;

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController(text: widget.word.term);
    _feedbackController = TextEditingController();
  }

  @override
  void dispose() {
    _wordController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitReport() {
    final feedback = _feedbackController.text;

    if (feedback.isNotEmpty) {
      print('Báo cáo cho từ: "${widget.word.term}"');
      print('Nội dung: "$feedback"');

      // Đóng dialog sau khi gửi
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Báo cáo từ vựng",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              StringUtils.capitalizeFirstLetter(widget.word.term),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _feedbackController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Nội dung góp ý của bạn",
                hintText: "Ví dụ: sai nghĩa, sai phát âm...",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        // Nút Hủy
        TextButton(
          child: Text("Hủy", style: Theme.of(context).textTheme.bodyMedium),
          onPressed: () {
            context.pop();
          },
        ),
        // Nút Gửi
        FilledButton(
          onPressed: _submitReport,
          child: Text("Gửi", style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
