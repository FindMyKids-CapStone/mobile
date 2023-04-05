import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/user_model.dart';
import 'package:app_parent/src/map_page/map_page.dart';
import 'package:app_parent/src/room_page/widget/create_join_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../data/group_fetch.dart';
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
      name: 'asd',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Khe"),
        UserModel(displayName: "Híu")
      ],
    ),
    Group(
      id: '002',
      name: 'sdf',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Phát"),
        UserModel(displayName: "Phúc")
      ],
    ),
    Group(
      id: '003',
      name: 'dfg',
      createdAt: '02 - 03 - 12',
      createdBy: 'aa',
      code: '123',
      users: <UserModel>[
        UserModel(displayName: "Chiến"),
        UserModel(displayName: "Nhân"),
        UserModel(displayName: "Trung")
      ],
    ),
  ];
  TextEditingController nameController = TextEditingController();
  final GroupController _groupController = Get.put(GroupController());

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
            document: gql(GroupFetch.getListGroup),
            fetchPolicy: FetchPolicy.noCache,
            variables: const {
              "page": 1,
              "limit": 100,
            }),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Container(
                color: Colors.black,
                child: const Image(
                    image: AssetImage("assets/img/zenly-logo.jpg")));
          }
          print("Result ${result.data}");
          List<Group> groups = List<Group>.from(
              result.data?['group']["group"].map((d) => Group.fromJson(d)));
          _groupController.groups = groups;
          // _groupController.update();
          return GetBuilder<GroupController>(builder: (controller) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Conversations",
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
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
                  ? SizedBox(
                      width: double.infinity,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                                image: AssetImage(
                                    "assets/img/rooms-not-found.jpg"),
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
                  : Column(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                        height: 50,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Search',
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                          ),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: controller.groups.length,
                              itemBuilder: (context, index) => Material(
                                    child: InkWell(
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () async {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => MapPage(
                                                    targetGroupId: controller
                                                            .groups[index].id ??
                                                        "")));
                                      },
                                      child: Ink(
                                        child: ListTile(
                                          leading: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        900.0),
                                                child: Image.network(
                                                  controller.groups[index]
                                                          .imgUrl ??
                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNL_ZnOTpXSvhf1UaK7beHey2BX42U6solRA&usqp=CAU',
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          title: Text(
                                              controller.groups[index].name ??
                                                  ''),
                                          subtitle: Text(_memberNames(
                                              controller.groups[index])),
                                        ),
                                      ),
                                    ),
                                  ))),
                    ]),
            );
          });
        });
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
              SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);

                        showDialog(
                            context: context,
                            builder: (context2) =>
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
                child: SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
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

  String _memberNames(Group room) {
    var res = [];
    room.users?.forEach((user) {
      if (user.displayName != null) {
        res.add(user.displayName);
      }
    });
    return res.join(", ");
  }
}
