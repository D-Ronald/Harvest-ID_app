import 'dart:convert';
import 'dart:html';

import 'package:debug_no_cell/Models/Cultura.dart';
import 'package:debug_no_cell/http/exceptions.dart';
import 'package:debug_no_cell/http/http_cultura.dart';

abstract class ACulturaRepository {
  Future<List<Cultura>> getDiagnostico();
}

class CulturaRepository implements ACulturaRepository {
  final IHttpCultura usuario;
  CulturaRepository({required this.usuario});

  @override
  Future<List<Cultura>> getDiagnostico() async {
    final analise = await usuario.get(url: 'https://162a-34-125-22-89.ngrok-free.app/predict');

    if (analise.statusCode == 200) {
      final List<Cultura> culturas = [];
      final body = jsonDecode(analise.body);

      body['JSON'].map((item) {
        final Cultura cultura = Cultura.fromMap(item);
        culturas.add(cultura);
      }).toList();

      return culturas;
    } else if (analise.statusCode == 404) {
      throw NotFounsException('A url não é válida');
    } else {
      throw Exception('Não foi possivel identificar os dados');
    }
  }
}


  // static List<Cultura> tabela = [Cultura(
  //   info: "informações e caracteristicas gerais da cultura",
  //    nome: "Tomateiro",
  //    icone: "images/tomate.jpg"
  //   ),
  // ];
