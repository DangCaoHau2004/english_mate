import 'package:flutter/material.dart';

void showLoadingDialog({
  required BuildContext context,
  String content = 'Loading...',
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => LoadingDialog(content: content),
  );
}

class LoadingDialog extends StatelessWidget {
  final String content;
  const LoadingDialog({super.key, this.content = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
