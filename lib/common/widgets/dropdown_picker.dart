import 'package:flutter/material.dart';

class TimerValuePicker extends StatelessWidget {
  final ValueChanged<int> onValueSelected;
  const TimerValuePicker({
    super.key,
    required this.onValueSelected,
    required this.selectedValue,
    required this.options,
  });
  final List<int> options;

  final int selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<int>(
      initialSelection: selectedValue,
      dropdownMenuEntries:
          options
              .map(
                (int item) =>
                    DropdownMenuEntry(value: item, label: item.toString()),
              )
              .toList(),
      onSelected: (value) {
        if (value != null) {
          onValueSelected(value);
        }
      },
    );
  }
}
