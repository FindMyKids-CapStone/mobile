import 'package:app_parent/src/core/fade_animation.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/colors/hex_color.dart';

// ignore: constant_identifier_names
enum FormData { Name, Phone, Email, Birthday }

const List<TabItem> items = [
  TabItem(icon: FontAwesomeIcons.mapLocation),
  TabItem(icon: FontAwesomeIcons.route),
  TabItem(icon: FontAwesomeIcons.plus),
  TabItem(icon: FontAwesomeIcons.microphone),
  TabItem(icon: FontAwesomeIcons.bars),
];

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;

  FormData? selected;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = currentUser?.displayName ?? "";
    phoneController.text = currentUser?.phoneNumber ?? "";
    emailController.text = currentUser?.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.1, 0.4, 0.7, 0.9],
          colors: [
            HexColor("#4b4293").withOpacity(0.8),
            HexColor("#4b4293"),
            HexColor("#08418e"),
            HexColor("#08418e")
          ],
        )),
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Cập nhật thông tin",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const FadeAnimation(
                    delay: 0.8,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/img/avatar.jpg"),
                      radius: 75,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Text(
                      "Thông tin cá nhân",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: selected == FormData.Name
                            ? enabled
                            : backgroundColor,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: nameController,
                        onTap: () {
                          setState(() {
                            selected = FormData.Name;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.title,
                            color: selected == FormData.Name
                                ? enabledtxt
                                : deaible,
                            size: 20,
                          ),
                          hintText: 'Họ và tên',
                          hintStyle: TextStyle(
                              color: selected == FormData.Name
                                  ? enabledtxt
                                  : deaible,
                              fontSize: 12),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            color: selected == FormData.Name
                                ? enabledtxt
                                : deaible,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: selected == FormData.Phone
                            ? enabled
                            : backgroundColor,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: phoneController,
                        onTap: () {
                          setState(() {
                            selected = FormData.Phone;
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.phone_android_rounded,
                            color: selected == FormData.Phone
                                ? enabledtxt
                                : deaible,
                            size: 20,
                          ),
                          hintText: 'Số điện thoại',
                          hintStyle: TextStyle(
                              color: selected == FormData.Phone
                                  ? enabledtxt
                                  : deaible,
                              fontSize: 12),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            color: selected == FormData.Phone
                                ? enabledtxt
                                : deaible,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: selected == FormData.Email
                            ? enabled
                            : backgroundColor,
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: emailController,
                        onTap: () {
                          setState(() {
                            selected = FormData.Email;
                          });
                        },
                        enabled: false,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: selected == FormData.Email
                                ? enabledtxt
                                : deaible,
                            size: 20,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: selected == FormData.Email
                                  ? enabledtxt
                                  : deaible,
                              fontSize: 12),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                            color: selected == FormData.Email
                                ? enabledtxt
                                : deaible,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FadeAnimation(
                    delay: 1,
                    child: TextButton(
                      onPressed: () async {
                        await currentUser
                            ?.updateDisplayName(nameController.text);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 80),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      child: const Text(
                        "Lưu",
                        style: TextStyle(
                          color: Colors.black87,
                          letterSpacing: 0.5,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
