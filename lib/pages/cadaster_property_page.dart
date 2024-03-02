import 'package:debug_no_cell/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class CadasterProperty_page extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterProperty_page> {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  bool isChecked = false;
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
             spacing(context, 1),
            genericTextForm(
                context: context,
                controller: _cepController,
                labeltext: "Digite o CEP da sua propriedade:",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 25,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10),
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
            spacing(context, 3),
            genericButton(
              context,
              darkGreenBase,
              whiteBase,
              "Cadastrar propriedade",
              6,
              25,
              () {
                _autenthicationService.cadasterProperty(
                    context: context,
                    propertyName: _propertyNameController.text,
                    propertySize: _propertySizeController.text,
                    cep: _cepController.text,
                    isChecked: isChecked);
              },
            ),
          ],
        ),
      ),
    );
  }
}