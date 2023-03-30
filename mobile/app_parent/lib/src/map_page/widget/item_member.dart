import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';

class ItemMember extends StatefulWidget {
  UserModel user;
  ItemMember({super.key, required this.user});

  @override
  State<ItemMember> createState() => _ItemMemberState();
}

class _ItemMemberState extends State<ItemMember> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(top: 5),
            child: widget.user.photoURL != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.photoURL ?? ""),
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
            Text(
                widget.user.id == FirebaseAuth.instance.currentUser?.uid
                    ? "Tôi"
                    : widget.user.displayName ?? "Vô danh",
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Row(children: [
              Icon(Icons.phone, color: Colors.purple.shade400),
              const SizedBox(width: 5),
              Text(
                widget.user.phoneNumber ?? "Chưa cập nhật",
                style: const TextStyle(color: Colors.black87),
              )
            ]),
            Row(children: [
              Icon(Icons.person, color: Colors.purple.shade400),
              const SizedBox(width: 5),
              Text(
                widget.user.role == "owner" ? "Chủ phòng" : "Thành viên",
                style: const TextStyle(color: Colors.black87),
              )
            ]),
            Row(children: [
              Icon(Icons.schedule, color: Colors.purple.shade400),
              const SizedBox(width: 5),
              Text(
                widget.user.joinAt ?? "Không xác định",
                style: const TextStyle(color: Colors.black87),
              )
            ]),
          ],
        )
      ],
    );
  }
}
