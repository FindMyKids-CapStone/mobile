import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/birthday.dart';
import 'components/phone.dart';

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
                              borderRadius: BorderRadius.circular(1000),
                              child: const Image(
                                  image: AssetImage("assets/img/avatar.jpg")))),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 15,
                          child: SvgPicture.asset("assets/svg/ic_camera.svg",
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
                        margin: const EdgeInsets.only(bottom: 7, left: 5),
                        child: const Text("Họ và tên",
                            style: TextStyle(fontSize: 17)),
                      ),
                      TextField(
                        style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                        controller: _nameController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 15, right: 15),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: "Họ và tên",
                        ),
                      )
                    ],
                  ),
                ),
                BirthdayEdition(birthday: widget.birthday),
                PhoneEdition(
                  // changePhone: setForm,
                  phone: widget.phone ?? "",
                  // isPhoneActivated:
                  //     authProvider.userLoggedIn.isPhoneActivated ?? false
                ),
                // DropdownEdit(
                //   title: lang.country,
                //   selectedItem: _country != null ? _country as String : "VN",
                //   items: countryList,
                //   onChange: setForm,
                //   fieldName: "Country",
                // ),
                // DropdownEdit(
                //   title: lang.level,
                //   selectedItem: _level != null ? _level as String : "BEGINNER",
                //   items: listLevel,
                //   onChange: setForm,
                //   fieldName: "Level",
                // ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 2, left: 5),
                //   child: Row(
                //     children: [
                //       Text(
                //         lang.wantToLearn,
                //         style: const TextStyle(fontSize: 17),
                //       ),
                //     ],
                //   ),
                // ),
                // WantToLearn(
                //     userTopics: _topics,
                //     editTopics: editTopics,
                //     userTestPreparations: _tests,
                //     editTestPreparations: editTests),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      // if (_phone != null && _phone?.isEmpty as bool) {
                      //   showTopSnackBar(
                      //     context,
                      //     CustomSnackBar.error(message: lang.errPhoneNumber),
                      //     showOutAnimationDuration:
                      //         const Duration(milliseconds: 700),
                      //     displayDuration: const Duration(milliseconds: 200),
                      //   );
                      // } else if (_nameController.text.isEmpty) {
                      //   showTopSnackBar(
                      //     context,
                      //     CustomSnackBar.error(message: lang.errEnterName),
                      //     showOutAnimationDuration:
                      //         const Duration(milliseconds: 700),
                      //     displayDuration: const Duration(milliseconds: 200),
                      //   );
                      // } else if (_birthday != null &&
                      //     _birthday!.millisecondsSinceEpoch >
                      //         DateTime.now().millisecondsSinceEpoch) {
                      //   showTopSnackBar(
                      //     context,
                      //     CustomSnackBar.error(message: lang.errBirthday),
                      //     showOutAnimationDuration:
                      //         const Duration(milliseconds: 700),
                      //     displayDuration: const Duration(milliseconds: 200),
                      //   );
                      // } else {
                      //   String bdArg =
                      //       "${_birthday!.year.toString()}-${_birthday!.month.toString().padLeft(2, "0")}-${_birthday!.day..toString().padLeft(2, "0")}";

                      //   final res = await UserService.updateInfo(
                      //     authProvider.tokens!.access.token,
                      //     _nameController.text,
                      //     _country as String,
                      //     bdArg,
                      //     _level as String,
                      //     _topics.map((e) => e.id.toString()).toList(),
                      //     _tests.map((e) => e.id.toString()).toList(),
                      //   );
                      //   if (res != null) {
                      //     authProvider.logIn(
                      //         res, authProvider.tokens as Tokens);
                      //     showTopSnackBar(
                      //       context,
                      //       CustomSnackBar.success(
                      //         message: lang.successUpdateProfile,
                      //         backgroundColor: Colors.green,
                      //       ),
                      //       showOutAnimationDuration:
                      //           const Duration(milliseconds: 700),
                      //       displayDuration: const Duration(milliseconds: 200),
                      //     );
                      //     Navigator.pop(context);
                      //   } else {
                      //     showTopSnackBar(
                      //       context,
                      //       CustomSnackBar.error(
                      //           message: lang.errUpdateProfile),
                      //       showOutAnimationDuration:
                      //           const Duration(milliseconds: 700),
                      //       displayDuration: const Duration(milliseconds: 200),
                      //     );
                      //   }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007CFF),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 13, bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Lưu", style: TextStyle(color: Colors.white))
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
