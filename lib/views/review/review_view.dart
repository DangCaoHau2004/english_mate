import 'package:flutter/material.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  // Thêm dispose để hủy controller, tránh memory leak
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),

            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Ngày"),
                Tab(text: "Tháng"),
                Tab(text: "Năm"),
                Tab(text: "Tùy chỉnh"),
              ],
            ),
            const SizedBox(height: 16),

            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Sử dụng Expanded để chia đều không gian
                  Expanded(
                    // Bọc trong Card để tạo nền và bo góc
                    child: Card(
                      color: Theme.of(
                        context,
                      ).colorScheme.tertiary, // <-- Đặt màu nền
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            "Số từ vựng đã học",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                ),
                          ),
                          subtitle: Text(
                            "14",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ), // <-- Thêm khoảng cách giữa các Card
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),

                        child: ListTile(
                          title: Text(
                            "Bài kiểm tra đã làm",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                ),
                          ),
                          subtitle: Text(
                            "14",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Card(
                      color: Theme.of(context).colorScheme.tertiary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),

                        child: ListTile(
                          title: Text(
                            "Từ khó",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                ),
                          ),
                          subtitle: Text(
                            "14 ⭐",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Bắt đầu ôn tập"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
