import 'package:debug_no_cell/pages/coordinates.dart';
import 'package:debug_no_cell/services/auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';



class CadasterPropertyPage extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterPropertyPage> {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();

  bool isChecked = false;
  var locationMessage = "";
  double? latitude;
  double? longitude;

  void getCurrentLocation({LocationAccuracy accuracy = LocationAccuracy.high}) async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        locationMessage = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        locationMessage = "Erro ao obter localização: ${e.toString()}";
      });
    }
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CoordenadasPage()),
  );
  
  if (result != null && result is Map<String, String>) {
    setState(() {
      latitude = double.tryParse(result['latitude'] ?? '');
      longitude = double.tryParse(result['longitude'] ?? '');
      locationMessage = 'Latitude: $latitude, Longitude: $longitude';
    });
  }
}


  Widget _buildLocationButton({required String label, required VoidCallback onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(63, 0, 0, 0),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
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

  Widget spacing(BuildContext context, double factor) {
    // Retorna um SizedBox para adicionar espaçamento
    return SizedBox(height: factor * 10);
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
              child: Transform.rotate(
                angle: -3.14,
                child: Container(
                  width: 354,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            spacing(context, 4),
            genericTextForm(
                context: context,
                controller: _propertyNameController,
                labeltext: "Nome da propriedade",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 25,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10),
            spacing(context, 1),
            genericTextForm(
                context: context,
                controller: _propertySizeController,
                labeltext: "Tamanho da propriedade em hectares",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 25,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10),
            spacing(context, 3),
            const SizedBox(
              width: 357,
              height: 31,
              child: Text(
                'LOCALIZAÇÃO',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 46,
                  ),
                  const SizedBox(height: 20),
                  Text("Posição: $locationMessage"),
                  _buildLocationButton(
                    label: 'Usar localização atual',
                    onPressed: () => getCurrentLocation(),
                  ),
                  _buildLocationButton(
                    label: 'Informar coordenadas',
                    onPressed: () => _navigateAndDisplaySelection(context),
                  ),
                  Row(
                    children: [
                      Checkbox(
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
                      const Text('Tomateiro'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(63, 0, 0, 0),
              ),
              onPressed: () {
                  _autenthicationService.cadasterProperty(
                  context: context,
                  propertyName: _propertyNameController.text,
                  propertySize: _propertySizeController.text,
                  isChecked: isChecked,
                  latitude: latitude,
                  longitude: longitude,
    );
  },
              child: const Text(
                'Cadastrar propriedade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
