// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  SelectLocationPageState createState() => SelectLocationPageState();
}

class SelectLocationPageState extends State<SelectLocationPage> {
  TextEditingController _searchController = TextEditingController();
  MapController _mapController = MapController();
  Offset? _selectedOffset;
void _searchAddress() async {
    String address = _searchController.text;
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      LatLng coordinates =
          LatLng(locations[0].latitude, locations[0].longitude);
      _mapController.move(coordinates, 15.0);
    } else {
      print('Nenhum local encontrado para o endereço fornecido');
    }
  }

  void _confirmLocation() {
    if (_selectedOffset != null) {
      // Obtém as coordenadas de latitude e longitude dos cantos superior esquerdo e inferior direito do mapa
      LatLngBounds? bounds = _mapController.bounds;
      if (bounds != null) {
        LatLng topLeft = bounds.northWest;
        LatLng bottomRight = bounds.southEast;

        // Calcula a extensão do mapa (diferença entre as coordenadas dos cantos)
        double mapLatDiff = topLeft.latitude - bottomRight.latitude;
        double mapLngDiff = bottomRight.longitude - topLeft.longitude;

        // Calcula as coordenadas de latitude e longitude correspondentes ao ponto tocado na tela
        double latitude = topLeft.latitude - (mapLatDiff * _selectedOffset!.dy / MediaQuery.of(context).size.height);
        double longitude = topLeft.longitude + (mapLngDiff * _selectedOffset!.dx / MediaQuery.of(context).size.width);

        // Usa as coordenadas de latitude e longitude calculadas para qualquer finalidade que desejar
        LatLng selectedLatLng = LatLng(latitude, longitude);
        print('Latitude e Longitude do ponto tocado: $selectedLatLng');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOCALIZAÇÃO DA PROPRIEDADE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor:  const Color.fromRGBO(19, 56, 58, 1),
        shadowColor:  const Color.fromRGBO(19, 56, 60, 38),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),

          body: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Digite o endereço...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: _searchAddress,
              ),
            ),
          ),
           Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _selectedOffset = details.localPosition;
                });
              })),

          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                center: LatLng(-23.493895, -46.533156),
                minZoom: 5.0,
                maxZoom: 25,
                zoom: 10.0,
              ),
        children: [
        TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXJpc291IiwiYSI6ImNsdDZmOTFhNTA0N24ydXA2N200aWo2cTYifQ.gn_rfxgxk0SMD2hJ7ZFIwQ',
            additionalOptions: const {'accessToken': 'MAPBOX_ACCESS_TOKEN',
                                      'id': 'mapbox/satellite-v9' },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(-23.493895, -46.533156),
                child: Container(
                     child: const Icon(
                    Icons.person_pin,
                    color: Colors.blue,
                    size: 40,
                  ),
                )
          )],
          ),
            ElevatedButton(
            onPressed: _selectedOffset != null ? _confirmLocation : null,
            child: const Text('Confirmar Localização'),
            )]
      )
      )
      ]),);
  }
}