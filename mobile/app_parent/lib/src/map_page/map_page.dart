import 'dart:async';

import 'package:app_parent/src/profile_page/profile_page.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';

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
  int _selectedIndex = 0;
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
    return _selectedIndex != 4
        ? Scaffold(
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
              return Column(mainAxisSize: MainAxisSize.min, children: [
                FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Colors.green,
                    onPressed: () {},
                    child: SvgPicture.asset(
                      "assets/svg/ic_phone_plus.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )),
                const SizedBox(height: 5),
                FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.black,
                    )),
                const SizedBox(height: 5),
                FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () {},
                    child: const Icon(Icons.location_on))
              ]);
            }),
            bottomNavigationBar:
                Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                          child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromHeight(60)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.blueAccent),
                                  ),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child: const Text(
                                "Trung không trả lời tôi cần làm gì bây giờ",
                                style: TextStyle(fontSize: 12),
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromHeight(60)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.blueAccent),
                                  ),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child: const Text(
                                "Âm thanh xung quanh trẻ",
                                style: TextStyle(fontSize: 12),
                              ))),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: TextButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  fixedSize: MaterialStatePropertyAll(
                                      Size.fromHeight(60)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                  side: MaterialStatePropertyAll(
                                    BorderSide(color: Colors.blueAccent),
                                  ),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))))),
                              child: const Text(
                                "Trung không trả lời tôi cần làm gì bây giờ",
                                style: TextStyle(fontSize: 12),
                              ))),
                    ],
                  )),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 3,
                          spreadRadius: 0.1,
                          offset: Offset(0, 2.5))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.vibration),
                              SizedBox(width: 5),
                              Text("Rung")
                            ],
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: const [
                              Icon(FontAwesomeIcons.batteryThreeQuarters),
                              SizedBox(width: 5),
                              Text("89%")
                            ],
                          )
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Thông tin vị trí theo thời gian thực"),
                          AdvancedSwitch(
                            controller: _controller,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BottomBarCreative(
                items: items,
                backgroundColor: Colors.white,
                color: Colors.black,
                colorSelected: Colors.blueAccent,
                indexSelected: _selectedIndex,
                onTap: (int index) => setState(() {
                  _selectedIndex = index;
                }),
              ),
            ]))
        : ProfilePage(
            selectedIndex: _selectedIndex,
            setNavBarIndex: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          );
  }
}
