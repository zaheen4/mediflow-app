import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  // calls next screen
  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Navigator.of(context).pushReplacementNamed('/pages/login_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SvgPicture.asset(
            AssetsPath.backgroundSvg,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: double.maxFinite,
          ),
          // Logo
          Center(
            child: Image.asset(
              AssetsPath.logoPng,
              height: 250, // Adjust size as needed
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}