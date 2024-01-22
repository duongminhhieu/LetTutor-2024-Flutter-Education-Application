import 'package:flutter/material.dart';
import 'package:src/pages/chatGptPage/components/receiver_card.dart';
import 'package:src/pages/chatGptPage/components/sender_card.dart';

import '../chat_gpt_page.dart';

class ChatBodyComponent extends StatefulWidget {
  const ChatBodyComponent({Key? key, required this.chatHistory, required this.size}) : super(key: key);
  final List<MessageData> chatHistory;
  final Size size;

  @override
  State<ChatBodyComponent> createState() => _ChatBodyComponentState();

}
class _ChatBodyComponentState extends State<ChatBodyComponent> {

  @override
  Widget build(BuildContext context) {
    if (widget.chatHistory.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.chatHistory.length,
        itemBuilder: (BuildContext context, int index) {
          var value = widget.chatHistory[index];
          if (value.type == MessageType.sender) {
            return senderCard(widget.size, value.message);
          } else if (value.type == MessageType.receiver) {
            return receiverCard(widget.size, value.message);
            // receiverCard(size, value.message);
          } else {
            return Container(
                alignment: Alignment.center,
                child: const Text("Invalid message card"));
          }
        },
      );
    } else {
      return Container(
          alignment: Alignment.center,
          child: Text("Start your first prompt"));
    }
  }
}