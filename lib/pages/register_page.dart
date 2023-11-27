import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/services/auth.dart';

class RegisterPage extends StatelessWidget {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        spacing(context, 4),
        imageButtonRowEnd(
          context: context,
          src: "assets/images/back.png",
          heightPercentage: 5,
          widthPercentage: 8,
          function: () {
            switch_initial_page(context);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CADASTRO",
              style: TextStyle(
                color: DarkGrayBase,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        spacing(context, 4),
        genericTextFormPassword(
          context: context,
          controller: _nameController,
          labeltext: "Nome completo",
          labelColor: DarkGrayBase,
          heightPercentage: 8,
          padding: 20,
          color: blackBase,
          backgroundColor: mediumGrayBase,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _emailController,
          labeltext: "E-mail",
          labelColor: DarkGrayBase,
          heightPercentage: 8,
          padding: 20,
          color: blackBase,
          backgroundColor: mediumGrayBase,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _passwordController,
          labeltext: "Senha",
          labelColor: DarkGrayBase,
          heightPercentage: 8,
          padding: 20,
          color: blackBase,
          backgroundColor: mediumGrayBase,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _passwordConfirmController,
          labeltext: "Confirmar senha",
          labelColor: DarkGrayBase,
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
                passwordConfirm: _passwordConfirmController.text);
          },
        ),
      ],
    )));
  }
}
