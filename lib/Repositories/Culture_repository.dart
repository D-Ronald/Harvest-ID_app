import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InspectionRepository extends StatefulWidget {
  const InspectionRepository({Key? key}) : super(key: key);

  @override
  _InspectionRepositoryState createState() => _InspectionRepositoryState();
}

class _InspectionRepositoryState extends State<InspectionRepository> {
  late String userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('inspection')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ocorreu um erro ao carregar os dados.'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Nenhuma inspeção encontrada.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> prediction = document['prediction'] ?? {};
                String timestamp = document['timestamp'] ?? 'N/A';

                return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Classe: ${prediction['class'] ?? 'Desconhecido'}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Confiança: ${prediction['average_confidence']?.toStringAsFixed(2) ?? 'N/A'}%",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Ocorrências: ${prediction['occurrences'] ?? 'N/A'}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 151, 151, 151),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Data: $timestamp",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 151, 151, 151),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}