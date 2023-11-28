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
          backgroundColor: white_base,
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
                color: dark_gray_base,
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
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _emailController,
          labeltext: "E-mail",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _passwordController,
          labeltext: "Senha",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericTextFormPassword(
          context: context,
          controller: _passwordConfirmController,
          labeltext: "Confirmar senha",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10.0,
        ),
        spacing(context, 2),
        genericButton(
          context,
          darkGreenBase,
          white_base,
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
