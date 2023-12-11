import 'package:debug_no_cell/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
    

}


class CadasterProperty_page extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterProperty_page> {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  bool isChecked = false;
  String? _propertyName;
  String? _propertySize;
  String? _address;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;


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
        appBar: AppBar(title: const Text('Cadastre a Propriedade')),
        body: SingleChildScrollView(
            child: Column(children: [
      genericBigImage(
          context: context,
          src: "assets/images/NameGray.png",
          heightPercentage: 5,
          widthPercentage: 50),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _propertyNameController,
          labeltext: "Nome da propriedade",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 10,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _propertySizeController,
          labeltext: "Tamanho da propriedade em hectares",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 10,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 3),
          const SizedBox(
              width: 357,
              height: 31,
              child: Text(
                'LOCALIZAÇÃO',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
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
            onCountryChanged: (country){
              _selectedCountry = country;

            },
            onCityChanged: (city){
              _selectedCity = city;
            },
            onStateChanged: (state){
              _selectedState = state;
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
      genericTextFormPassword(
          context: context,
          controller: _addressController,
          labeltext: "Endereço",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 10,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10),

      spacing(context, 5),
      const SizedBox(
        width: 406,
        height: 50,
        child: Text(
          'Quais destas culturas estão presentes em sua plantação?',
          style: TextStyle(
            color: Color.fromRGBO(62, 68, 69, 1),
            fontSize: 16,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w400,
            height: 0,
),
),
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
      spacing(context, 5),
        genericButton(
          context,
          darkGreenBase,
          white_base,
          "Cadastrar propriedade",
          5,
          30,
          (){
            _autenthicationService.cadasterProperty(context: context, 
            propertyName: _propertyNameController.text, 
            propertySize: _propertySizeController.text, 
            address: _addressController.text, 
            selectedCountry: _selectedCountry, 
            selectedState: _selectedState, 
            selectedCity: _selectedCity, 
            isChecked: isChecked);
              
      },
            ),
          ],
        ),
      ),
    );
  }
}