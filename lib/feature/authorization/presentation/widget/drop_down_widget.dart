import 'package:flutter/material.dart';

class DropDownMenuWidget extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final List<String> options;
  final String? selectedValue; // Выбранное значение

  const DropDownMenuWidget({
    super.key,
    required this.onChanged,
    required this.options,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: selectedValue,
      onSelected: onChanged,
      hintText: 'Выберите опцию',
      dropdownMenuEntries: options.map((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
      menuHeight: 200.0, // Ограничение высоты выпадающего списка
    );
  }
}
