import 'package:app_parent/src/room_page/widget/create_join_room.dart';
import 'package:flutter/material.dart';

import '../../models/group.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<Group> rooms = [];
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Danh sách nhóm"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogCreateJoin(type: "join"));
                },
                icon: const Icon(Icons.meeting_room_outlined)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DialogCreateJoin(type: "create"));
                },
                icon: const Icon(Icons.create))
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
                itemBuilder: (context, index) => Card(
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
