import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CultureRepository extends StatelessWidget {
  final String uid;

  CultureRepository({required this.uid});

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection = FirebaseFirestore.instance.collection("User");
    DocumentReference userDoc = userCollection.doc(uid);
    CollectionReference inspectionsCollection = userDoc.collection("inspection");

    return Scaffold(
      appBar: AppBar(title: Text("Inspections")),
      body: StreamBuilder(
        stream: inspectionsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Nenhuma inspeção encontrada."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              Map<String, dynamic> prediction = document["prediction"] ?? {};
              
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text("ID: ${document.id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Confiança Média: ${prediction["average_confidence"] ?? "N/A"}"),
                      Text("Classe: ${prediction["class"] ?? "N/A"}"),
                      Text("Ocorrências: ${prediction["occurrences"] ?? "N/A"}"),
                      Text("Data: ${prediction["timestamp"] ?? "N/A"}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
