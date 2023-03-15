import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapLatLng _center = const MapLatLng(0, 0);
  late Position currentLocation;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  getUserLocation() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _center = MapLatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $_center');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder(
        future: getBingUrlTemplate(
            'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/Aerial?output=json&uriScheme=https&include=ImageryProviders&key=AkSR8vPQ3mwjNlD9fRT9W4DcV3AEferDXLxQJruIuYc1Vea0IYc4fKl0wWcWryvH'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(_center);
            _zoomPanBehavior = MapZoomPanBehavior(
                focalLatLng: _center,
                minZoomLevel: 10,
                maxZoomLevel: 19.55,
                zoomLevel: 17,
                enableDoubleTapZooming: true);

            return SfMaps(layers: <MapLayer>[
              MapTileLayer(
                urlTemplate: snapshot.data as String,
                zoomPanBehavior: _zoomPanBehavior,
              )
            ]);
          }
          return const Center(
            child: SpinKitCircle(
              color: Colors.black,
              size: 50.0,
            ),
          );
        },
      ),
    );
  }
}
