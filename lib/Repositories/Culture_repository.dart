import 'package:debug_no_cell/Models/culture.dart';
import 'package:flutter/material.dart';

class CultureRepository {
  static List<culture> tabela = [
    culture(
      identificador: 'Inspeção 1',
      icone: const Icon(
        Icons.edit,
        color: Color.fromRGBO(19, 56, 58, 1),
        size: 25,
      ),
    ),
    culture(
      identificador: 'Inspeção 2',
      icone: const Icon(
        Icons.edit,
        color: Color.fromRGBO(19, 56, 58, 1),
        size: 25,
      ),
    ),
  ];
}
