import 'package:english_mate/models/unit_summary.dart';
import 'package:english_mate/navigation/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonCard extends StatelessWidget {
  final UnitSummary unitSummary;
  const LessonCard({super.key, required this.unitSummary});

  void _goToFlashCard(BuildContext context) {
    context.push("${RoutePath.flashCard}/${unitSummary.unitId}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          _goToFlashCard(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(unitSummary.thumbnailImage),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                "Unit ${unitSummary.unitId}",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
