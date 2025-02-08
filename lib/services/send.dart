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
import "dart:typed_data";
import "package:http/http.dart";
String? userId;

class SendImage {
  final File? file;
  const SendImage({this.file});

  // Função para enviar a imagem para a API
  Future<void> sendImage(context) async {
    if (file == null) {
      print('Nenhuma imagem selecionada');
      return;
    }

    // 1. Abra a imagem e converta para bytes
    Uint8List image_bytes = await file!.readAsBytes();

    // 2. Envie os bytes como corpo da requisição POST
    var url = Uri.parse('http://34.134.58.202/predict');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/octet-stream',  // Definir tipo de conteúdo como binário
      },
      body: image_bytes,  // Envia os bytes diretamente no corpo da requisição
    );

    // 3. Verifique a resposta da API
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var prediction = jsonResponse['prediction'];

      // Mostra o resultado na tela
      custom.Dialog.imageDialog(
        context: context,
        title: "Resultado da Detecção",
        imagePath: jsonResponse['image_url'], // URL da imagem retornada pela API
        text: prediction,
      );
    } else {
      custom.Dialog.dialog(
        context: context,
        color: Colors.red,
        title: "Erro ao enviar imagem",
        message: "Erro: ${response.body}",
      );
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

