import 'dart:math';
import 'package:debug_no_cell/pages/generics_dialogs.dart' as custom;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:debug_no_cell/utils/routes.dart';
import 'dart:convert';
import 'package:debug_no_cell/pages/generics_dialogs.dart';
import 'package:debug_no_cell/services/auth.dart';
import "package:firebase_storage/firebase_storage.dart";
import 'package:firebase_auth/firebase_auth.dart';

String? userId;

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

  Future<void> downloadAndSaveImage(String firebasePath) async {
    var fileName = 'image.jpg';
    try {
      // 1. Obtenha o URL da imagem no Firebase Storage
      final ref = FirebaseStorage.instance.ref(firebasePath);
      final imageUrl = await ref.getDownloadURL();

      // 2. Faça o download da imagem usando o pacote http
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // 3. Obtenha o diretório local onde o arquivo será salvo
        final directory = 'assets/images';

        // 4. Crie o arquivo no diretório local
        final file = File('${directory}/$fileName');

        // 5. Salve os bytes da imagem no arquivo
        await file.writeAsBytes(response.bodyBytes);

        print('Imagem salva em: ${file.path}');
      } else {
        print('Erro ao fazer o download da imagem: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> sendImage(context) async {
    var url = Uri.parse('https://66f4-35-245-146-92.ngrok-free.app/predict');
    var request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('image', treatArchive(file)));
    var token;
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${token}'
    });

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      print(responseString);
      if (response.statusCode == 200) {
        var json = jsonDecode(responseString);
        var imageUrl = json['image_url'];
        List<String> prediction = (json['predictions'] as List)
          .map((prediction) => prediction['class'] as String).toList();
        downloadAndSaveImage(imageUrl);
        var image = '';
        custom.Dialog.imageDialog(
            context: context, title: "Resultado", imagePath: imageUrl, text: prediction);
      } else if (responseString == "plants") {
        custom.Dialog.dialog(
          context: context,
          color: darkGreenBase,
          title: "Análise bem sucedida",
          message:
              "Você pode verificar o resultado na aba de inspeções.\n${responseString}",
        );
      } else {
        custom.Dialog.dialog(
          context: context,
          color: redBase,
          title: "Tente Novamente",
          message:
              "Ocorreu um erro inesperado. Tente novamente!${responseString}",
        );
      }
    } on ClientException catch (e) {
      if (e.message == "Connection reset by peer") {
        custom.Dialog.dialog(
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

Future<Map<String, dynamic>> fetchAndDisplayApiData() async {
  // Buscando a URL no Firestore
  final snapshot = await FirebaseFirestore.instance.collection('ngrok').get();

  if (snapshot.docs.isEmpty) {
    throw Exception('Nenhuma URL encontrada na coleção "ngrok".');
  }

  // Pega a URL do Firestore
  final apiUrl = snapshot.docs.first['url'];

  // Fazendo a requisição HTTP
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // Se a resposta for bem-sucedida, decodifica os dados JSON e retorna como Map
    return json.decode(response.body) as Map<String, dynamic>;
  } else {
    // Caso contrário, lança uma exceção
    throw Exception('Erro ao carregar dados da API.');
  }
}

// Para resgatar ID de usuário:
void fetchUserId() {
  userId = FirebaseAuth.instance.currentUser?.uid;
}

