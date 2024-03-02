import 'package:csc_picker/csc_picker.dart';
import 'package:debug_no_cell/pages/select_location_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CadasterPropertyPage extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterPropertyPage> {
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String locationMessage = "";
  bool isTomateiroSelected = false;
  double _latitude = 0.0;
  double _longitude = 0.0;
  String? selectedCountry;
  String? selectedCity;
  String? selectedState;

  Future<void> _getCoordinatesFromAddress() async {
    try {
      String address = '';
      if (selectedCountry != null) {
        address += '${selectedCountry!}, ';
      }
      if (selectedState != null) {
        address += '${selectedState!}, ';
      }
      if (selectedCity != null) {
        address += '${selectedCity!}, ';
      }
      if (_addressController.text.isNotEmpty) {
        address += _addressController.text;
      }

      if (address.isNotEmpty) {
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          Location location = locations.first;
          setState(() {
            _latitude = location.latitude;
            _longitude = location.longitude;
            locationMessage =
                "Latitude: ${location.latitude}, Longitude: ${location.longitude}";
          });
        } else {
          setState(() {
            locationMessage =
                "Não foi possível encontrar as coordenadas para este endereço.";
          });
        }
      } else {
        setState(() {
          locationMessage = "Por favor, insira um endereço válido.";
        });
      }
    } catch (e) {
      setState(() {
        locationMessage = "Erro ao obter coordenadas: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CADASTRO DE PROPRIEDADES',
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
        child: Column(children: [
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
          spacing(context, 3),
          Container(
            padding: const EdgeInsets.all(10),
            child: CSCPicker(
              onCountryChanged: (country) {
                setState(() {
                  selectedCountry = country;
                });
              },
              onCityChanged: (city) {
                setState(() {
                  selectedCity = city;
                });
              },
              onStateChanged: (state) {
                setState(() {
                  selectedState = state;
                });
              },
              dropdownDialogRadius: 20,
              searchBarRadius: 20,
              countrySearchPlaceholder: "País",
              stateSearchPlaceholder: "Estado",
              citySearchPlaceholder: "Cidade",
              countryDropdownLabel: "País",
              cityDropdownLabel: "Cidade",
              stateDropdownLabel: "Estado",
            ),
          ),
          spacing(context, 3),
          genericTextForm(
              context: context,
              controller: _addressController,
              labeltext: "Digite o distrito ou endereço da sua propriedade ",
              labelColor: darkGrayBase,
              heightPercentage: 8,
              padding: 25,
              color: blackBase,
              backgroundColor: mediumGrayBase,
              borderRadius: 10),
          spacing(context, 1),
          Text(
            locationMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          spacing(context, 2),
          const Text(
            'Clique no botão abaixo para selecionar sua propriedade no mapa',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (selectedCountry == null ||
                  selectedState == null ||
                  selectedCity == null ||
                  _addressController.text.isEmpty) {
                setState(() {
                  locationMessage =
                      "Por favor, preencha todos os campos de localização.";
                });
                return;
              }

              await _getCoordinatesFromAddress(); // Obtém as coordenadas do endereço

              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectLocationPage(
                    latitude: _latitude,
                    longitude: _longitude,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('SELECIONAR LOCALIZAÇÃO NO MAPA'),
          ),
          spacing(context, 2),
          const Text(
            'Assinale abaixo as plantações que você tem em sua propriedade',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Checkbox(
                  value: isTomateiroSelected,
                  onChanged: (bool? checked) {
                    setState(() {
                      isTomateiroSelected = checked ?? false;
                    });
                  },
                  activeColor: const Color(0x3F000000),
                ),
              ),
              const Text('Tomateiro'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Função para cadastrar a propriedade
            },
            child: const Text('Cadastrar propriedade'),
          ),
        ]),
      ),
    );
  }
}
