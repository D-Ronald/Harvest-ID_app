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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'O serviço de localização está desativado';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw 'Você negou o acesso à sua localização, por favor ative em configurações do dispositivo';
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      locationMessage =
          'latitude: ${position.latitude}, longitude: ${position.longitude}';
    });
  }

  Future<void> _openMap() async {
    const String googleUrl = 'https://www.google.com/maps/search/?api=1';
    // ignore: deprecated_member_use
    if (await canLaunch(googleUrl)) {
      // ignore: deprecated_member_use
      await launch(googleUrl);
    } else {
      throw 'Erro ao abrir o mapa';
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
            const SizedBox(height: 16),
            Text(locationMessage),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('USAR MINHA LOCALIZAÇÃO ATUAL'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ou',
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
              onPressed: _openMap,
              child: const Text('SELECIONAR NO MAPA'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Checkbox(
                    value: false,
                    onChanged: (bool? checked) {},
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
