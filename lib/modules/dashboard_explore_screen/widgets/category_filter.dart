import 'package:flutter/material.dart';

class CategoryGrid<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final Widget Function(BuildContext context, T item, bool isSelected) itemBuilder;

  const CategoryGrid({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.itemBuilder,
  });

  @override
  State<CategoryGrid<T>> createState() => _CategoryGridState<T>();
}

class _CategoryGridState<T> extends State<CategoryGrid<T>> {
  late T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(covariant CategoryGrid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      _selectedItem = widget.selectedItem;
    }
  }

  void _toggleSelection(T item) {
    setState(() {
      _selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Adjust for desired number of columns
        mainAxisSpacing: 4,
        crossAxisSpacing: 8.0,
        childAspectRatio: 2.4,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = _selectedItem == item;

        return GestureDetector(
          onTap: () => _toggleSelection(item),
          child: Align(
            alignment: Alignment.topLeft,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                child: widget.itemBuilder(context, item, isSelected),
              ),
            ),
          ),
        );
      },
    );
  }
}
