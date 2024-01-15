// ignore_for_file: prefer_final_fields

import 'package:debug_no_cell/DatabaseManager/DatabaseManager.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/services/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  List userProfileList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUserList();
    if (resultant != null) {
      setState(() {
        userProfileList = resultant;
      });
    } else {
      print("Erro ao conectar no banco de dados");
    }
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              spacing(context, 4),
              imageButtonRowEnd(
                context: context,
                src: "assets/images/back.png",
                heightPercentage: 5,
                widthPercentage: 8,
                function: () {
                  switchInitialPage(context);
                },
                backgroundColor: whiteBase,
              ),
              spacing(context, 2),
              genericBigImage(
                context: context,
                src: "assets/images/NameGray.png",
                heightPercentage: 5,
                widthPercentage: 60,
              ),
              spacing(context, 4),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CADASTRO",
                    style: TextStyle(
                      color: darkGrayBase,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              spacing(context, 4),
              genericTextForm(
                context: context,
                controller: _nameController,
                keyboardType: TextInputType.name,
                labeltext: "Nome completo",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 20,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10.0,
              ),
              spacing(context, 2),
              genericTextForm(
                context: context,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                labeltext: "E-mail",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 20,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10.0,
              ),
              spacing(context, 2),
              genericTextForm(
                context: context,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                labeltext: "Senha",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 20,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10.0,
              ),
              spacing(context, 2),
              genericTextForm(
                context: context,
                controller: _passwordConfirmController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                labeltext: "Confirmar senha",
                labelColor: darkGrayBase,
                heightPercentage: 8,
                padding: 20,
                color: blackBase,
                backgroundColor: mediumGrayBase,
                borderRadius: 10.0,
              ),
              spacing(context, 2),
              genericButton(
                context,
                darkGreenBase,
                whiteBase,
                "Criar conta",
                7,
                50,
                () {
                   _autenthicationService.registerUser(
                    context: context,
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                    passwordConfirm: _passwordConfirmController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
