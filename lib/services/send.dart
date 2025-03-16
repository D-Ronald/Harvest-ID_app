import 'package:debug_no_cell/pages/generics_dialogs.dart' as custom;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:debug_no_cell/services/auth.dart';
import "dart:typed_data";
import "package:debug_no_cell/utils/base.dart" as base;
import 'package:image/image.dart' as img;

class SendImage {
  final File? file;
  const SendImage({this.file});

  Future<String?> obterJwt(String firebaseToken) async {
  final url = Uri.parse("http://34.134.226.132/token?token_cusum=$firebaseToken");

  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},

    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse["access_token"];
    } else {
      print("Erro ao obter JWT: ${response.statusCode} - ${response.body}");
      return null;
    }
  } catch (e) {
    print("Erro na requisição: $e");
    return null;
  }
}

  Future<void> uploadImage(BuildContext context) async {
  String? firebaseToken = await AutenthicationService().firebasseAuth.currentUser?.getIdToken(true);

if (firebaseToken == null) {
  print("Erro: Token Firebase é nulo. O usuário está autenticado?");
  return;
}

String? tokenApi = await obterJwt(firebaseToken);

if (tokenApi == null) {
  print("Erro: Falha ao obter o token JWT.");
  return;
}

  
    Uint8List imageBytes = await file!.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);
    img.Image resizedImage = img.copyResize(image!, width: 640, height: 384);
    Uint8List resizedImageBytes = Uint8List.fromList(img.encodeJpg(resizedImage));
 
  
  var url = Uri.parse("http://34.134.226.132/predict");
  
  var headers = {"Authorization": "Bearer $tokenApi"};
  
  try {
    // Send the request and get the response
    var response =  await http.post(url, headers: headers, body: imageBytes);
    var statusCode = response.statusCode;
    var responseString = response.body;
    print(response.body);
    print(statusCode);
    print(firebaseToken);
    var responseJson = jsonDecode(responseString);
    if (statusCode == 200) {
      var responsePrediction = responseJson['prediction']['main_prediction']['class'];
      custom.Dialog.dialog(
        context: context,
         title: "Resultado da inspeção",
          message: "$responsePrediction \n\n Vá até o dashboard para ver mais detalhes!",
          color: base.darkGreenBase
          );
    }else if(statusCode == 500) {
      custom.Dialog.dialog(context: context,
       title: "Isso não é uma planta",
       message: "O objeto da imagem não se parece com uma planta, tente novamente!",
       color: base.darkGreenBase
       );
    }else if(statusCode == 502){
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
       
    }
  }catch (e) {
    print("Error uploading image: $e");
    
  }
}

  Future<void> firebaseLogin(String tokenFirebase) async {
  // Adiciona o token como parâmetro na URL
  var url = Uri.parse("http://34.134.226.132/firebase_login?token_firebase=$tokenFirebase");

  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    print("Sucesso: ${response.body}");
  } else {
    print("Erro ${response.statusCode}: ${response.body}");
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


  