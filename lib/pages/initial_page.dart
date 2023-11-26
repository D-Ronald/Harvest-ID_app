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
          decoration: BoxDecoration(color: darkGreenBase),
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
                  backgroundColor: ligth_gray_base,
                  textColor: black_base,
                  text: "Acessar sua conta",
                  icon: Icon(Icons.login, color: black_base),
                  percentageHeight: 7,
                  percentageWidth: 70, 
                  function: () {
                   switch_login_page(context);
              }),
              spacing(context, 5),
              genericIconButton(
                  context: context,
                  backgroundColor: ligth_gray_base,
                  textColor: black_base,
                  text: "Criar uma conta",
                  icon: Icon(Icons.people, color: black_base),
                  percentageHeight: 7,
                  percentageWidth: 70,
                  function:  () {
                  switch_register_page(context);
                  }
              ),
              spacing(context, 10),
              genericTextButton(
                  context: context,
                  text: "Acesse nossa central de ajuda.",
                  textSize: 16.00,
                  textColor: blue_base,
                  padding: 20.00,
                  function: () {})
            ],
          )),
    );
  }
}
