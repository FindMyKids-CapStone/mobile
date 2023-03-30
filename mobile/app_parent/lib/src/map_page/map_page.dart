import 'dart:async';

import 'package:app_parent/config/app_key.dart';
import 'package:app_parent/service/spref.dart';
import 'package:app_parent/src/map_page/widget/list_member_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../data/room_fetch.dart';
import '../../models/group.dart';
import '../../share/animation/route_transation.dart';
import '../generated/streaming.pb.dart';
import '../setting_page/setting_page.dart';
import '../test/test.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  Marker? _marker;
  late final Timer _timer;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Position position;
  final _mapController = MapController();

  final double _initFabHeight = 200.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 180;

  @override
  void initState() {
    print(SPref.instance.get(AppKey.authorization));
    super.initState();
    _marker = Marker(
      width: 80,
      height: 80,
      point: LatLng(0, 0),
      builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin),
    );
    _fabHeight = _initFabHeight;
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _panelHeightOpen = size.height * .70;
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
                color: Colors.black,
                child: const Image(
                    image: AssetImage("assets/img/zenly-logo.jpg")));
          }
          print("Result $result");
          Group repositories = Group.fromJson(result.data?['groupByPK']);

          if (repositories == null) {
            return const Text('No repositories');
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              titleTextStyle:
                  const TextStyle(color: Colors.black87, fontSize: 19),
              title: const Text("Phòng"),
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back, color: Colors.black87),
                onTap: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.black87),
                  onPressed: () {
                    Navigator.of(context)
                        .push(createRoute(widget: const SettingPage()));
                  },
                )
              ],
            ),
            extendBody: true,
            body: Stack(alignment: Alignment.topCenter, children: [
              SlidingUpPanel(
                onPanelSlide: (double pos) => setState(() {
                  _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                      _initFabHeight;
                }),
                minHeight: _panelHeightClosed,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                panel: ListMember(
                    controller: _mapController,
                    users: repositories.users ?? []),
                body: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(10.762584, 106.682644),
                    zoom: 6,
                    interactiveFlags: InteractiveFlag.drag |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.pinchZoom,
                    onMapReady: () async {
                      position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      _animatedMapMove(
                          LatLng(position.latitude, position.longitude), 15);
                      setState(() {
                        _marker = Marker(
                            width: 80,
                            height: 80,
                            point:
                                LatLng(position.latitude, position.longitude),
                            builder: (ctx) =>
                                const FaIcon(FontAwesomeIcons.locationPin));
                      });
                      if (currentUser != null) {
                        _timer = Timer.periodic(const Duration(seconds: 10),
                            (_) async {
                          position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                          sendCurrentLocation(
                              userId: currentUser?.uid ?? "",
                              location: Location(
                                  latitude: position.latitude,
                                  longitude: position.longitude));
                          if (mounted) {
                            setState(() {
                              _marker = Marker(
                                  width: 80,
                                  height: 80,
                                  point: LatLng(
                                      position.latitude, position.longitude),
                                  builder: (ctx) => const FaIcon(
                                      FontAwesomeIcons.locationPin));
                            });
                          }
                          _mapController.move(
                              LatLng(position.latitude, position.longitude),
                              _mapController.zoom);
                        });
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(markers: [_marker!]),
                  ],
                ),
              ),
              Positioned(
                right: 20.0,
                bottom: _fabHeight,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.message,
                    size: 25,
                    color: Colors.black54,
                  ),
                ),
              ),
            ]),
          );
        });
  }
}
