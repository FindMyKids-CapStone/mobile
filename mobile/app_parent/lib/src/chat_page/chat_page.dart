// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:app_parent/models/chat_message.dart';
import 'package:bubble/bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textFieldController = TextEditingController();
  List<Message> messageList = [
    Message(
        message: "Hello",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 6)),
        sentByMe: false),
    Message(
        message: "How are you today?",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 7)),
        sentByMe: false),
    Message(
        message: "I'm fine, thank you",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 8)),
        sentByMe: true),
    Message(
        message: "Hello World 1",
        date: DateTime.now().subtract(const Duration(days: 8, minutes: 9)),
        sentByMe: false),
    Message(
        message: "Hello",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 6)),
        sentByMe: false),
    Message(
        message: "How are you today?",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 7)),
        sentByMe: false),
    Message(
        message: "I'm fine, thank you",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 8)),
        sentByMe: true),
    Message(
        message: "Hello World 2",
        date: DateTime.now().subtract(const Duration(days: 8, minutes: 8)),
        sentByMe: false),
    Message(
        message: "Hello",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 6)),
        sentByMe: false),
    Message(
        message: "How are you today?",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 7)),
        sentByMe: false),
    Message(
        message:
            "Paragraphs are the building blocks of papers. Many students define paragraphs in terms of length: a paragraph is a group of at least five sentences, a paragraph is half a page long, etc. In reality, though, the unity and coherence of ideas among sentences is what constitutes a paragraph.",
        date: DateTime.now().subtract(const Duration(days: 6, minutes: 8)),
        sentByMe: true),
    Message(
        message: "Hello World 3",
        date: DateTime.now().subtract(const Duration(days: 8, minutes: 7)),
        sentByMe: false),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Chat",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              padding: const EdgeInsets.all(10),
              elements: messageList,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(DateFormat.yMMMMEEEEd().format(message.date),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 11.0)),
                ),
              ),
              indexedItemBuilder: (context, message, index) {
                return Row(children: [
                  !message.sentByMe
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: index % 2 == 0
                                ? const AssetImage("assets/img/avatar.jpg")
                                : const AssetImage("assets/img/logo.png"),
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Bubble(
                        margin: BubbleEdges.only(
                          top: 5,
                          bottom: 5,
                          left: message.sentByMe ? 60 : 0,
                          right: message.sentByMe ? 0 : 60,
                        ),
                        alignment: message.sentByMe
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        nip: message.sentByMe
                            ? BubbleNip.rightTop
                            : BubbleNip.leftTop,
                        color:
                            message.sentByMe ? Colors.blue : Colors.grey[200],
                        child: Text(
                          message.message,
                          style: TextStyle(
                              color: message.sentByMe
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  ),
                ]);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))),
                hintText: "Send a message ...",
                contentPadding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 20, right: 20),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      messageList.add(Message(
                          message: textFieldController.text,
                          date: DateTime.now(),
                          sentByMe: true));
                    });
                    textFieldController.clear();
                  },
                ),
              ),
              controller: textFieldController,
            ),
          )
        ]),
      ),
    );
  }
}
