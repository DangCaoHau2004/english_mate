import 'package:flutter/material.dart';

class CustomPickerWheel extends StatefulWidget {
  const CustomPickerWheel({
    super.key,
    required this.list,
    required this.selectedIndex,
    required this.onChanged,
    required this.height,
    this.itemExtent = 40,
    this.width = 80,
    this.isString = false,
    this.indexInitial = 0,
  });
  final List list;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final double width;
  final double height;
  final double itemExtent;
  final bool isString;
  final int indexInitial;

  @override
  State<CustomPickerWheel> createState() => _CustomPickerWheelState();
}

class _CustomPickerWheelState extends State<CustomPickerWheel> {
  late final FixedExtentScrollController _controller;
  @override
  void initState() {
    _controller = FixedExtentScrollController(initialItem: widget.indexInitial);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: widget.itemExtent,
        onSelectedItemChanged: widget.onChanged,
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.005,
        diameterRatio: 2,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index >= widget.list.length) return null;
            final item = widget.isString
                ? widget.list[index]
                : widget.list[index].toString().padLeft(2, '0');
            final isSelected = index == widget.selectedIndex;
            return isSelected
                ? Center(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
