import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medi_flow/pages/login_page.dart';
import 'package:medi_flow/utils/splash_screen.dart';
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
      
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/pages/login_page' :(context) => LoginPage(),
        '/pages/home_page': (context) => HomePage(),

      },
      // onGenerateRoute: (RouteSettings settings) {
      //   late Widget page;
      //
      //   if (settings.name == SplashScreen.name) {
      //     page = const SplashScreen();
      //   } else if (settings.name == LoginPage.name) {
      //     page = const LoginPage();
      //   } else {
      //     page = const SplashScreen(); // Default
      //   }

        // return MaterialPageRoute(builder: (_) => page);
      // },


    );
  }
}