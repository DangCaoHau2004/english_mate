import 'package:english_mate/models/unit_summary.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/views/home/widgets/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vocabBox = Hive.box<Word>('wordsBox').values.toList();
    Map<int, UnitSummary> unitSummaries = {};
    for (var i = 0; i < vocabBox.length; i++) {
      if (unitSummaries[vocabBox[i].unitId] == null) {
        unitSummaries[vocabBox[i].unitId] = UnitSummary(
          unitId: vocabBox[i].unitId,
          thumbnailImage: AssetHelper.getImage(vocabBox[i].image),
        );
      }
    }
    final List<UnitSummary> unitSummary = unitSummaries.values.toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ListView.builder(
          itemCount: unitSummary.length,
          itemBuilder: (context, index) {
            return LessonCard(unitSummary: unitSummary[index]);
          },
        ),
      ),
    );
  }
}
