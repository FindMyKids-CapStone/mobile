import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/response.dart';
import 'package:app_parent/share/dialog/confirm_dialog.dart';
import 'package:app_parent/src/setting_page/widget/change_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GroupController _groupController = Get.find<GroupController>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 19),
        title: const Text("Setting"),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back, color: Colors.black87),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          // Material(
          //   child: InkWell(
          //     splashFactory: InkRipple.splashFactory,
          //     onTap: () {
          //       FirebaseAuth.instance.signOut();
          //       Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute<void>(
          //           builder: (BuildContext context) => const AuthPage(),
          //         ),
          //       );
          //     },
          //     child: Ink(
          //       decoration: BoxDecoration(
          //           border: Border.all(color: Colors.black),
          //           borderRadius: const BorderRadius.all(Radius.circular(999))),
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          //         child: Row(
          //           children: const [
          //             Icon(Icons.logout),
          //             SizedBox(width: 10),
          //             Text(
          //               "Đăng xuất",
          //               style: TextStyle(fontSize: 17),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Material(
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context2) => const DialogChangePassword());
              },
              child: Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(999))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.password,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Change Password",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onTap: () async {
                await showConfirmDialog(
                    title: "Disband group",
                    content: "Do you really want to disband this group?",
                    context: context,
                    confirmAction: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      ResponseModel response =
                          await _groupController.disbandGroup();
                      Navigator.of(context, rootNavigator: true).pop();
                      Get.back();
                      Get.back();
                    },
                    confirmText: "Disband");
              },
              child: Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(999))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Disband group",
                        style: TextStyle(fontSize: 17, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
