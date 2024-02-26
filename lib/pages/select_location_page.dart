import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  TextEditingController _cepController = TextEditingController();
  GoogleMapController? _mapController;
  LatLng? _selectedPosition;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _searchLocationByCEP() async {
    String cep = _cepController.text.trim();
    if (cep.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(cep);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          _mapController?.animateCamera(CameraUpdate.newLatLng(
            LatLng(location.latitude, location.longitude),
          ));
          setState(() {
            _selectedPosition = LatLng(location.latitude, location.longitude);
          });
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CEP não encontrado')),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar localização: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um CEP')),
      );
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
        backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
        shadowColor: const Color.fromRGBO(19, 56, 60, 38),
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
          SizedBox(
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(-15.7942, -47.8825), // Brasília como posição inicial padrão
                zoom: 15,
              ),
              onMapCreated: _onMapCreated,
              onTap: (position) {
                setState(() {
                  _selectedPosition = position;
                });
              },
              markers: _selectedPosition != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected_position'),
                        position: _selectedPosition!,
                      ),
                    }
                  : {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'CEP',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchLocationByCEP,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedPosition != null) {
            Navigator.of(context).pop(_selectedPosition);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Por favor, selecione uma localização')),
            );
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
