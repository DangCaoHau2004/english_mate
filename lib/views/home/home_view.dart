import 'package:english_mate/views/home/widgets/lesson_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return const LessonCard();
          },
        ),
      ),
    );
  }
}
