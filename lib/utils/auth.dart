import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AutenthicationService {
  FirebaseAuth _firebasseAuth = FirebaseAuth.instance;

  register_user({
    required String username,
    required String email,
    required password,
    required password_confirm,
  }) {
    _firebasseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
