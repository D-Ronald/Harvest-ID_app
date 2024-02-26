// ignore_for_file: deprecated_member_use

import 'package:debug_no_cell/pages/select_location_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class CadasterPropertyPage extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterPropertyPage> {
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  String locationMessage = "";
  bool isTomateiroSelected = false;

  Future<void> _enterZipCode() async {
  navigateToAnotherPage(context);
}

void navigateToAnotherPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SelectLocationPage()),
  );
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
          ElevatedButton(
            onPressed: _enterZipCode,
            child: const Text('SELECIONAR NO MAPA'),
          ),
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
