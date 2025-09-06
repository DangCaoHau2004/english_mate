import 'package:flutter/material.dart';

class PuzzleInputRow extends StatefulWidget {
  const PuzzleInputRow({Key? key}) : super(key: key);

  @override
  _PuzzleInputRowState createState() => _PuzzleInputRowState();
}

class _PuzzleInputRowState extends State<PuzzleInputRow> {
  // Puzzle của chúng ta
  final String puzzle = "c___t";

  // Danh sách quản lý Controller và FocusNode cho các ô nhập liệu
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    // Đếm số lượng ô trống '_' để khởi tạo
    final int blankCount = puzzle.split('').where((char) => char == '_').length;

    _controllers = List.generate(blankCount, (_) => TextEditingController());
    _focusNodes = List.generate(blankCount, (_) => FocusNode());
  }

  @override
  void dispose() {
    // Luôn dispose controller và focus node để tránh rò rỉ bộ nhớ
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Hàm để xây dựng từng ô trong puzzle
  Widget _buildBox(int index, String char) {
    // Biến để theo dõi index của ô nhập liệu
    int blankIndex = 0;
    for (int i = 0; i < index; i++) {
      if (puzzle[i] == '_') blankIndex++;
    }

    if (char == '_') {
      return SizedBox(
        width: 50,
        height: 50,
        child: TextField(
          controller: _controllers[blankIndex],
          focusNode: _focusNodes[blankIndex],
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "", // Ẩn bộ đếm ký tự
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: (value) {
            // Tự động chuyển focus sang phải khi nhập xong
            if (value.isNotEmpty && blankIndex < _focusNodes.length - 1) {
              _focusNodes[blankIndex + 1].requestFocus();
            }
            // Tự động chuyển focus sang trái khi xóa
            if (value.isEmpty && blankIndex > 0) {
              _focusNodes[blankIndex - 1].requestFocus();
            }
          },
        ),
      );
    } else {
      // Đây là ô ký tự tĩnh
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            char.toUpperCase(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> chars = puzzle.split('');

    return Scaffold(
      appBar: AppBar(title: const Text("Puzzle Input UI")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // Dùng Row để sắp xếp các ô
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(chars.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: _buildBox(index, chars[index]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
