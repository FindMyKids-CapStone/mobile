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
      titlePadding: EdgeInsets.fromLTRB(0, 25, 0, 0),
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Text(
        widget.type == "join" ? "Join a Group" : "Create a Group",
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
          child: const TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'Invitation Key',
              icon: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.mail),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          height: 50,
          child: const TextField(
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'Password',
              icon: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Icon(Icons.lock),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(onPressed: () {}, child: const Text("Cancel")),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {},
                child: Text(widget.type == "join" ? "Join" : "Create"))
          ]),
        ),
      ],
    );
  }
}
