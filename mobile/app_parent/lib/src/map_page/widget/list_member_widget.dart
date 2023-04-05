import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../models/location.dart';
import '../../../models/user_model.dart';
import '../../core/colors/hex_color.dart';
import '../../test/test.dart';
import 'item_member.dart';

class ListMember extends StatefulWidget {
  ScrollController scrollController;
  MapController mapController;
  List<UserModel> users;
  bool isAdmin;
  String targetGroupId;
  ListMember(
      {super.key,
      required this.mapController,
      required this.users,
      required this.scrollController,
      required this.isAdmin,
      required this.targetGroupId});

  @override
  State<ListMember> createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMember> {
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   padding: EdgeInsets.zero,
    //   children: const [
    //     SizedBox(
    //       height: 36,
    //     ),
    //     SizedBox(
    //       height: 24,
    //     ),
    //   ],
    // );
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: ListView(controller: widget.scrollController, children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            )),
        const SizedBox(height: 10),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: const Text("Members",
                textAlign: TextAlign.left, style: TextStyle(fontSize: 23))),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.users.length,
          itemBuilder: (context, index) {
            UserModel responseData = widget.users[index];
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ItemMember(
                  targetGroupId: widget.targetGroupId,
                  isAdmin: widget.isAdmin,
                  user: responseData,
                  jumpToLocation: () async {
                    List<LocationModel> locations =
                        await getLocation(userId: [responseData.id ?? ""]);
                    widget.mapController.move(
                        LatLng(locations[0].latitude - 0.003,
                            locations[0].longitude),
                        16);
                  },
                ),
              ),
              const Divider()
            ]);
          },
        ),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
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
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                onPressed: () {},
                child: const Text("Add new member"))),
      ]),
    );
  }
}
