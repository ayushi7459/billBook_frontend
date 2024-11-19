import 'package:flutter/material.dart';

class MyDialogBox {
  MyDialogBox(this.context, this.title, this.content);

  final BuildContext context;
  final String title;
  final String content;

  void showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Okay"),
          )
        ],
      ),
    );
  }
}

