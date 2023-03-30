import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87, fontSize: 19),
        title: const Text("Cài đặt"),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back, color: Colors.black87),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
      ),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12)),
              color: Colors.white),
          child: Material(
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Ink(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text(
                        "Đăng xuất",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
