import 'dart:async';

import 'package:app_parent/src/generated/streaming.pbgrpc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../core/colors/hex_color.dart';
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
        setState(() {
          _marker = Marker(
              width: 80,
              height: 80,
              point: LatLng(position.latitude, position.longitude),
              builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin));
        });
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
    return Scaffold(
        extendBody: true,
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
        floatingActionButton: Builder(builder: (BuildContext context) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: const Color(0xFF2697FF),
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (_) => Container(
                    height: 550,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.1, 0.4, 0.7, 0.9],
                        colors: [
                          HexColor("#4b4293").withOpacity(1),
                          HexColor("#4b4293"),
                          HexColor("#08418e"),
                          HexColor("#08418e")
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.group),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: const Color(0xFF2697FF),
              onPressed: () {
                _mapController.move(
                    LatLng(position.latitude, position.longitude),
                    _mapController.zoom);
              },
              child: const Icon(Icons.my_location),
            ),
          ]);
        }));
  }
}
