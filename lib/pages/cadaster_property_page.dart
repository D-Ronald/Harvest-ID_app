import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CadasterPropertyPage extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterPropertyPage> {
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
    final result = await Navigator.pushNamed(context, '/map');
    if (result != null && result is Map<String, String>) {
      setState(() {
        latitude = double.tryParse(result['latitude'] ?? '');
        longitude = double.tryParse(result['longitude'] ?? '');
        locationMessage = 'Latitude: $latitude, Longitude: $longitude';
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLocationButton({required String label, required VoidCallback onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.green,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Propriedades'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Lógica de cadastro aqui
                _exibirDialogoCadastroSucesso(context);
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
