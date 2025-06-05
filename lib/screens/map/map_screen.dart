import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_shop/models/app_lat_long.dart';
import 'package:mini_shop/services/location/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();
  List<MapObject> mapObjects = [];

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Текущее местоположение')),
      body: YandexMap(
        mapObjects: mapObjects,
        onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
      ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = EkbLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    final controller = await mapControllerCompleter.future;

    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
          zoom: 12,
        ),
      ),
    );

    final userLocation = PlacemarkMapObject(
      mapId: const MapObjectId('user_location'),
      point: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/icons/location.png'), scale: 0.25),
      ),
    );

    setState(() {
      mapObjects = [userLocation];
    });
  }
}
