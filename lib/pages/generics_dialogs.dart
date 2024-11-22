import 'dart:io';
import 'dart:typed_data';

import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/message_format.dart';

class Dialog {
  Dialog();
  static void dialog(
      {required BuildContext context,
      required String title,
      required String message,
      Color? color}) {
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
        });
  }

  static void imageDialog({
  required BuildContext context,
  required String title,
  required String imagePath,
  required List<String> text,  // Lista de textos a serem exibidos
  Color? color,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Tamanho do conteúdo
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda
          children: [
            Image.network(
              imagePath,
              width: MediaQuery.of(context).size.width * 0.8, // Ajusta o tamanho da imagem
              height: MediaQuery.of(context).size.height * 0.4, // Ajusta a altura da imagem
              fit: BoxFit.cover, // Ajuste da imagem dentro do container
            ),
            SizedBox(height: 10), // Espaçamento entre a imagem e os textos
            // Exibindo todos os itens da lista `text`
            for (var item in text)
              Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
          ],
        ),
        actions: <Widget>[
          genericButton(
            context,
            color,
            const Color.fromARGB(255, 159, 13, 13),
            "OK",
            4,
            8,
            () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

}
