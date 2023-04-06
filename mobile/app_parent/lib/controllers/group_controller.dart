import 'dart:convert';

import 'package:app_parent/config/app_key.dart';
import 'package:app_parent/config/backend.dart';
import 'package:app_parent/models/group.dart';
import 'package:app_parent/models/location.dart';
import 'package:app_parent/service/spref.dart';
import 'package:app_parent/src/generated/streaming.pb.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/response.dart';

class GroupController extends GetxController {
  bool isAdmin = false;
  Group? targetGroup;
  List<Group> groups = [];
  List<LocationModel> locations = [];
  Location? currentLocation;

  Future<ResponseModel> kickMember(String groupId, String userId) async {
    print(SPref.instance.get(AppKey.authorization));
    var res = await http.post(Uri.parse('$BACKEND_HTTP/group/kickout'),
        headers: {
          "Content-type": "application/json",
          "Authorization":
              "firebase ${SPref.instance.get(AppKey.authorization)}"
        },
        body: jsonEncode({"groupID": groupId, "userID": userId}));
    var bodyJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
      targetGroup?.users?.removeWhere((element) => element.id == userId);
      update();
      return ResponseModel(
          isSuccess: true, message: bodyJson["data"]["message"]);
    } else {
      return ResponseModel(
          isSuccess: false, message: bodyJson["error"]["message"]);
    }
  }

  Future<ResponseModel> leaveGroup(String groupId) async {
    var res = await http.post(Uri.parse('$BACKEND_HTTP/group/leave'),
        headers: {
          "Content-type": "application/json",
          "Authorization":
              "firebase ${SPref.instance.get(AppKey.authorization)}"
        },
        body: jsonEncode({"groupID": groupId}));
    var bodyJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return ResponseModel(
          isSuccess: true, message: bodyJson["data"]["message"]);
    } else {
      return ResponseModel(
          isSuccess: false, message: bodyJson["error"]["message"]);
    }
  }

  Future<ResponseModel> disbandGroup() async {
    var res = await http.post(Uri.parse('$BACKEND_HTTP/group/disband'),
        headers: {
          "Content-type": "application/json",
          "Authorization":
              "firebase ${SPref.instance.get(AppKey.authorization)}"
        },
        body: jsonEncode({"groupID": targetGroup?.id}));
    var bodyJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return ResponseModel(
          isSuccess: true, message: bodyJson["data"]["message"]);
    } else {
      return ResponseModel(
          isSuccess: false, message: bodyJson["error"]["message"]);
    }
  }
}
