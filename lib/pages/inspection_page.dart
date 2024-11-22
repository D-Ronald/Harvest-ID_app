import 'dart:convert';
import 'package:debug_no_cell/services/send.dart';
import 'package:http/http.dart' as http;
import 'package:debug_no_cell/pages/ReadData/get_docs_firebase.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
                // Change the color here
              ),
              onPressed: () {
                // Navegar para a página GetDocsFirebase
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GetDocsFirebase(),
                  ),
                );
              })
        ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
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
                                      color: Color.fromARGB(255, 71, 71, 71),
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
                                          width: 1, color: Color(0xFFC7592A)),
                                    ),
                                  ),
                                  child: FutureBuilder<Map<String, dynamic>>(
                                    future:
                                        fetchAndDisplayApiData(), // Chamada para buscar dados
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                            'Erro: ${snapshot.error}',
                                            style: const TextStyle(
                                                color: Colors.red),
                                          ),
                                        );
                                      }

                                      // Dados carregados com sucesso
                                      final apiData = snapshot.data!;

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          children:
                                              apiData.entries.map((entry) {
                                            return Text(
                                              '${entry.key}: ${entry.value}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
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
          ),
        ),
      ),
    );
  }
}
