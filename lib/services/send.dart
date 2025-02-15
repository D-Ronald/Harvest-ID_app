import 'dart:ffi';
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
import "package:debug_no_cell/utils/base.dart" as base;
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
String? user_id;
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
      custom.Dialog.dialog(
        context: context,
        title: "Resultado da Detecção",// URL da imagem retornada pela API
        message: prediction.toString(),
        color: base.darkGreenBase
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

  Future<void> uploadImage(BuildContext context) async {
  String? user_id = fetchUserId();  // Ensure you have a method to fetch the user ID
  
  if (user_id == null) {
    // Handle the case where user_id is not available
    print("User ID is missing!");
    return;
  }

  // Read the image file as bytes
  Uint8List imageBytes = await file!.readAsBytes();
  img.Image? image = img.decodeImage(imageBytes);
  img.Image resizedImage = img.copyResize(image!, width: 640, height: 384);
  Uint8List resizedImageBytes = Uint8List.fromList(img.encodeJpg(resizedImage));
  
  // Define the URL for the API endpoint
  var url = Uri.parse("http://34.134.58.202/upload/");
  
  // Create the multipart request
  var request = http.MultipartRequest('POST', url)
    ..headers['userId'] = user_id // Set the userId in the headers
    ..files.add(http.MultipartFile.fromBytes(
      'file', resizedImageBytes,
      filename: 'image.jpg',  // Set the filename to something appropriate
      contentType: MediaType('image', 'jpeg'),  // You can adjust based on the image type
    ));
  
  try {
    // Send the request and get the response
    var response =  await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseString);
      var responsePrediction = responseJson['prediction']['class'];
      custom.Dialog.dialog(
        context: context,
         title: "Resultado da inspeção",
          message: responsePrediction,
          color: base.darkGreenBase
          );
    }else if(response.statusCode == 500) {
      custom.Dialog.dialog(context: context,
       title: "Isso não é uma planta",
       message: "O objeto da imagem não se parece com uma planta, tente novamente!",
       color: base.darkGreenBase
       );
    }else if(response.statusCode == 502){
      custom.Dialog.dialog(context: context,
       title: "Falha na comunicação com o servidor",
       message: "Houve um problema em nossos serviços, estamos trabalhando para corrigi-lo. tente novamente mais tarde!",
       color: base.darkGreenBase
       );
    }else{
      custom.Dialog.dialog(context: context,
       title: "Falha",
       message: "Houve falha no processamento da imagem, tente novamente!",
       color: base.darkGreenBase
       );
       print(response.statusCode);
    }
  } catch (e) {
    print("Error uploading image: $e");
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
String? fetchUserId() {
  return user_id = FirebaseAuth.instance.currentUser?.uid;
}


  