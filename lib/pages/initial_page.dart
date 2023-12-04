import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import "package:debug_no_cell/utils/routes.dart";

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          height: height(context, 100),
          width: height(context, 100),
          decoration: const BoxDecoration(color: darkGreenBase),
          child: Column(
            children: [
              spacing(context, 20),
              Container(
                height: height(context, 30),
                width: height(context, 40),
                child: new Image.asset(
                  "assets/images/harvest.png",
                ),
              ),
              spacing(context, 10),
              genericIconButton(
                  context: context,
                  backgroundColor: mediumGrayBase,
                  textColor: blackBase,
                  text: "Acessar sua conta",
                  icon: const Icon(Icons.login, color: blackBase),
                  percentageHeight: 7,
                  percentageWidth: 70,
                  function: () {
                    switch_login_page(context);
                  }),
              spacing(context, 5),
              genericIconButton(
                  context: context,
                  backgroundColor: mediumGrayBase,
                  textColor: blackBase,
                  text: "Criar uma conta",
                  icon: const Icon(Icons.people, color: blackBase),
                  percentageHeight: 7,
                  percentageWidth: 70,
                  function: () {
                    switch_register_page(context);
                  }),
              spacing(context, 10),
              genericTextButton(
                  context: context,
                  text: "Acesse nossa central de ajuda.",
                  textSize: 16.00,
                  textColor: whiteBase,
                  padding: 20.00,
                  function: () {})
            ],
          )),
    );
  }
}
