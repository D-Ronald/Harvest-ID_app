import 'package:debug_no_cell/Repositories/Culture_repository.dart';
import 'package:debug_no_cell/pages/capture_page.dart';
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
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int culture) {
                return ListTile(
                  tileColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF13383A)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  title: Row(
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
                      const SizedBox(width: 220),
                      tabela[culture].icone, // Adiciona o ícone ao Row
                    ],
                  ),
                  onTap: () {
                    // lógica para executar ao tocar no ListTile
                    navigateToAnotherPage(context);
                  },
                );
              },
              padding: const EdgeInsets.all(15),
              separatorBuilder: (_, __) => const Divider(
                color: Colors.transparent,
              ),
              itemCount: tabela.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CapturePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'NOVA INSPEÇÃO',
                  style: TextStyle(
                    color: Colors.white, // Cor do texto
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
