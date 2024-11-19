import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primaryContainer)),
      onPressed: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!,
      ),
    );
  }
}
