import 'package:flutter/material.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    // đây sẽ là trang thư viện có chức năng tìm kiếm
    // và hiển thị thông tin từ vựng một cách rõ ràng nhất
    return const Center(child: Text('Library View'));
  }
}
