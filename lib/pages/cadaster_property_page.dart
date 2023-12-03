// ignore_for_file: camel_case_types, non_constant_identifier_names
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

class CadasterProperty_page extends StatelessWidget {
  final TextEditingController _CityController = TextEditingController();
  final TextEditingController _StateController = TextEditingController();
  final TextEditingController _CountryController = TextEditingController();
  final TextEditingController _PropertyNameController = TextEditingController();
  final TextEditingController _PropertySizeController = TextEditingController();

  CadasterProperty_page({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Column(
            children: [
              Text(
                'Cadastre a Propriedade',
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
          body: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/NameGray.png',
                  width: 199,
                  height: 27,
                  ),
                const SizedBox(
                  height: 20,
                ),
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

                  spacing(context, 3),
                  genericTextForm(
                    context: context,
                    controller: _CountryController,
                    labeltext: "País",
                    labelColor: DarkGrayBase,
                    heightPercentage: 8,
                    padding: 20,
                    color: DarkGrayBase,
                    backgroundColor: mediumGrayBase,
                    borderRadius: 20),
                  spacing(context, 3),
                  genericTextForm(
                    context: context,
                    controller: _StateController,
                    labeltext: "Estado",
                    labelColor: DarkGrayBase,
                    heightPercentage: 8,
                    padding: 20,
                    color: blackBase,
                    backgroundColor: mediumGrayBase,
                    borderRadius: 20),
                  spacing(context, 3),        
                  genericTextForm(
                    context: context,
                    controller: _CityController,
                    labeltext: "Cidade",
                    labelColor: DarkGrayBase,
                    heightPercentage: 8,
                    padding: 20,
                    color: blackBase,
                    backgroundColor: mediumGrayBase,
                    borderRadius: 20),
                  spacing(context, 3),
                  genericTextForm(
                    context: context,
                    controller: _PropertyNameController,
                    labeltext: "Nome da propriedade",
                    labelColor: DarkGrayBase,
                    heightPercentage: 8,
                    padding: 20,
                    color: blackBase,
                    backgroundColor: mediumGrayBase,
                    borderRadius: 20),
                  spacing(context, 3),
                  genericTextForm(
                    context: context,
                    controller: _PropertySizeController,
                    labeltext: "Tamanho da propriedade em hectares",
                    labelColor: DarkGrayBase,
                    heightPercentage: 8,
                    padding: 20,
                    color: blackBase,
                    backgroundColor: mediumGrayBase,
                    borderRadius: 20),
                  spacing(context, 5),
                  ElevatedButton(onPressed: (){
                    CollectionReference collRef = FirebaseFirestore.instance.collection('propertys');
                    collRef.add({
                      'name': _PropertyNameController.text,
                      'size' : int.parse(_PropertySizeController.text),
                      'country' :_CountryController.text,
                      'state': _StateController.text,
                      'city': _CityController.text,
            
                    });
                  },
                   child: const Text('SALVAR'))
                ],
                ),
                ),
          ),
    );
  }
}