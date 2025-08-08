import 'package:english_mate/navigation/route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNavigation extends StatefulWidget {
  const HomeNavigation({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
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
  int selectedIndex = 0;

  void _onSelected(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onSelected,
        items: List.generate(routes.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(icons[index]),
            label: labels[index],
          );
        }),
      ),
    );
  }
}
