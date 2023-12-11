import 'package:debug_no_cell/pages/profile_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../DatabaseManager/PropertyDatabaseManager.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AutenthicationService extends ChangeNotifier {
  FirebaseAuth _firebasseAuth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _firebasseAuth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user = _firebasseAuth.currentUser;
    notifyListeners();
  }

  /// Função para registrar um usuário com email e senha
  registerUser({
    required context,
    required String? name,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    if (password != passwordConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("As senhas não coincidem!"),
        backgroundColor: Colors.redAccent,
      ));
    } else if (name == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Preencha todos os campos!"),
        backgroundColor: Colors.redAccent,
      ));
    } else if (password == passwordConfirm && name != "") {
      try {
        UserCredential userCredential =
            await _firebasseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (userCredential != null) {
          userCredential.user!.updateDisplayName(name);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Usuário cadastrado com sucesso!"),
            backgroundColor: Color.fromARGB(255, 29, 222, 129),
          ));
          switchRegisterToLogin(context);
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == "channel-error") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Preencha todos os campos."),
            backgroundColor: Colors.redAccent,
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("O email já foi cadastrado!"),
            backgroundColor: Colors.redAccent,
          ));
        } else if (e.code == "invalid-email") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email inválido!"),
            backgroundColor: Colors.redAccent,
          ));
        } else if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("A senha deve ter no mínimo 6 caracteres!"),
            backgroundColor: Colors.redAccent,
          ));
        } else if (e.code == "network-request-failed") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Sem conexão com a internet!"),
            backgroundColor: Colors.redAccent,
          ));
        }
      }
    }
  }

  /// Função para fazer login usando email e senha
  login({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebasseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login efetuado com sucesso!"),
        backgroundColor: Color.fromARGB(255, 29, 222, 129),
      ));

      switch_view_page(context);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-credential") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email ou senha inválidos. Tente Novamente! "),
          backgroundColor: Colors.redAccent,
        ));
      } else if (e.code == "channel-error") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Preencha todos os campos."),
          backgroundColor: Colors.redAccent,
        ));
      } else if (e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email inválido!"),
          backgroundColor: Colors.redAccent,
        ));
      } else if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sem conexão com a internet!"),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }


  logout() async {
    await _firebasseAuth.signOut();
    _getUser();
  }

  resetPassword({required String email, context}) {
    try {
      _firebasseAuth.sendPasswordResetEmail(email: "email");
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e);
}
}
Future<void> cadasterProperty({
  required BuildContext context,
  required String propertyName,
  required String propertySize,
  required String address,
  required String? selectedCountry,
  required String? selectedState,
  required String? selectedCity,
  required bool isChecked,
}) async { 
  
  if (propertyName.isEmpty ||
      propertySize.isEmpty ||
      address.isEmpty ||
      selectedCountry == null ||
      selectedState == null ||
      selectedCity == null ||
      !isChecked) {
    _exibirDialogoErro('Por favor, preencha todos os campos.', context);
  } else {
    UserCredential property = await _firebasseAuth.createCadasterProperty(
      context: context,
      propertyName: propertyName,
      propertySize: propertySize,
      address: address,
      selectedCountry: selectedCountry,
      selectedState: selectedState,
      selectedCity: selectedCity,
      isChecked: isChecked,
    );
    await PropertyDatabaseManager().createPropertyData(propertyName, propertySize, address, selectedCountry, selectedState, selectedCity, isChecked);

    _exibirDialogoCadastroSucesso(context);
  }
}
void navigateToAnotherPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
);
}
void _exibirDialogoErro(String mensagem, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erro de validação'),
        content: Text(mensagem),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              
            },
          ),
        ],
      );
    },
  );
}

void _exibirDialogoCadastroSucesso(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cadastro Efetuado'),
        content: const Text('Sua propriedade foi cadastrada com sucesso!'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
                InkWell(
                onTap: () {
                  navigateToAnotherPage(context);
  });


              
            },
          ),
        ],
      );
    },
  );
}

}