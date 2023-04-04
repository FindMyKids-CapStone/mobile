import 'package:app_parent/models/user_model.dart';
import 'package:app_parent/src/room_page/widget/create_join_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/group.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<Group> rooms = [
    Group(
      id: '001',
      name: 'Tôi và 6 thằng ngu',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Khe"),
        UserModel(displayName: "Híu")
      ],
    ),
    Group(
      id: '001',
      name: 'Tôi và 6 thằng ngu',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Khe"),
        UserModel(displayName: "Híu")
      ],
    ),
    Group(
      id: '001',
      name: 'Tôi và 6 thằng ngu',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Khe"),
        UserModel(displayName: "Híu")
      ],
    ),
  ];
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true ,
          title:  Text("Conversations", style: TextStyle(color: Get.isDarkMode ? Colors.white: Colors.black),),
          leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.blue,), onPressed: (){}),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogCreateJoin(type: "join"));
                },
                icon: Icon(Icons.meeting_room_outlined, color: Colors.blue,)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogCreateJoin(type: "create"));
                },
                icon: Icon(Icons.create_outlined, color: Colors.blue,)),

          ],
        ),
        body: rooms.isEmpty
            ? Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                    image: AssetImage("assets/img/rooms-not-found.jpg"),
                    height: 100),
                Text(
                  "Bạn chưa tham gia nhóm nào",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Vui lòng tạo hoặc tham gia nhóm",
                  textAlign: TextAlign.center,
                )
              ]),
        )
            : ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) =>
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.album),
                        title: Text('The Enchanted Nightingale'),
                        subtitle: Text(
                            'Music by Julie Gable. Lyrics by Sidney Stein.'),
                      ),
                    ],
                  ),
                )));
  }
}
