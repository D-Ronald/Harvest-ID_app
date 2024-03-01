// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class SelectLocationPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const SelectLocationPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  SelectLocationPageState createState() => SelectLocationPageState();

}

class SelectLocationPageState extends State<SelectLocationPage> {
  MapController _mapController = MapController();
 Offset? _selectedOffset;

void _confirmLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Localização confirmada com sucesso'),
        duration: Duration(seconds: 2), // Define a duração da mensagem
      ),
    );
    Navigator.pop(context, _selectedOffset);
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
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _selectedOffset = details.localPosition;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child:
             FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: LatLng(widget.latitude, widget.longitude), // Usando latitude e longitude fornecidas pelo widget
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
                    point: LatLng(widget.latitude, widget.longitude),
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
                   ),
              )],
         )
      )
      )]),);
  }
}