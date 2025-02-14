import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InspectionListView extends StatelessWidget {
  final String userId;

  const InspectionListView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
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

        return ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 16),
          itemBuilder: (BuildContext context, int index) {
            DocumentSnapshot document = snapshot.data!.docs[index];

            Map<String, dynamic>? prediction =
                document['prediction'] as Map<String, dynamic>?;

            dynamic timestampRaw = document['timestamp'];
            String timestamp = timestampRaw is Timestamp
                ? "${timestampRaw.toDate().toLocal()}"
                    .split('.')
                    .first // Formata a data para exibir apenas até os segundos
                : (timestampRaw ?? 'N/A');

            return Card(
              elevation: 4,
              color: green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Classe: ${prediction?['class'] ?? 'Desconhecido'}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Confiança: ${prediction?['average_confidence']?.toStringAsFixed(2) ?? 'N/A'}%",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Ocorrências: ${prediction?['occurrences'] ?? 'N/A'}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 83, 83, 83),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Data: $timestamp",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 83, 83, 83),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
