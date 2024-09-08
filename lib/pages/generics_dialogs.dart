import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';

class Dialog {
  Dialog();
  static void dialog({required BuildContext context, required String title, required String message, Color? color}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.black)),
          content: Text(message, style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            genericButton(
                context,
                color,
                whiteBase,
                "OK",
                4,
                8,
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
          ],
        );
      }
    );
  }
}