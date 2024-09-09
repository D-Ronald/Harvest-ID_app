// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/DatabaseManager/DatabaseManager.dart';
import 'package:debug_no_cell/pages/profile_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/Repositories/Culture_repository.dart';

class AuthException implements Exception {
  String message;
  String? propertyId;
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
          User? user = userCredential.user;
          await user!.updateDisplayName(name);
          Future<void> addUserDetailsToFirestore(
            String userId, String name,
            String email, String password, 
            String propertyId
            ) async {
            FirebaseFirestore firestore = FirebaseFirestore.instance;
            Map<String, dynamic> userData = {
              'name': name,
              'email': email,
              //'property_id': propertyId,
            };

            try {
              await firestore.collection("User").doc(userId).set(userData);
            } catch (error) {
              print(
                  "Erro ao adicionar detalhes do usuário ao Firestore: $error");
            }
          }

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

   resetPassword({required String email, required BuildContext context}) {
    try {
      _firebasseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

Future<void> cadasterProperty({
    required BuildContext context,
    required String propertyName,
    required String propertySize,
    required bool isChecked,
    required double? latitude,
    required double? longitude,
  }) async {
    if (propertyName.isEmpty || propertySize.isEmpty || !isChecked) {
      _exibirDialogoErro('Por favor, preencha todos os campos.', context);
      return;
    }

    if (double.tryParse(propertySize) == null) {
      _exibirDialogoErro("O tamanho da propriedade deve ser um número válido", context);
      return;
    }

    User? user = _firebasseAuth.currentUser;
    if (user == null) {
      _exibirDialogoErro("Usuário não autenticado.", context);
      return;
    }

    String uid = user.uid;
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      
      // Referência à coleção 'User'
      CollectionReference userCollection = firestore.collection("User");
      DocumentReference userDoc = userCollection.doc(uid);

      Map<String, dynamic> userData = {
        'name': user.displayName ?? "",
        'email': user.email ?? "",
      };

      await userDoc.set(userData);

      // Referência à subcoleção 'properties'
      CollectionReference propertiesCollection = userDoc.collection("properties");

      // Dados da propriedade
      Map<String, dynamic> propertyData = {
        'name': propertyName,
        'size': double.parse(propertySize),
        'latitude': latitude,
        'longitude': longitude,
        'ownerId': uid,
      };

      DocumentReference propertyDoc = await propertiesCollection.add(propertyData);
      String propertyId = propertyDoc.id; // ID da propriedade criada

      // Criação da subcoleção 'Culture'
      CollectionReference cultureCollection = propertyDoc.collection("Culture");
      Map<String, dynamic> cultureData = {
        'Identifier': 'Dados Inspecionados',
      };
      await cultureCollection.doc('Tomateiro').set(cultureData);

      // Criação da subcoleção 'Inspections' dentro da subcoleção 'Culture'
      CollectionReference inspectionsCollection = cultureCollection.doc('Tomateiro').collection("Inspections");
      Map<String, dynamic> inspectionData = {
        'Identifier': 'Inspeção 1',
      };
      await inspectionsCollection.doc('Inspection 1').set(inspectionData);

      _exibirDialogoCadastroSucesso(context);
    } catch (e) {
      _exibirDialogoErro("Erro ao cadastrar propriedade: ${e.toString()}", context);
    }
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
                navigateToAnotherPage(context);
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToAnotherPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()), // Ajuste a página conforme necessário
    );
  }

  void _handleAuthException(FirebaseAuthException e, BuildContext context) {
    switch (e.code) {
      case "channel-error":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Preencha todos os campos."),
          backgroundColor: Colors.redAccent,
        ));
        break;
      case "email-already-in-use":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("O email já foi cadastrado!"),
          backgroundColor: Colors.redAccent,
        ));
        break;
      case "invalid-email":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Email inválido!"),
          backgroundColor: Colors.redAccent,
        ));
        break;
      case "weak-password":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("A senha deve ter no mínimo 6 caracteres!"),
          backgroundColor: Colors.redAccent,
        ));
        break;
      case "network-request-failed":
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Sem conexão com a internet!"),
          backgroundColor: Colors.redAccent,
        ));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? "Erro desconhecido."),
          backgroundColor: Colors.redAccent,
        ));
        break;
    }
  }
}