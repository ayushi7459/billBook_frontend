import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({super.key, required this.myValue, required this.onChanged});
  final bool myValue;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: myValue, onChanged: onChanged);
  }
}
