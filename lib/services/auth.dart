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

  void _exibirDialogoCadastroSucesso(BuildContext context, User? user) {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
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
    required String cep,
    required bool isChecked,
  }) async {
    if (propertyName.isEmpty ||
        propertySize.isEmpty ||
        cep.isEmpty ||
        !isChecked) {
      _exibirDialogoErro('Por favor, preencha todos os campos.', context);
      return;
    }

    if (int.tryParse(propertySize) == null) {
      _exibirDialogoErro(
          "O tamanho da propriedade deve ser um número inteiro", context);
      return;
    }

    if (cep.length != 8) {
      _exibirDialogoErro("CEP inválido.", context);
      return;
    }

    User? user = _firebasseAuth.currentUser;
    if (user == null) {
      _exibirDialogoErro("Usuário não autenticado.", context);
      return;
    }

    String uid = user.uid;
    try {
      if (user.displayName != null) {
        await user.updateDisplayName(user.displayName!);
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference userCollection = firestore.collection("User");
      DocumentReference userDoc = userCollection.doc(uid);

      Map<String, dynamic> userData = {
        'name': user.displayName ?? "",
        'email': user.email ?? "",
      };

      await userDoc.set(userData);

     CollectionReference propertiesCollection =
      userDoc.collection("properties");

      String propertyId = userDoc.id; // Obtendo o ID do documento do usuário

      Map<String, dynamic> propertyData = {
        'name': propertyName,
        'size': double.parse(propertySize),
        'cep': cep,
        'propertyId': propertyId, // Adicionando o ID da propriedade aqui
      };

      // Adicionando a propriedade
      DocumentReference propertyDoc = await propertiesCollection.add(propertyData);
      String propertyDocId = propertyDoc.id; // Obtendo o ID do documento da propriedade

      await propertyDoc.update({'propertyId': propertyDocId}); // Atualizando o ID da propriedade no documento da propriedade

      await userDoc.update({'propertyId': propertyDocId}); // Atualizando o ID da propriedade no documento do usuário

      


      // Criando subcoleção "Culture"
      CollectionReference subCollection = propertyDoc.collection("Culture");

      Map<String, dynamic> cultureData = {
        'Identifier': 'Dados Inspecionados',
      };

      DocumentReference cultureDoc = subCollection.doc('Tomateiro');
      await cultureDoc.set(cultureData);

      // Criando subcoleção "Inspections"
      CollectionReference inspectionsCollection =
          cultureDoc.collection("Inspections");

      Map<String, dynamic> inspectionData = {
        'Identifier': 'Inspeção 1',
      };

      await inspectionsCollection.doc('Inspection 1').set(inspectionData);

      _exibirDialogoCadastroSucesso(context, user);
    } catch (error) {
      print("Erro ao cadastrar propriedade: $error");
      _exibirDialogoErro("Erro ao cadastrar propriedade.", context);
    }
  }
}