import 'package:app_parent/src/core/fade_animation.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Cập nhật thông tin"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const FadeAnimation(
                          delay: 0.8,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/img/avatar.jpg"),
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
                              color: selected == FormData.Email
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
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Birthday
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              // controller: birthdayController,
                              onTap: () async {
                                setState(() {
                                  selected = FormData.Birthday;
                                });
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        1900), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  debugPrint(pickedDate
                                      .toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                  debugPrint(formattedDate.toString());

                                  // setState(() {
                                  //   birthdayController.text =
                                  //       formattedDate;
                                  // });
                                } else {
                                  debugPrint("Date is not selected");
                                }
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: selected == FormData.Birthday
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Birthday',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Birthday
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Birthday
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
                          height: 25,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                            onPressed: () {},
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
      ),
    );
  }
}
