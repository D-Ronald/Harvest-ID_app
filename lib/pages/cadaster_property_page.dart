import 'package:csc_picker/csc_picker.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/services/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
}

class CadasterProperty_page extends StatefulWidget {
  @override
  _CadasterPropertyPageState createState() => _CadasterPropertyPageState();
}

class _CadasterPropertyPageState extends State<CadasterProperty_page> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _propertySizeController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Cadastre a Propriedade')),
        body: Center(
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
          padding: 20,
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
          padding: 20,
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
                  fontSize: 16,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w400,
                  height: 0,
        ),
    ),
),
      spacing(context, 3),
      CSCPicker(
            onCountryChanged: (country){},
            onCityChanged: (city){},
            onStateChanged: (state){},
            dropdownDialogRadius: 20,
            searchBarRadius: 20,
      ),

      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _addressController,
          labeltext: "Endereço",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),

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
                  Text('Tomateiro'),
                ],
              ),
      spacing(context, 5),
        genericButton(
          context,
          darkGreenBase,
          white_base,
          "Cadastrar propriedade",
          7,
          50,
          ()
        )
           
        
        
  ])));
    
  }
} 