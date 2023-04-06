import 'dart:async';

import 'package:app_parent/controllers/group_controller.dart';
import 'package:app_parent/models/location.dart';
import 'package:app_parent/src/generated/streaming.pbgrpc.dart';
import 'package:app_parent/src/map_page/widget/list_member_widget.dart';
import 'package:app_parent/src/test/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../data/group_fetch.dart';
import '../../models/group.dart';
import '../../share/animation/route_transation.dart';
import '../setting_page/setting_page.dart';

class MapPage extends StatefulWidget {
  String targetGroupId;
  MapPage({super.key, required this.targetGroupId});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late MapTileLayerController _mapTileLayerController;
  List<MapMarker> marker = [];
  late Timer _timer;
  late Position position;
  final MapZoomPanBehavior _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: const MapLatLng(0, 0),
      minZoomLevel: 5,
      maxZoomLevel: 19.55,
      zoomLevel: 5,
      enableDoubleTapZooming: true);

  final double _initFabHeight = 130.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 100;
  late AnimationController controller;

  User? currentUser = FirebaseAuth.instance.currentUser;
  final GroupController _groupController = Get.find<GroupController>();

  @override
  void initState() {
    _fabHeight = _initFabHeight;
    _mapTileLayerController = MapTileLayerController();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    // controller.dispose();
    super.dispose();
  }

  Future<Position> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _panelHeightOpen = size.height * .5;
    return Query(
        options: QueryOptions(
            document: gql(GroupFetch.getDetailGroup
                .replaceAll("idRoom", widget.targetGroupId)),
            fetchPolicy: FetchPolicy.noCache),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()));
          }
          print("Result $result");
          Group repositories = Group.fromJson(result.data?['groupByPK']);

          if (repositories == null) {
            return const Text('No repositories');
          }
          bool isAdmin = repositories.createdBy == currentUser?.uid;

          _groupController.targetGroup = repositories;
          _groupController.isAdmin = isAdmin;
          _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
            position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            if (position.latitude !=
                    _groupController.currentLocation?.latitude &&
                position.longitude !=
                    _groupController.currentLocation?.longitude) {
              Location newLocation = Location(
                  latitude: position.latitude, longitude: position.longitude);
              sendCurrentLocation(
                  userId: currentUser?.uid ?? "", location: newLocation);
              _groupController.currentLocation = newLocation;
            }
            List<LocationModel> locations = await getLocation(
                userId:
                    repositories.users?.map((user) => user.id ?? "").toList() ??
                        []);
            _groupController.locations = locations;
            _groupController.update();
          });

          return FutureBuilder(
              future: getCurrentPosition(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _zoomPanBehavior.focalLatLng = MapLatLng(
                      snapshot.data?.latitude ?? 0,
                      snapshot.data?.longitude ?? 0);
                  _zoomPanBehavior.zoomLevel = 15;
                  return StatefulBuilder(
                      builder: (context, setStateInitMarker) {
                    setStateInitMarker(
                      () {
                        marker = [
                          MapMarker(
                              latitude: snapshot.data?.latitude ?? 0,
                              longitude: snapshot.data?.longitude ?? 0)
                        ];
                      },
                    );
                    return GetBuilder<GroupController>(builder: (controller) {
                      return Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.white,
                            titleTextStyle: const TextStyle(
                                color: Colors.black87, fontSize: 19),
                            title: const Text("Room"),
                            leading: GestureDetector(
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black87),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            actions: [
                              IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.black87),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      createRoute(widget: const SettingPage()));
                                },
                              )
                            ],
                          ),
                          extendBody: true,
                          body:
                              Stack(alignment: Alignment.topCenter, children: [
                            SlidingUpPanel(
                              minHeight: _panelHeightClosed,
                              maxHeight: _panelHeightOpen,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(30)),
                              panelBuilder: (scrollController) => ListMember(
                                  scrollController: scrollController,
                                  zoomPanBehavior: _zoomPanBehavior,
                                  users: controller.targetGroup?.users ?? [],
                                  isAdmin: controller.isAdmin,
                                  targetGroupId: widget.targetGroupId),
                              body: StatefulBuilder(
                                  builder: (context, mapSetState) {
                                List<MapMarker> newMarkers = controller
                                    .locations
                                    .map((location) => MapMarker(
                                        latitude: location.latitude,
                                        longitude: location.longitude))
                                    .toList();
                                if (newMarkers.isNotEmpty) {
                                  if (_mapTileLayerController.markersCount >
                                      0) {
                                    _mapTileLayerController.clearMarkers();
                                  }
                                  if (marker.isNotEmpty) {
                                    marker.asMap().forEach((index, element) {
                                      _mapTileLayerController
                                          .insertMarker(index);
                                    });
                                  }
                                  mapSetState(() {
                                    marker = newMarkers;
                                  });
                                }
                                return FutureBuilder(
                                    future: getBingUrlTemplate(
                                        'http://dev.virtualearth.net/REST/V1/Imagery/Metadata/Road?output=json&include=ImageryProviders&key=AkARLU75gtkZwPerbL6k2ODEHKIHdBAMH3wpNhhwESufXCVdmgp1W8AdCbwj0gX_'),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return SfMaps(
                                          layers: [
                                            MapTileLayer(
                                                controller:
                                                    _mapTileLayerController,
                                                zoomPanBehavior:
                                                    _zoomPanBehavior,
                                                urlTemplate:
                                                    snapshot.data ?? "",
                                                initialMarkersCount:
                                                    marker.length,
                                                markerBuilder:
                                                    (context, index) {
                                                  return marker[index];
                                                }),
                                          ],
                                        );
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    });
                              }),
                            ),
                            Positioned(
                              right: 10.0,
                              top: 10,
                              child: FloatingActionButton(
                                mini: true,
                                onPressed: () {},
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.message,
                                  size: 25,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ]));
                    });
                  });
                }
                return Container(
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()));
              });
        });
  }
}
