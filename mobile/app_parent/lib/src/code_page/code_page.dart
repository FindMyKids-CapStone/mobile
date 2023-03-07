import 'package:flutter/material.dart';

class CodePage extends StatelessWidget {
  const CodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/image-maps.jpg"),
              fit: BoxFit.cover,
              opacity: 0.3),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 30, left: 30, bottom: 200),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 10))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(children: const [Icon(Icons.arrow_back)]),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: const [
                          Text(
                            "Nhấp vào liên kết được gửi đến điện thoại của con bạn, cài đặt ứng dụng Pingo và nhập mã:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Y8BL3",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.blue,
                                letterSpacing: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Mã này sẽ kết nối ứng dụng Pingo với ứng dụng Find My Kids trên điện thoại của cha mẹ và mọi tính năng sẽ bắt đầu hoạt động!",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
