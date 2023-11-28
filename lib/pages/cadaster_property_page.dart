import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/services/auth.dart';

class CadasterProperty_page extends StatelessWidget {
  TextEditingController _CityController = TextEditingController();
  TextEditingController _StateController = TextEditingController();
  TextEditingController _CountryController = TextEditingController();
  TextEditingController _PropertyNameController = TextEditingController();
  TextEditingController _PropertySizeController = TextEditingController();

  late FirebaseFirestore db;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      genericBigImage(
          context: context,
          src: "assets/images/NameGray.png",
          heightPercentage: 15,
          widthPercentage: 50),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _CountryController,
          labeltext: "País",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _StateController,
          labeltext: "Estado",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _CityController,
          labeltext: "Cidade",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 3),
      genericTextFormPassword(
          context: context,
          controller: _PropertyNameController,
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
          controller: _PropertySizeController,
          labeltext: "Tamanho da propriedade em hectares",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 20),
      spacing(context, 5),
      genericButton(context, darkGreenBase, white_base, "SALVAR", 8, 40, () {}),
    ])));
  }
}
