import 'package:app_parent/src/profile_page/profile_page.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_map_example/widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

const List<TabItem> items = [
  TabItem(icon: FontAwesomeIcons.mapLocation),
  TabItem(icon: FontAwesomeIcons.route),
  TabItem(icon: FontAwesomeIcons.plus),
  TabItem(icon: FontAwesomeIcons.microphone),
  TabItem(icon: FontAwesomeIcons.bars),
];

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _selectedIndex = 0;
  LocationData? _currentLocation;
  late final MapController _mapController;
  final _controller = ValueNotifier<bool>(false);

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  int interActiveFlags = InteractiveFlag.pinchZoom |
      InteractiveFlag.drag |
      InteractiveFlag.doubleTapZoom;

  final Location _locationService = Location();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged
              .listen((LocationData result) async {
            if (mounted) {
              setState(() {
                _currentLocation = result;

                // If Live Update is enabled, move map center
                if (_liveUpdate) {
                  _mapController.move(
                      LatLng(_currentLocation!.latitude!,
                          _currentLocation!.longitude!),
                      _mapController.zoom);
                }
              });
            }
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    // Until currentLocation is initially updated, Widget can locate to 0, 0
    // by default or store previous location value to show.
    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    final markers = <Marker>[
      Marker(
          width: 80,
          height: 80,
          point: currentLatLng,
          builder: (ctx) => const FaIcon(FontAwesomeIcons.locationPin)),
    ];

    return _selectedIndex != 4
        ? Scaffold(
            extendBody: true,
            body: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                  center:
                      LatLng(currentLatLng.latitude, currentLatLng.longitude),
                  zoom: 5,
                  interactiveFlags: interActiveFlags),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(markers: markers),
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
                  onPressed: () {
                    setState(() {
                      _liveUpdate = !_liveUpdate;

                      if (_liveUpdate) {
                        interActiveFlags = InteractiveFlag.pinchZoom |
                            InteractiveFlag.doubleTapZoom;
                      } else {
                        interActiveFlags = InteractiveFlag.pinchZoom |
                            InteractiveFlag.drag |
                            InteractiveFlag.doubleTapZoom;
                      }
                    });
                  },
                  child: _liveUpdate
                      ? const Icon(Icons.location_on)
                      : const Icon(Icons.location_off),
                )
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
