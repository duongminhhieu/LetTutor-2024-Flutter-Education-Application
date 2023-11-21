import 'package:flutter/material.dart';

class BookingConfirmDialog extends StatefulWidget {
  const BookingConfirmDialog({Key? key, required this.start, required this.end, required this.date}) : super(key: key);
   final String start;
   final String end;
   final String date;

  @override
  State<BookingConfirmDialog> createState() => _BookingConfirmDialogState();
}

class _BookingConfirmDialogState extends State<BookingConfirmDialog> {
  final _controller = TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Booking details',style: TextStyle(
        fontWeight: FontWeight.w500
      ),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Booking time',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500

          ),
          ),
          const SizedBox(height: 4),
          Text(
            '  ${widget.start} - ${widget.end}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            '  ${widget.date}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Note',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Your requests for the tutor',
                hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context,false);
            },
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () async {
              if (mounted) {
                Navigator.pop(context,true);
              }
            },
            child: const Text('BOOK')),
      ],
    );
  }
}