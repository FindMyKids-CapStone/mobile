import 'package:app_parent/src/code_page/code_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/image-maps.jpg"),
                fit: BoxFit.cover,
                opacity: 0.3),
          ),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
              child: Column(children: [
                const Text("Chọn thiết bị của trẻ để thấy trẻ trên bản đồ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      FilledButton(
                        style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CodePage()));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: const [
                                Icon(FontAwesomeIcons.mobileScreenButton,
                                    color: Colors.blue, size: 24),
                                SizedBox(width: 10),
                                Text("Kết nối điện thoại của trẻ",
                                    style: TextStyle(color: Colors.black))
                              ]),
                              const FaIcon(
                                FontAwesomeIcons.chevronRight,
                                size: 15,
                              )
                            ]),
                      ),
                      const Divider(height: 1, thickness: 1),
                      FilledButton(
                        style: const ButtonStyle(
                            iconColor: MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {},
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: const [
                                Icon(
                                  Icons.watch_sharp,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text("Kết nối đồng hồ GPS",
                                    style: TextStyle(color: Colors.black))
                              ]),
                              const FaIcon(
                                FontAwesomeIcons.chevronRight,
                                size: 15,
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FilledButton(
                    style: const ButtonStyle(
                        iconColor: MaterialStatePropertyAll(Colors.black),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: const [
                            Icon(Icons.shopping_cart_outlined,
                                color: Colors.blue, size: 24),
                            SizedBox(width: 10),
                            Text("Mua một chiếc đồng hồ GPS",
                                style: TextStyle(color: Colors.black))
                          ]),
                          const FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: 15,
                          )
                        ]),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: FilledButton(
                    style: const ButtonStyle(
                        iconColor: MaterialStatePropertyAll(Colors.black),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: const [
                            Icon(Icons.group_add, color: Colors.blue, size: 24),
                            SizedBox(width: 10),
                            Text("Gia nhập gia đình",
                                style: TextStyle(color: Colors.black))
                          ]),
                          const FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: 15,
                          )
                        ]),
                  ),
                ),
              ]))),
    );
  }
}
