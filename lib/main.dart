import 'package:debug_no_cell/pages/initial_page.dart';
import 'package:debug_no_cell/pages/login_page.dart';
import 'package:debug_no_cell/pages/register_page.dart';
import 'package:debug_no_cell/pages/view_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:debug_no_cell/pages/teste.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/": (context) => const InitialPage(),
        "/Login": (context) => LoginPage(),
        "/Register": (context) => RegisterPage(),
        "/View": (context) => const ViewPage(),
      },
      title: "Harvest-ID",
    );
  }
}
