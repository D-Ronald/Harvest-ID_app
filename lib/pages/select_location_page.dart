import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  const SelectLocationPage(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  late GoogleMapController _mapController;
  late LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = LatLng(widget.latitude, widget.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _moveToSelectedPosition();
  }

  void _moveToSelectedPosition() {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _selectedPosition,
        zoom: 15,
      ),
    ));
  }

  void _onMarkerDragEnd(LatLng newPosition) {
    setState(() {
      _selectedPosition = newPosition;
    });
  }

  void _confirmLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Localização da sua propriedade foi salva com sucesso'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Localização'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _selectedPosition,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('selected_location'),
            position: _selectedPosition,
            draggable: true, // Permitir que o marcador seja arrastado
            onDragEnd:
                _onMarkerDragEnd, // Função chamada quando o arrastar termina
          ),
        },
      ),
    );
  }
}
