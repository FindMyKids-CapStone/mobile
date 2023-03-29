import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/room_fetch.dart';
import '../../../models/group.dart';
import '../../../models/location.dart';
import '../../../models/user_model.dart';
import '../../core/colors/hex_color.dart';
import '../../test/test.dart';
import 'item_member.dart';

class ListMember extends StatefulWidget {
  MapController controller;
  ListMember({super.key, required this.controller});

  @override
  State<ListMember> createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMember> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Query(
      options: QueryOptions(
        document: gql(RoomFetch.getDetailGroup
            .replaceAll("idRoom", "5cf89bb3-25b1-43cd-b4aa-d73819c330fc")),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return Container(
              margin: const EdgeInsets.only(top: 20),
              child: Column(children: const [
                CircularProgressIndicator(),
              ]));
        }
        print("Result $result");
        Group repositories = Group.fromJson(result.data?['groupByPK']);

        if (repositories == null) {
          return const Text('No repositories');
        }
        return SizedBox(
            width: double.infinity,
            child: Column(children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: const Text("Thành viên",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 23))),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: repositories.users!.length,
                itemBuilder: (context, index) {
                  UserModel responseData = repositories.users![index];
                  return Material(
                    child: InkWell(
                      splashFactory: InkRipple.splashFactory,
                      onTap: () async {
                        List<LocationModel> locations =
                            await getLocation(userId: [responseData.id ?? ""]);
                        widget.controller.move(
                            LatLng(
                                locations[0].latitude, locations[0].longitude),
                            widget.controller.zoom);
                      },
                      child: Ink(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ItemMember(user: responseData),
                        ),
                      ),
                    ),
                  );
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
                      child: const Text("Thêm thành viên mới"))),
            ]));
      },
    );
  }
}
