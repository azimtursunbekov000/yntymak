import 'package:flutter/material.dart';

class DropDownButtonWidget extends StatelessWidget {
  final ValueChanged<String?> onChanged;
  final List<String> options;
  final String? selectedValue; // Track the selected value

  const DropDownButtonWidget({
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
      dropdownMenuEntries: options.map((String value) {
        return DropdownMenuEntry<String>(
          value: value,
          label: value,
        );
      }).toList(),
      hintText: 'Выберите опцию',
    );
  }
}
