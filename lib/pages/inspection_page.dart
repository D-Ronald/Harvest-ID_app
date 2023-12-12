import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InspectionPage extends StatefulWidget {
  const InspectionPage({Key? key}) : super(key: key);

  @override
  _InspectionPageState createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'INSPERÇÃO 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 20, 1),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Propriedade: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cultura:  ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hectares: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      Text(
                        'Data da inspeção: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Center(
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
                  ),

                  // Adicionando o gráfico de pizza com duas seções
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Índice geral de saúde',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          color: Colors.transparent,
                          child: PieChart(
                            PieChartData(
                                centerSpaceRadius: 80,
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 2,
                                sections: [
                                  PieChartSectionData(
                                    value: 50,
                                    color: const Color.fromARGB(19, 56, 58, 1),
                                    radius: 40,
                                  ),
                                  PieChartSectionData(
                                    value: 50,
                                    color: const Color.fromARGB(
                                        255, 110, 170, 121),
                                    radius: 40,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
