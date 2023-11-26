/*responsável pela autenticação de usuário*/
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AutenthicationService {
  FirebaseAuth _firebasseAuth = FirebaseAuth.instance;

  /// Função para registrar um usuário com email e senha
  registerUser( {
    required context,
    required String? name,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try{
      UserCredential userCredential = await _firebasseAuth
      .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if(userCredential != null){
      userCredential.user!.updateDisplayName(name);
      switchRegisterToLogin(context);
    }

    }on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("crie uma senha mais forte"),
            backgroundColor: Colors.redAccent,
          )
        );

      }else if(e.code == 'email-elready-in-use'){
      
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("O email já foi cadastrado!"),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
  }

  /// Função para fazer login usando email e senha
  login({
    required context,
    required String email,
    required String password,
  }) async
  {
    try{
      UserCredential userCredential = await _firebasseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,);

      switch_view_page(context);

    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário não encontrado."),
            backgroundColor: Colors.redAccent,
          )
        );
      }else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Senha incorreta."),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
    
  }
}

