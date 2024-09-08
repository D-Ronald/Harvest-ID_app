import 'dart:math';

import 'package:debug_no_cell/utils/base.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:debug_no_cell/utils/routes.dart';
import 'dart:convert';
import 'package:debug_no_cell/pages/generics_dialogs.dart';
import 'package:debug_no_cell/services/auth.dart';

class SendImage {
  final File? file;
  const SendImage({this.file});

  treatArchive(File? file) {
    if (file != null) {
      String archiveString = "$file";
      String aux = "";
      print(archiveString);
      for (int i = 0; i < archiveString.length - 1; i++) {
        if (i > 6) {
          String a = archiveString[i];
          aux += "" + a;
        }
      }
      archiveString = aux;
      return archiveString;
    }
  }

  string(String predict) {
    String aux = "";
    for (int i = 12; i < predict.length - 3; i++) {
      aux = aux + predict[i];
    }
    return aux;
  }

  Future<void> sendImage(context) async {
    var url = Uri.parse('hhttps://c8c4-34-125-133-108.ngrok-free.app/predict');
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', treatArchive(file),));
    request.files.add(await http.MultipartFile.fromPath(
        'id', AutenthicationService().user!.uid));
    var token;
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${token}'
    });
    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      responseString = string(responseString);
      print(responseString);
      if (responseString == "no plants") {
        Dialog.dialog(
          context: context,
          color: redBase,
          title: "Isso não se parece com uma colheita",
          message:
              "Não foi possível identificar nenhuma colheita na imagem.\n${responseString}",
        );
      } else if (responseString == "plants") {
        Dialog.dialog(
          context: context,
          color: darkGreenBase,
          title: "Análise bem sucedida",
          message:
              "Você pode verificar o resultado na aba de inspeções.\n${responseString}",
        );
      } else {
        Dialog.dialog(
          context: context,
          color: redBase,
          title: "Tente Novamente",
          message:
              "Ocorreu um erro inesperado. Tente novamente!${responseString}",
        );
      }
    } on ClientException catch (e) {
      if (e.message == "Connection reset by peer") {
        Dialog.dialog(
          color: redBase,
          context: context,
          title: "Falha na comunicação",
          message:
              "Estamos trabalhando para corrigir o problema.\n\nTente novamente mais tarde!",
        );
      }
    }
  }
}
