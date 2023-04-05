import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';

class ItemMember extends StatefulWidget {
  UserModel user;
  bool isAdmin;
  VoidCallback jumpToLocation;
  String targetGroupId;
  ItemMember(
      {super.key,
      required this.user,
      required this.jumpToLocation,
      required this.isAdmin,
      required this.targetGroupId});

  @override
  State<ItemMember> createState() => _ItemMemberState();
}

class _ItemMemberState extends State<ItemMember> {
  bool isRomMaster = false;
  bool isMe = false;
  final GroupController _groupController = Get.find<GroupController>();
  @override
  void initState() {
    super.initState();
    isRomMaster = widget.user.role == "owner";
    isMe = widget.user.id == FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: widget.user.photoURL != null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.user.photoURL ?? ""),
                          radius: 24,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage("assets/img/avatar.jpg"),
                          radius: 24,
                        )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isMe ? "Me" : widget.user.displayName ?? "Anonymous",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold)),
                  Row(children: [
                    Icon(Icons.phone, color: Colors.purple.shade400),
                    const SizedBox(width: 5),
                    Text(
                      widget.user.phoneNumber ?? "No information",
                      style: const TextStyle(color: Colors.black87),
                    )
                  ]),
                  Row(children: [
                    Icon(Icons.person, color: Colors.purple.shade400),
                    const SizedBox(width: 5),
                    Text(
                      isRomMaster ? "Room Master" : "Member",
                      style: const TextStyle(color: Colors.black87),
                    )
                  ]),
                  Row(children: [
                    Icon(Icons.schedule, color: Colors.purple.shade400),
                    const SizedBox(width: 5),
                    Text(
                      widget.user.joinAt ?? "No information",
                      style: const TextStyle(color: Colors.black87),
                    )
                  ]),
                ],
              )
            ],
          ),
          Column(children: [
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Setting",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              !isMe && widget.isAdmin
                                  ? SizedBox(
                                      width: double.infinity,
                                      child: Material(
                                          child: InkWell(
                                        splashFactory: InkRipple.splashFactory,
                                        onTap: () async {
                                          ResponseModel response =
                                              await _groupController.kickMember(
                                                  widget.targetGroupId,
                                                  widget.user.id ?? "");
                                          AnimatedSnackBar.material(
                                            response.message,
                                            type: response.isSuccess
                                                ? AnimatedSnackBarType.success
                                                : AnimatedSnackBarType.error,
                                          ).show(context);
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          color: Colors.white,
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Kick",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      )))
                                  : isMe
                                      ? SizedBox(
                                          width: double.infinity,
                                          child: Material(
                                              child: InkWell(
                                            splashFactory:
                                                InkRipple.splashFactory,
                                            onTap: () async {
                                              print("Leave");
                                              ResponseModel response =
                                                  await _groupController
                                                      .leaveGroup(
                                                          widget.targetGroupId);
                                              AnimatedSnackBar.material(
                                                response.message,
                                                type: response.isSuccess
                                                    ? AnimatedSnackBarType
                                                        .success
                                                    : AnimatedSnackBarType
                                                        .error,
                                              ).show(context);
                                              Navigator.pop(context);
                                            },
                                            child: Ink(
                                              color: Colors.white,
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "Leave",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          )))
                                      : const SizedBox.shrink(),
                            ],
                          ));
                },
                child: const Icon(Icons.more_vert)),
            const SizedBox(
              height: 30,
            ),
            IconButton(
                onPressed: widget.jumpToLocation,
                icon: const Icon(Icons.my_location_rounded))
          ])
        ]);
  }
}
