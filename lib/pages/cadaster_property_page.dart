import 'package:debug_no_cell/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CadasterProperty_page extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterProperty_page> {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  bool isChecked = false;
  var locationMessage = "";
  double? latitude;
  double? longitude;

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      locationMessage =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/map');
    if (result != null && result is Map<String, String>) {
      setState(() {
        latitude = double.tryParse(result['latitude'] ?? '');
        longitude = double.tryParse(result['longitude'] ?? '');
        locationMessage =
            'Latitude: $latitude, Longitude: $longitude';
      });
    }
  }

  void _exibirDialogoCadastroSucesso(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastro Efetuado'),
          content: const Text('Sua propriedade foi cadastrada com sucesso!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); //
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'CADASTRO DE PROPRIEDADES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            )
          ],
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
                widthPercentage: 30),
            spacing(context, 2),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 46,
                  ),
                  const SizedBox(height: 20),
                  Text("Posição: $locationMessage"),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: darkGreenBase, // Cor de fundo
                    ),
                    onPressed: () async {
                      getCurrentLocation();
                    },
                    child: const Text(
                      'Usar localização atual',
                      style: TextStyle(color: whiteBase),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: darkGreenBase, // Cor de fundo
                    ),
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    child: const Text(
                      'Informar coordenadas',
                      style: TextStyle(color: whiteBase),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? checked) {
                            if (checked != null) {
                              setState(() {
                                isChecked = checked;
                              });
                            }
                          },
                          activeColor: const Color(0x3F000000),
                        ),
                      ),
                      const Text('Tomateiro'),
                    ],
                  ),
                ],
              ),
            ),
            spacing(context, 3),
            genericButton(
              context,
              darkGreenBase,
              whiteBase,
              "Cadastrar propriedade",
              6,
              25,
              () {
                // Lógica de cadastro aqui
              },
            ),
          ],
        ),
    ),
);
}
}