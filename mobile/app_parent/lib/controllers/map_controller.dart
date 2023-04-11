import 'package:app_parent/models/location.dart';
import 'package:app_parent/src/generated/streaming.pb.dart';
import 'package:get/get.dart';

class MapCustomController extends GetxController {
  List<LocationModel> locations = [];
  Location? currentLocation;
}
