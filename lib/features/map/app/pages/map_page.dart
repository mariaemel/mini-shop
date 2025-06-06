import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_shop/features/map/data/models/map.dart';
import 'package:mini_shop/features/map/data/repos/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    _initPermission().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор местоположения')),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (controller) async {
              mapControllerCompleter.complete(controller);
              await _moveToCurrentLocation();
            },
          ),
          Center(child: IgnorePointer(child: Image.asset('assets/icons/location.png', width: 50, height: 50))),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                final controller = await mapControllerCompleter.future;
                final center = await controller.getCameraPosition().then((value) => value.target);
                final lat = center.latitude.toStringAsFixed(6);
                final long = center.longitude.toStringAsFixed(6);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Местоположение выбрано: $lat, $long')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text('Выбрать местоположение', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
  }

  Future<void> _moveToCurrentLocation() async {
    final controller = await mapControllerCompleter.future;

    AppLatLong location;
    const defLocation = EkbLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }

    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: location.lat, longitude: location.long),
          zoom: 18,
        ),
      ),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1),
    );
  }
}
