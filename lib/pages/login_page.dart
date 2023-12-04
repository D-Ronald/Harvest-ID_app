// ignore_for_file: prefer_final_fields

import 'package:debug_no_cell/pages/dialog_resend_password.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/services/auth.dart';

class LoginPage extends StatelessWidget {
  AutenthicationService _autenthicationService = AutenthicationService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
        spacing(context, 3),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(
                color: DarkGrayBase,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        spacing(context, 4),
        genericTextForm(
          context: context,
          controller: _emailController,
          labeltext: "E-mail",
          labelColor: DarkGrayBase,
          keyboardType: TextInputType.emailAddress,
          heightPercentage: 8,
          padding: 20, 
          color: blackBase,
          backgroundColor: mediumGrayBase,
          borderRadius: 20.0,
        ),
        spacing(context, 4),
        genericTextForm(
          context: context,
          controller: _passwordController,
          labeltext: "Senha",
          labelColor: DarkGrayBase,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          heightPercentage: 8,
          padding: 20,
          color: blackBase,
          backgroundColor: mediumGrayBase,
          borderRadius: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            genericTextButton(
                context: context,
                text: "Esqueceu sua senha?",
                textSize: 14.00,
                textColor: darkGreenBase,
                padding: 10.00,
                function: () {
                  DialogResendPassword().dialogResendPassword(context);
                })
          ],
        ),
        spacing(context, 4),
        genericButton(context, darkGreenBase, whiteBase, "Entrar", 7, 70, () {
          _autenthicationService.login(
              context: context,
              email: _emailController.text,
              password: _passwordController.text);
        }),
      ],
    )));
  }
}
