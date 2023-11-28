import 'package:debug_no_cell/Models/Cultura.dart';
import 'package:flutter/material.dart';

class CulturaProperties {

  final ValueNotifier<bool> isLoarding = ValueNotifier<bool>(false);

  final ValueNotifier<List<Cultura>> state = ValueNotifier<List<Cultura>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  getCulturas() async {
    isLoarding.value = true;

    try {} catch (e) {}
  }
}
