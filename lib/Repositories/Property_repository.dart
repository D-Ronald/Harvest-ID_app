// Import statements
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Class definition
class PropertyRepository extends StatefulWidget{
  const PropertyRepository({Key? key}) : super(key: key);
  
  @override
  _PropertyRepositoryState createState() => _PropertyRepositoryState();
}

class _PropertyRepositoryState extends State<PropertyRepository> {
  late String userId;
  late Widget PropertyList;
  
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
            .collection('User')
            .doc(userId)
            .collection('properties')
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
              child: Text('Nenhuma propriedade encontrada.'),
            );
          }
          PropertyList = Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.separated(
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                          "Propriedade: ${document['name']}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Text(
                          "Endereço: ${document['address']}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 151, 151, 151),
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
          return PropertyList;
        },
      ),
    );
  }
}
