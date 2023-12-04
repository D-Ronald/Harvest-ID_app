import 'package:debug_no_cell/pages/capture_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'cadaster_property_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadasterProperty_page()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 400, // Altura do container 'cadastre sua propriedade'
          flexibleSpace: Column(
            children: [
              Container(
                width: 500,
                height: 410,
                decoration: const ShapeDecoration(
                  color: Color(0xFF13383A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(150),
                    ),
                  ),
                ),
                child: Image.asset(
                  'assets/images/harvest.png',
                  width: 268,
                  height: 198,
                  // fit: BoxFit.fill,
                ),
              ),
              // Adicionar a captura de imagem
              
            ],
          ),
        ),
        body: Column(
          children: [
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
                        builder: (context) => CadasterProperty_page(),
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
          ],
        ),
        
      ),
      
    );
  }
}
