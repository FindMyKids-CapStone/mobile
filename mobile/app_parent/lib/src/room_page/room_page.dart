import 'package:app_parent/models/user_model.dart';
import 'package:app_parent/src/room_page/widget/create_join_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          centerTitle: true,
          title: Text(
            "Conversations",
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.indigo,
              ),
              onPressed: () {}),
          actions: [
            IconButton(
                onPressed: () => _buildBottomSheetJoinOrCreate(context),
                icon: const Icon(
                  Icons.add,
                  color: Colors.indigo,
                  size: 30,
                )),
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

  Future<void> _buildBottomSheetJoinOrCreate(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Create a Room'.tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text(
                  'Your room is where you and your friends hang out. Make yours and start talking.'
                      .tr,
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                DialogCreateJoin(type: "create"));
                      },
                      icon: const Icon(Icons.new_label),
                      label: const Text('Create My Own Room'))),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Divider(
                  endIndent: 5,
                  indent: 5,
                ),
              ),
              Text(
                'Have an invite already?'.tr,
                style: const TextStyle(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  DialogCreateJoin(type: "join"));
                        },
                        icon: const Icon(Icons.people),
                        label: const Text('Join a Room'))),
              ),
            ],
          ),
        );
      },
    );
  }
}
