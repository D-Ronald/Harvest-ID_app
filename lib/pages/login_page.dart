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
        spacing(context, 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
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
          controller: _emailController,
          labeltext: "E-mail",
          labelColor: dark_gray_base,
          heightPercentage: 8,
          padding: 20,
          color: black_base,
          backgroundColor: ligth_gray_base,
          borderRadius: 10.0,
        ),
        spacing(context, 4),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            genericTextButton(
                context: context,
                text: "Esqueceu sua senha?",
                textSize: 14.00,
                textColor: blue_base,
                padding: 10.00,
                function: () {})
          ],
        ),
        spacing(context, 4),
        genericButton(context, darkGreenBase, white_base, "Entrar", 7, 70, () {
          _autenthicationService.login(
              context: context,
              email: _emailController.text,
              password: _passwordController.text);
        }),
      ],
    )));
  }
}
