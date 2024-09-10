import 'package:debug_no_cell/pages/capture_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'cadaster_property_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadasterPropertyPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Column(
              children: [
                Image.asset(
                'assets/images/logo_harvest_2.png',
                width: width(context, 100),
                height: height(context, 50),
              )
              ]
            ),
            spacing(context, 0),
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadasterPropertyPage(),
                      ),
                    );
                  },
                  child: Ink(
                    width: 300,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF13383A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'CADASTRE SUA PROPRIEDADE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
              ],
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(right: 180.0),
              child: Text(
                'Inspecione sua cultura',
                style: TextStyle(
                  color: Color(0xFF13383A),
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 380,
                      height: 200,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(width: 10),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.filter_center_focus,
                                      color: Color.fromRGBO(19, 56, 58, 1),
                                      size: 30.0,
                                    ),
                                    Text(
                                      'Tire uma \n    foto',
                                      style: TextStyle(
                                        color: Color.fromRGBO(19, 56, 58, 1),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 25),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromRGBO(19, 56, 58, 1),
                                  size: 20.0,
                                ),
                                SizedBox(width: 25),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color: Color.fromRGBO(19, 56, 58, 1),
                                      size: 33.0,
                                    ),
                                    Text(
                                      'Diagnóstico',
                                      style: TextStyle(
                                        color: Color.fromRGBO(19, 56, 58, 1),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: 25),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromRGBO(19, 56, 58, 1),
                                  size: 20.0,
                                ),
                                SizedBox(width: 25),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.troubleshoot,
                                      color: Color.fromRGBO(19, 56, 58, 1),
                                      size: 36.0,
                                    ),
                                    Text(
                                      'Tratamento',
                                      style: TextStyle(
                                        color: Color.fromRGBO(19, 56, 58, 1),
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                                height:
                                    40), // Espaço adicional entre os ícones e o botão "Tirar uma foto"
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CapturePage()),
                                );
                              },
                              child: Container(
                                width: 240,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF13383A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Tirar uma foto',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
