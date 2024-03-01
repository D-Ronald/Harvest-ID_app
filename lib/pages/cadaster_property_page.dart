import 'package:debug_no_cell/pages/select_location_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapbox;

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
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  Future<LatLng?> getLocationFromAddress(
      String country, String state, String city, String district) async {
    try {
      String address = '$district, $city, $state, $country';
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location firstLocation = locations.first;
        return LatLng(firstLocation.latitude, firstLocation.longitude);
      } else {
        return null; // Se não for possível encontrar a localização, retorne null
      }
    } catch (e) {
      print('Erro ao obter localização a partir do endereço: $e');
      return null;
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
              labeltext:
                  "Digite o nome do distrito em que está sua propriedade ",
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
              color: Colors.red, // Cor vermelha para indicar erro
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
          spacing(context, 1),
          ElevatedButton(
            onPressed: () async {
              // Chamar a função para obter as coordenadas da localização
              LatLng? location = await getLocationFromAddress(selectedCountry!,
                  selectedState!, selectedCity!, _addressController.text);

              // Verificar se a localização foi obtida com sucesso
              if (location != null) {
                // Navegar para a página SelectLocationPage passando as coordenadas da localização
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectLocationPage(
                      country: selectedCountry!,
                      state: selectedState!,
                      city: selectedCity!,
                      district: _addressController.text,
                      latitude: location.latitude,
                      longitude: location.longitude,
                    ),
                  ),
                );
              } else {
                // Se não for possível obter a localização, exiba uma mensagem de erro
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível encontrar a localização.'),
                  ),
                );
              }
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
              height: 0,
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
