import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{
  final CollectionReference profileList = 
   FirebaseFirestore.instance.collection('user');

   Future<void> createUserData(String? name, String email, String password, String uid) async {
    return await profileList.doc(uid).set({
      "name": name,
      "email" : email,
      "password" : password,

    });
   }

Future<List<Map<String, dynamic>>?> getUserList() async {
  List<Map<String, dynamic>> itemsList = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('User').get();

    querySnapshot.docs.forEach((element) {
      itemsList.add(element.data() as Map<String, dynamic>);
    });

    return itemsList;
  } catch (e) {
    print(e.toString());
    return null;
  }
}


}