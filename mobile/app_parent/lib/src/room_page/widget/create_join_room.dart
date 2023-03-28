import 'package:flutter/material.dart';

class DialogCreateJoin extends StatefulWidget {
  String type;
  DialogCreateJoin({super.key, required this.type});

  @override
  State<DialogCreateJoin> createState() => _DialogCreateJoinState();
}

class _DialogCreateJoinState extends State<DialogCreateJoin> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Text(
        widget.type == "join" ? "Tham gia phòng" : "Tạo phòng",
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    borderSide: const BorderSide(width: 0)),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0)),
                hintText: 'Tên phòng',
              ),
              textAlignVertical: TextAlignVertical.center,
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    borderSide: const BorderSide(width: 0)),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0)),
                hintText: 'Mật khẩu',
              ),
              textAlignVertical: TextAlignVertical.center,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            ElevatedButton(onPressed: () {}, child: const Text("Hủy")),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {},
                child: Text(widget.type == "join" ? "Tham gia" : "Tạo"))
          ]),
        ),
      ],
    );
  }
}
