import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config/api_keys.dart';

class Map1Screen extends StatefulWidget {
  const Map1Screen({super.key});

  @override
  State<Map1Screen> createState() => _Map1ScreenState();
}

class _Map1ScreenState extends State<Map1Screen> {
  final MapController _mapController = MapController();
  final LatLng _center = LatLng(55.5, 55.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Map Example'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(initialCenter: _center, initialZoom: 5.0),
        children: [
          TileLayer(
            urlTemplate: "https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=${ApiKeys.geoapifyApiKey}",
            userAgentPackageName: "com.example.geoapify_flutter_map_example",
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _center,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}