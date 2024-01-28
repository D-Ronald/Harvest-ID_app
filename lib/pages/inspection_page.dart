import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class InspectionPage extends StatelessWidget {
  const InspectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _InspectionPageContent();
  }
}

class _InspectionPageContent extends StatefulWidget {
  @override
  _InspectionPageContentState createState() => _InspectionPageContentState();
}

class _InspectionPageContentState extends State<_InspectionPageContent> {
  bool isHealthy = true;
   

  //Document IDs
  List<String> docIDs = [];

  //get docIDs
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('properties').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            print(element.reference);
            docIDs.add(element.reference.id);
          }),
        );
  }

  @override
  void initState(){
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'INSPEÇÃO 1',
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
      body: GestureDetector(
        onTap: () {
          setState(() {
            isHealthy = !isHealthy;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 20, 1),
          child: SingleChildScrollView(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('properties')
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erro ao carregar dados");
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Carregando...");
                        }

                        if (snapshot.data == null) {
                          return const Text("Nenhuma propriedade encontrada");
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic> data =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return Column(
                              children: [
                                Text(
                                  'Propriedade: ${data['name']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Hectares: ${data['size']}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Cultura: Tomateiro',
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
                            width: 250,
                            height: 250,
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                PieChart(
                                  PieChartData(
                                    centerSpaceRadius: 70,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 2,
                                    sections: [
                                      PieChartSectionData(
                                        color: isHealthy
                                            ? const Color.fromARGB(
                                                255, 110, 170, 121)
                                            : const Color.fromARGB(
                                                255, 203, 92, 84),
                                        radius: 30,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        isHealthy ? 'SAUDÁVEL' : 'DOENTE',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const Text(
                                        '100%',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 71, 71),
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Center(
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        right: 185.0,
                                        bottom: 20,
                                      ),
                                      child: Text(
                                        'Análise de risco',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 299,
                                      height: 120,
                                      decoration: const ShapeDecoration(
                                        color: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFC7592A)),
                                        ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
