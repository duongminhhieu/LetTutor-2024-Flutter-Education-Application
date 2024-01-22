import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:src/utilities/const.dart';


import '../../commons/loadingOverlay.dart';
import 'components/chat-body_component.dart';

enum MessageType {
  sender, receiver
}

class MessageData{
  late String message;
  late MessageType type;

  MessageData(this.message, this.type);
}


class ChatGPTPage extends StatefulWidget {
  const ChatGPTPage({super.key});

  @override
  State<ChatGPTPage> createState() => _ChatGPTPageState();
}

class _ChatGPTPageState extends State<ChatGPTPage> {
  /// text controller
  final TextEditingController _txtWord = TextEditingController();
  late List<MessageData> _chatHistory;

  late OpenAI openAI;

  ///t => translate
  // Future<CTResponse?>? _translateFuture;

  void _updateDataFromGPT(String newData) {
    setState(() {
      _chatHistory.add(MessageData(newData, MessageType.receiver));
    });
    LoadingOverlay.of(context).hide();
  }

  Future<CompleteResponse?>? _createRequest(String sendingPrompt) async {
    setState(() {
      _chatHistory.add(MessageData(sendingPrompt, MessageType.sender));
    });

    final request = CompleteText(
        prompt: sendingPrompt.toString(),
        maxTokens: 200,
        model: TextDavinci3Model());

    // _translateFuture = openAI.onCompletion(request: request);
    return openAI.onCompletion(request: request);
  }
  @override
  void initState() {
    //Init list of data
    _chatHistory = List.empty(growable: true);

    //Init openAI object
    openAI = OpenAI.instance.build(
        token: SecretKeys.chatGPTApiKey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        enableLog: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Chat GPT"),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
              color: Colors.lightBlueAccent.withOpacity(0.08),
              child:
              // FutureBuilder<CTResponse?>(
              //   future: _translateFuture,
              //   builder: (context, snapshot) {
              //
              //     final text = snapshot.data?.choices.last.text.trim();
              //     if (text!=null) {
              //       _chatHistory.add(MessageData(text, MessageType.receiver));
              //     }
              ChatBodyComponent(chatHistory: _chatHistory, size: size)
            // },
            // )
          ),
        ),
        _inputField(size),
      ]),
    );
  }


  Widget _inputField(Size size) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _txtWord,
              decoration: const InputDecoration(
                fillColor: Colors.blue,
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              keyboardType: TextInputType.text,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 24.0,
            color: Colors.blue,
            onPressed: () async {
              var sendingPrompt = _txtWord.text.toString();
              _txtWord.clear();

              if (sendingPrompt.isNotEmpty) {
                LoadingOverlay.of(context).show();
                try {
                  var response = await _createRequest(sendingPrompt);
                  final text = response?.choices.last.text.trim();
                  if (text != null) {
                    _updateDataFromGPT(text);
                  }
                }
                finally {
                  LoadingOverlay.of(context).hide();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
