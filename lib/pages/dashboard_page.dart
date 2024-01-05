import 'package:debug_no_cell/Repositories/Culture_repository.dart';
import 'package:debug_no_cell/pages/inspection_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InspectionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabela = CultureRepository.tabela;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'DADOS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Inspecionados',
                style: TextStyle(
                  color: Color(0xFFD9D9D9),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ],
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
      body: ListView.separated(
        itemBuilder: (BuildContext context, int culture) {
          return Container(
            width: 350,
            height: 60,
            decoration: ShapeDecoration(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFF13383A)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tabela[culture].identificador,
                    style: const TextStyle(
                      color: Color(0xFF13383A),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                      width: 220), // Espaçamento entre o texto e o ícone
                  tabela[culture].icone, // Adiciona o ícone ao Row
                ],
              ),
            ),
          );
        },
        padding: const EdgeInsets.all(15),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
    );
  }
}
