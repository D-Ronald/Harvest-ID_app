import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:debug_no_cell/utils/base.dart';

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CEP não encontrado')),
          );
        }
      } catch (e) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            spacing(context, 2),
            genericBigImage(
              context: context,
              src: "assets/images/NameGray.png",
              heightPercentage: 4,
              widthPercentage: 30,
            ),
            spacing(context, 2),
            Center(
              child: Transform.rotate(
                angle: -3.14,
                child: Container(
                  width: 354,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
            Expanded(
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
          ],
        ),
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
