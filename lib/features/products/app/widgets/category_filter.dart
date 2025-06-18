import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final Set<String> selectedCategories;
  final ValueChanged<String> onSelected;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: onSelected,
      itemBuilder: (context) {
        return [
          CheckedPopupMenuItem<String>(
            value: 'Все категории',
            checked: selectedCategories.length == categories.length,
            child: const Text('ВСе категории'),
          ),
          ...categories.map((category) {
            final isSelected = selectedCategories.contains(category);
            return CheckedPopupMenuItem<String>(value: category, checked: isSelected, child: Text(category));
          }),
        ];
      },
    );
  }
}
