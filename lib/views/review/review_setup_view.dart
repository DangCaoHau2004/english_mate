import 'package:english_mate/views/review/widgets/setup_by_unit.dart';
import 'package:english_mate/views/review/widgets/setup_by_vocabulary.dart';
import 'package:flutter/material.dart';

class ReviewSetupView extends StatefulWidget {
  const ReviewSetupView({super.key});

  @override
  State<ReviewSetupView> createState() => _ReviewSetupViewState();
}

class _ReviewSetupViewState extends State<ReviewSetupView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thiết lập ôn tập"),
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          tabs: const [
            Tab(text: "Unit"),
            Tab(text: "Từ vựng"),
          ],
          controller: _tabController,
        ),
      ),
      body: const SetupByVocabulary(),
    );
  }
}
