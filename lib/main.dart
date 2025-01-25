import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medi_flow/pages/login_page.dart';
import 'pages/home_page.dart';



void main() async {
  // for firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/pages/home_page': (context) => HomePage(),
      },
    );
  }
}