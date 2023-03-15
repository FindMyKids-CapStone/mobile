import 'dart:convert';

import 'package:app_parent/controllers/user_controller/user_controller.dart';
import 'package:app_parent/models/profile_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/birthday.dart';
import 'components/phone.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  DateTime? birthday;
  String? phone;
  String? name;
  String? email;

  ProfilePage({super.key, this.birthday, this.email, this.name, this.phone});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();

  // setForm(
  //     {DateTime? birthday,
  //     String phone = "",
  //     String country = "",
  //     String level = ""}) {
  //   setState(() {
  //     _birthday = birthday ?? DateTime.now();
  //     if (phone.isNotEmpty) {
  //       _phone = phone;
  //     }
  //     if (country.isNotEmpty) {
  //       _country = country;
  //     }
  //     if (level.isNotEmpty) {
  //       _level = level;
  //     }
  //   });
  // }

  // editTopics(List<LearnTopic> topics) {
  //   setState(() {
  //     _topics = topics;
  //   });
  // }

  // editTests(List<TestPreparation> tests) {
  //   setState(() {
  //     _tests = tests;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              // Extracting data from snapshot object
              final data = snapshot.data as User;
              debugPrint("fullName ${data.fullName}");
              _nameController.text = data.fullName ?? "";
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    leadingWidth: 20,
                    centerTitle: false,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.grey[800]),
                    title: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Thông tin cá nhân",
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: const Image(
                                            image: AssetImage(
                                                "assets/img/avatar.jpg")))),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    radius: 15,
                                    child: SvgPicture.asset(
                                        "assets/svg/ic_camera.svg",
                                        color: Colors.grey[700]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(widget.email ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500)),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 7, left: 5),
                                  child: const Text("Họ và tên",
                                      style: TextStyle(fontSize: 17)),
                                ),
                                TextField(
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.grey[900]),
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black26, width: 0.3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintText: "Họ và tên",
                                  ),
                                )
                              ],
                            ),
                          ),
                          BirthdayEdition(birthday: data.birthday),
                          PhoneEdition(
                            phone: data.phoneNumber ?? "",
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                debugPrint("abc");
                                var client = http.Client();
                                try {
                                  var res = await client.get(Uri.parse(
                                      'http://10.124.7.242:8080/information'));
                                  jsonEncode(res.body);
                                  debugPrint(res.body);
                                } catch (err) {
                                  debugPrint("err: $err");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff007CFF),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 13, bottom: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("Lưu",
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
