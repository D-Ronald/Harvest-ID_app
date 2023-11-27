import 'package:debug_no_cell/Repositories/Cultura_repository.dart';
import 'package:debug_no_cell/pages/dashboard_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabela = CulturaRepository.tabela;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/NameGray.png",
                width: 199,
                height: 27,
              ),
              //linha saparadora
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Transform.rotate(
                  angle: -3.14,
                  child: Container(
                    width: 354,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              

              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 129,
                      height: 48,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [
                            Color(0xFFD9D9D9),
                            Color(0x8FD9D9D9),
                            Color(0x00D9D9D9)
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: const Center(
                        child: Text(
                          'CULTURAS',
                          style: TextStyle(
                            color: Color(0xFF13383A),
                            fontSize: 14,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              //imagem da cultura
              const SizedBox(height: 50),
              Center(
                child: Container(
                  width: 243,
                  height: 167,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Image.asset('assets/images/tomate.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 60),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 145,
                        height: 26,
                        child: Text(
                          'TOMATE',
                          style: TextStyle(
                            color: Color(0xFF13383A),
                            fontSize: 18,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Text(
                      'Solanum Lycopersicum',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w100,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  navigateToAnotherPage(context);
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  
                    //SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 69,
                            height: 24,
                            child: Text(
                              'Ver mais',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'Cardo',
                                fontWeight: FontWeight.w400,
                                height: 0,
                               ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
        ),
        
      ),
      

      appBar: AppBar(
        title: const Text(
          'CULTURAS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
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
    );
  }
}
