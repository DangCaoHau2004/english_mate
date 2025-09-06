import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 144, // kích thước tổng thể
          height: 144,
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
