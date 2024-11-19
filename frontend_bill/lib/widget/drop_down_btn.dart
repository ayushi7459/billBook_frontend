import 'package:flutter/material.dart';

class MyDropDownBtn<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;
  final Icon prefixIcon;

  const MyDropDownBtn({
    super.key,
    required this.value,
    required this.items,
    required this.getLabel,
    required this.onChanged,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  getLabel(item),
                  style: Theme.of(context).textTheme.labelLarge!,
                ),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
