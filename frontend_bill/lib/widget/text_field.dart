import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.keyboardType,
    required this.preFixIcon,
  });
  final TextInputType keyboardType;
  final String label;
  final bool obscureText;
  final controller;
  final Icon preFixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please Enter $label";
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: preFixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label),
        labelStyle: Theme.of(context).textTheme.labelLarge!,
      ),
      style: Theme.of(context).textTheme.labelLarge!,
    );
  }
}
