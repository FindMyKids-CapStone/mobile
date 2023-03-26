import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

import '../core/colors/hex_color.dart';

const List<TabItem> items = [
  TabItem(icon: FontAwesomeIcons.mapLocation),
  TabItem(icon: FontAwesomeIcons.route),
  TabItem(icon: FontAwesomeIcons.plus),
  TabItem(icon: FontAwesomeIcons.microphone),
  TabItem(icon: FontAwesomeIcons.bars),
];

List<Marker> _markers = [
  Marker(
    width: 80,
    height: 80,
    point: LatLng(10.75, 106.682613),
    builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin),
  ),
  Marker(
    width: 80,
    height: 80,
    point: LatLng(10.76, 106.682626),
    builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin),
  ),
  Marker(
    width: 80,
    height: 80,
    point: LatLng(10.74, 106.682650),
    builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin),
  ),
];

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Marker? _marker;
  late final Timer _timer;
  int _markerIndex = 0;
  final int _selectedIndex = 0;
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _marker = _markers[_markerIndex];
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _marker = _markers[_markerIndex];
        _markerIndex = (_markerIndex + 1) % _markers.length;
      });
    });
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
          options: MapOptions(
              center: LatLng(10.762689, 106.682613),
              zoom: 18,
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
          return FloatingActionButton(
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.add),
                            Icon(Icons.meeting_room_outlined)
                          ],
                        )
                      ],
                    )),
              );
            },
            child: const Icon(Icons.group),
          );
        }));
  }
}
