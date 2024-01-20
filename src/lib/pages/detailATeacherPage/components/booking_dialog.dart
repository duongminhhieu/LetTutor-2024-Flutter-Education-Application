import 'package:flutter/material.dart';
import 'package:src/l10n/app_localizations.dart';

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
      title: Text(
        'Booking Details',
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBookingTime(),
          const SizedBox(height: 8),
          _buildNoteSection(),
        ],
      ),
      actions: [
        _buildCancelButton(),
        _buildBookButton(),
      ],
    );
  }

  Widget _buildBookingTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.bookingTime,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
      ],
    );
  }

  Widget _buildNoteSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.notes,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        _buildNoteTextField(),
      ],
    );
  }

  Widget _buildNoteTextField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: _controller,
        minLines: 3,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.requestForTutorial,
          hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, false);
      },
      child: Text(
        AppLocalizations.of(context)!.cancel,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildBookButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context, [true, _controller.text]);
      },
      child: Text(AppLocalizations.of(context)!.book),
    );
  }
}
