import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogChangePassword extends StatefulWidget {
  const DialogChangePassword({
    super.key,
  });

  @override
  State<DialogChangePassword> createState() => _DialogChangePasswordState();
}

class _DialogChangePasswordState extends State<DialogChangePassword> {
  final TextEditingController _passwordController = TextEditingController();

  final GroupController _groupController = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: const Text(
        "Change Password",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      children: [
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          height: 50,
          child: TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'New password',
              icon: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.password),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () async {
                  final dialogContextCompleter = Completer<BuildContext>();
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (dialogContext) {
                        if (!dialogContextCompleter.isCompleted) {
                          dialogContextCompleter.complete(dialogContext);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  ResponseModel res = await _groupController.changePassword(
                      password: _passwordController.text);
                  final dialogContext = await dialogContextCompleter.future;
                  Navigator.pop(dialogContext);
                  AnimatedSnackBar.material(res.message,
                          type: res.isSuccess
                              ? AnimatedSnackBarType.success
                              : AnimatedSnackBarType.error,
                          duration: const Duration(seconds: 1))
                      .show(dialogContext);
                },
                child: const Text("Change"))
          ]),
        ),
      ],
    );
  }
}
