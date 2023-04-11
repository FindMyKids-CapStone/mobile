import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/group.dart';
import 'package:app_parent/models/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../../models/location.dart';
import '../../../models/user_model.dart';
import '../../core/colors/hex_color.dart';
import '../../test/test.dart';
import 'item_member.dart';

class ListMember extends StatefulWidget {
  ScrollController scrollController;
  MapZoomPanBehavior zoomPanBehavior;
  bool isAdmin;
  Group targetGroup;
  ListMember(
      {super.key,
      required this.zoomPanBehavior,
      required this.scrollController,
      required this.isAdmin,
      required this.targetGroup});

  @override
  State<ListMember> createState() => _ListMemberState();
}

class _ListMemberState extends State<ListMember> {
  bool isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final GroupController _groupController = Get.find<GroupController>();
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
            child: !isEditing
                ? Text.rich(
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 23),
                    TextSpan(
                      text: widget.targetGroup.name,
                      children: [
                        WidgetSpan(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                                onTap: () {
                                  _nameController.text =
                                      widget.targetGroup.name ?? "";
                                  setState(() {
                                    isEditing = true;
                                  });
                                },
                                child: const Icon(Icons.edit)),
                          ),
                        )
                      ],
                    ))
                : Row(children: [
                    SizedBox(
                        width: 150,
                        child: TextField(
                          autofocus: true,
                          controller: _nameController,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8)),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ResponseModel res = await _groupController
                              .updateGroup(name: _nameController.text);
                          _nameController.text = "";
                          setState(() {
                            isEditing = false;
                          });
                        },
                        child: const Text("Save"))
                  ])),
        const SizedBox(height: 20),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.targetGroup.users?.length,
          itemBuilder: (context, index) {
            UserModel responseData = widget.targetGroup.users![index];
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ItemMember(
                  targetGroupId: widget.targetGroup.id ?? "",
                  isAdmin: widget.isAdmin,
                  user: responseData,
                  jumpToLocation: () async {
                    List<LocationModel> locations =
                        await getLocation(userId: [responseData.id ?? ""]);
                    print(locations[0].latitude);
                    print(locations[0].longitude);
                    widget.zoomPanBehavior.focalLatLng = MapLatLng(
                        locations[0].latitude - 0.002, locations[0].longitude);
                    widget.zoomPanBehavior.zoomLevel = 17;
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
            child: GetBuilder<GroupController>(builder: (controller) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return SimpleDialog(
                          children: [
                            const Text(
                                "Send this code to your friend so they can join group",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(children: [
                                  TextSpan(
                                    text: controller.targetGroup?.code ?? "",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: HexColor("#4b4293"),
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  WidgetSpan(
                                      child: GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                              text:
                                                  controller.targetGroup?.code))
                                          .then((value) =>
                                              AnimatedSnackBar.material(
                                                "Copy to clipboard",
                                                type: AnimatedSnackBarType.info,
                                              ).show(dialogContext));
                                    },
                                    child: const Icon(Icons.copy),
                                  ))
                                ]))
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("Add new member"));
            })),
      ]),
    );
  }
}
