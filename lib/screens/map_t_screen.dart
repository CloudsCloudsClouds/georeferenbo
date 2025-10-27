/*
Problema 2
¿Cómo se podría adaptar este código para crear una aplicación que muestre en el mapa los
principales puntos turísticos de La Paz (por ejemplo, Valle de la Luna, Plaza Murillo y Teleférico Rojo),
de manera que al presionar cada marcador se muestre el nombre del lugar en un cuadro emergente
(Popup o Dialog)?

Esta es la vista desde el google maps

import 'package:google_maps_flutter/google_maps_flutter.dart';

final LatLng laPazPoint = LatLng(-16.51150696, -68.08314407);

final Marker laPazMarker = Marker(
  markerId: MarkerId('la_paz_point'),
  position: laPazPoint,
  infoWindow: InfoWindow(
    title: 'Punto desde Google Earth',
    snippet: 'Altitud ≈ 3477.95 m • Heading 4.37° • Tilt 35°',
  ),
);

Gracias copilot.
*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../config/api_keys.dart';

class MapTScreen extends StatefulWidget {
  const MapTScreen({super.key});

  @override
  State<MapTScreen> createState() => _MapTScreenState();
}

class _MapTScreenState extends State<MapTScreen> {
  final mapController = MapController();
  final LatLng _center = LatLng(-16.51150696, -68.08314407);

  final List<Map<String, dynamic>> lugares = [
    {'nombre': 'Valle de la Luna', 'coordenadas': LatLng(-16.567, -68.097)},
    {'nombre': 'Plaza Murillo', 'coordenadas': LatLng(-16.5, -68.133)},
    {'nombre': 'Teleférico Rojo', 'coordenadas': LatLng(-16.504, -68.119)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de La Paz')),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(initialCenter: _center, initialZoom: 12.0),
        children: [
          TileLayer(
            urlTemplate: "https://maps.geoapify.com/v1/tile/osm-bright/{z}/{x}/{y}.png?apiKey=${ApiKeys.geoapifyApiKey}",
          ),
          MarkerLayer(
            markers: lugares.map((lugar) {
              return Marker(
                point: lugar['coordenadas'],
                width: 80,
                height: 80,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(lugar['nombre']),
                        content: Text('Este es un punto turístico en La Paz.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cerrar'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              );
            }).toList(),
          )
        ]
      )
    );
  }
}