import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({super.key}) ;

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late DateTime selectedDate;
  final formatter = DateFormat.yMMMMd();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _selectDate(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => _selectDate(context),
          icon: const Icon(Icons.date_range),
        ),
        const SizedBox(width: 16),
        Text(
          'Birth Date: ${formatter.format(selectedDate)}',
        ),
      ],
    );
  }
}
