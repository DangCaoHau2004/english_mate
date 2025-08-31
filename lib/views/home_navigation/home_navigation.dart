import 'package:english_mate/navigation/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  static final ValueNotifier<bool> showSearch = ValueNotifier(false);
  @override
  State<HomeNavigation> createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  List<String> routes = [
    RoutePath.home,
    RoutePath.review,
    RoutePath.statistics,
    RoutePath.account,
  ];
  List<IconData> icons = [
    Icons.home_filled,
    Icons.menu_book,
    Icons.leaderboard,
    Icons.person,
  ];
  List<String> labels = ['Trang chủ', 'Ôn tập', 'Thống kê', 'Tài khoản'];
  List<PreferredSizeWidget> appbars = [
    AppBar(
      title: const Text('Từ vựng'),
      actions: [
        IconButton(
          onPressed: () {
            HomeNavigation.showSearch.value = !HomeNavigation.showSearch.value;
          },
          icon: const Icon(Icons.search),
        ),
      ],
    ),
    AppBar(title: const Text('Ôn tập')),
    AppBar(title: const Text('Thống kê')),
    AppBar(title: const Text('Tài khoản')),
  ];
  int selectedIndex = 0;

  void _onSelected(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.navigationShell.currentIndex;
    return Scaffold(
      appBar: appbars[index],
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: _onSelected,
        items: List.generate(routes.length, (idx) {
          return BottomNavigationBarItem(
            icon: Icon(icons[idx]),
            label: labels[idx],
          );
        }),
      ),
    );
  }
}
