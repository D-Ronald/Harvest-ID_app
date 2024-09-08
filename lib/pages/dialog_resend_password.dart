import 'package:debug_no_cell/services/auth.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';

class DialogResendPassword {
  DialogResendPassword();
  AutenthicationService _autenthicationService = new AutenthicationService();
  TextEditingController _emailController = TextEditingController();

  Future<void> dialogResendPassword(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Recuperar senha"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Text("Digite seu e-mail para recuperar sua senha"),
                  spacing(context, 2),
                  genericTextForm(
                    context: context,
                    controller: _emailController,
                    labeltext: "E-mail",
                    labelColor: darkGrayBase,
                    heightPercentage: 8,
                    padding: 5,
                    color: blackBase,
                    backgroundColor: lightGrayBase,
                    borderRadius: 10.0,
                  ),
                ],
              ),
            ),
            actions: [
              //genericButton
              genericButton(
                context,
                redBase,
                whiteBase,
                "Cancelar",
                4,
                8,
                () {
                  Navigator.of(context).pop();
                },
              ),
              genericButton(
                context,
                darkGreenBase,
                whiteBase,
                "Recuperar",
                4,
                8,
                () {
                  _autenthicationService.resetPassword(
                    context: context,
                    email: _emailController.text,
                  );
                },
              ),
            ],
          );
        });
  }
}