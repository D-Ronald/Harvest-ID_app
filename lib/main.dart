import 'package:debug_no_cell/pages/initial_page.dart';
import 'package:debug_no_cell/pages/login_page.dart';
import 'package:debug_no_cell/pages/register_page.dart';
import 'package:debug_no_cell/pages/view_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",  
      routes: {
        "/": (context) => InitialPage(),
        "/Login":(context) => LoginPage(),
        "/Register":(context) => RegisterPage(),
        "/View" : (context) => ViewPage(),
      },
      title: "Harvest-ID",
    );
  }
}
