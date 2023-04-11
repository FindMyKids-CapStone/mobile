// ignore_for_file: avoid_print, library_prefixes

import 'package:app_parent/config/backend.dart';
import 'package:app_parent/service/spref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:app_parent/models/chat_message.dart';
import 'package:bubble/bubble.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../config/app_key.dart';
import '../../controllers/group_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isConnected = false;
  late IO.Socket _socket;
  final textFieldController = TextEditingController();
  final GroupController _groupController = Get.find<GroupController>();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  List<Message> messageList = [];

  void _connectToServer() {
    _socket = IO.io(
      BACK_END_SOCKET,
      <String, dynamic>{
        "transports": ["websocket"],
        'forceNew': true,
        "auth": {
          "token":
              "${AppKey.authorization} ${SPref.instance.get(AppKey.authorization)}"
        }
      },
    );
    _socket.onConnect((_) {
      print('CONNECT STATUS: CONNECT');
      _socket.emitWithAck(
          "chat:join-room", {"idGroup": _groupController.targetGroup?.id},
          ack: (value) {
        print("ACK JOIN CHAT ROOM: $value");
      });
      _getAllMessage();
    });
    print("CONNECT STATUS: ${_socket.connected}");
  }

  void _getAllMessage() {
    _socket.emitWithAck(
        "chat:get-all-message", {"idGroup": _groupController.targetGroup?.id},
        ack: (Map<String, dynamic> value) {
      setState(() {
        _isConnected = true;
        print("ACK GET ALL MESSAGE: $value");
        final data = value["messages"];
        print("DATA: $data");

        data.forEach((e) {
          messageList.add(Message(
              message: e["data"]["content"],
              date: DateTime.parse(e["createdAt"]),
              sentByMe: e["userID"] == _currentUser?.uid));
        });
      });
    });
    _socket.on("chat:receive-message", (data) {
      print("MESSAAGE RECEIVED: $data");
      setState(() {
        messageList.add(Message(
            message: data["data"]["content"],
            date: DateTime.parse(data["createdAt"]),
            sentByMe: data["userID"] == _currentUser?.uid));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _connectToServer();
  }

  @override
  void dispose() {
    super.dispose();
    _socket.emitWithAck(
        "chat:leave-room", {"idGroup": _groupController.targetGroup?.id},
        ack: (value) {
      _socket.dispose();
      print("ACK LEAVE CHAT ROOM: $value");
    });
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
          child: _isConnected
              ? Column(children: [
                  Expanded(
                    child: GroupedListView<Message, DateTime>(
                      order: GroupedListOrder.DESC,
                      reverse: true,
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
                          child: Text(
                              DateFormat.yMMMMEEEEd().format(message.date),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 11.0)),
                        ),
                      ),
                      indexedItemBuilder: (context, message, index) {
                        return Row(children: [
                          !message.sentByMe
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundImage:
                                          AssetImage("assets/img/avatar.jpg")),
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
                                color: message.sentByMe
                                    ? Colors.blue
                                    : Colors.grey[200],
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        hintText: "Send a message ...",
                        contentPadding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20, right: 20),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _socket.emitWithAck("chat:send-message", {
                              "idGroup": _groupController.targetGroup?.id,
                              "content": textFieldController.text,
                              "type": "text"
                            }, ack: (value) {
                              print("ACK SEND MESSAGE: $value");
                            });
                            // setState(() {
                            //   messageList.add(Message(
                            //       message: textFieldController.text,
                            //       date: DateTime.now(),
                            //       sentByMe: true));
                            // });
                            textFieldController.clear();
                          },
                        ),
                      ),
                      controller: textFieldController,
                    ),
                  )
                ])
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
