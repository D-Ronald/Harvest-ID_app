import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDocsFirebase extends StatelessWidget {
  final String documentId;

  GetDocsFirebase({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // Get the collection
    CollectionReference properties =
        FirebaseFirestore.instance.collection('User');

    return FutureBuilder<DocumentSnapshot>(
      future: properties.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Propriedade: ${data['name']}");
        }
        return Text("No data available");
      },
    );
  }
}
