import 'package:debug_no_cell/Repositories/Cultura_repository.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabela = CulturaRepository.tabela;

    return Scaffold(
      body: Image.asset("assets/images/NameGray.png",
        width: 113,
        height: 14,
        ),
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
        shadowColor: const Color.fromRGBO(19, 56, 60, 38),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      // body: ListView.separated(
      //     itemBuilder: (BuildContext context, int cultura) {
      //       return ListTile(
      //         leading: Image.asset(tabela[cultura].icone),
      //         title: Text(tabela[cultura].nome, style: const TextStyle(
      //           fontSize: 17,
      //           fontWeight: FontWeight.w500,
      //           color: Colors.indigo,
      //         ),),
      //       );
      //     },
      //     padding: const EdgeInsets.all(16),
      //     separatorBuilder: (_, __) => const Divider(),
      //     itemCount: tabela.length
      //   ),
    );
  }
}
