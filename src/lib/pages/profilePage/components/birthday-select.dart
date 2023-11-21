
import 'package:flutter/material.dart';

class BirthdayProfileSelect extends StatefulWidget {
  const BirthdayProfileSelect({Key? key}) : super(key: key);

  @override
  State<BirthdayProfileSelect> createState() => _BirthdayProfileSelectState();
}

class _BirthdayProfileSelectState extends State<BirthdayProfileSelect> {
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 42,
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
              isDense: true, // Added this
              hintText: "Choose your birthday",
              hintStyle: TextStyle(
                  fontSize: 14, color: Colors.grey.shade400),
              contentPadding: EdgeInsets.symmetric(horizontal: 10), // Điều chỉnh khoảng cách nội dung
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: IconButton(
                onPressed: () => _selectDate(context),
                icon: Icon(Icons.calendar_today),
              ),
            ),
            readOnly: true, // To prevent manual text input
          ),
        ),
      ],
    );
  }
}
