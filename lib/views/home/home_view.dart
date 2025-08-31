import 'package:english_mate/models/unit_summary.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/views/home/widgets/lesson_card.dart';
import 'package:english_mate/views/home_navigation/home_navigation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formSearchKey = GlobalKey<FormState>();

  String _enterSearch = '';

  void _searchElement() {}

  Widget _searchInputWidget() {
    return Form(
      key: _formSearchKey,
      child: TextFormField(
        onChanged: (value) {
          _searchElement();
        },
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
          hintText: "Từ vựng...",
          hintStyle: Theme.of(context).textTheme.bodySmall,
          suffixIcon: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              _searchElement();
            },
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
          ),
        ),
        validator: (value) {
          if (value == null) {
            return "Vui lòng điền vào ô tìm kiếm";
          }

          return null;
        },
        onSaved: (value) {
          setState(() {
            _enterSearch = value!.trim();
          });
        },
      ),
    );
  }

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
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: HomeNavigation.showSearch,
              builder: (context, show, _) {
                return show
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: _searchInputWidget(),
                      )
                    : const SizedBox.shrink();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: unitSummary.length,
                itemBuilder: (context, index) {
                  return LessonCard(unitSummary: unitSummary[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
