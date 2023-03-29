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
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../generated/streaming.pb.dart';
import '../test/test.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Marker? _marker;
  late final Timer _timer;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Position position;
  late final MapController _mapController;

  @override
  void initState() {
    print(SPref.instance.get(AppKey.authorization));
    super.initState();
    _mapController = MapController();
    _marker = Marker(
      width: 80,
      height: 80,
      point: LatLng(0, 0),
      builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin),
    );
    if (currentUser != null) {
      _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        sendCurrentLocation(
            userId: currentUser?.uid ?? "",
            location: Location(
                latitude: position.latitude, longitude: position.longitude));
        if (mounted) {
          setState(() {
            _marker = Marker(
                width: 80,
                height: 80,
                point: LatLng(position.latitude, position.longitude),
                builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin));
          });
        }
        _mapController.move(
            LatLng(position.latitude, position.longitude), _mapController.zoom);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Colors.black26,
        height: size.height,
        width: size.width,
        child: SlidingUpPanel(
          minHeight: 180,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          panel: ListMember(controller: _mapController),
          body: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                center: LatLng(10.762584, 106.682644),
                zoom: 15,
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.pinchZoom),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(markers: [_marker!]),
            ],
          ),
        ),
        // floatingActionButton: Builder(builder: (BuildContext context) {
        //   return Column(mainAxisSize: MainAxisSize.min, children: [
        //     FloatingActionButton(
        //       heroTag: "btn1",
        //       backgroundColor: const Color(0xFF2697FF),
        //       onPressed: () {
        //         showModalBottomSheet(
        //           isScrollControlled: true,
        //           shape: const RoundedRectangleBorder(
        //               borderRadius:
        //                   BorderRadius.vertical(top: Radius.circular(30))),
        //           context: context,
        //           builder: (_) => DraggableScrollableSheet(
        //               expand: false,
        //               initialChildSize: 0.4,
        //               maxChildSize: 0.9,
        //               minChildSize: 0.32,
        //               builder: (context, scrollController) => const ListMember()),
        //         );
        //       },
        //       child: const Icon(Icons.group),
        //     ),
        //     const SizedBox(height: 20),
        //     FloatingActionButton(
        //       heroTag: "btn1",
        //       backgroundColor: const Color(0xFF2697FF),
        //       onPressed: () {
        //         _mapController.move(LatLng(position.latitude, position.longitude),
        //             _mapController.zoom);
        //       },
        //       child: const Icon(Icons.my_location),
        //     ),
        //     const SizedBox(height: 20),

        //   ]);
        // }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "btn1",
      //   backgroundColor: const Color(0xFF2697FF),
      //   onPressed: () {
      //     FirebaseAuth.instance.signOut();
      //   },
      //   child: const Icon(Icons.logout),
      // ),
    );
  }
}
