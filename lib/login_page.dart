import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medi_flow/screen_background.dart';
import 'package:medi_flow/utils/assets_path.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String name = '/login';

  // Loading Time..
  Duration get loadingTime => const Duration(milliseconds: 2000);

  // Login
  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loadingTime).then((value) => null);
  }

  // Forgot Password
  Future<String?> _recoverPassword(String data) {
    return Future.delayed(loadingTime).then((value) => null);
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
          // Login form
          FlutterLogin(
            onLogin: _authUser,
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              pageColorLight: Colors.transparent,
              pageColorDark: Colors.transparent,
              cardTheme: CardTheme(
                color: Colors.pink.shade100,
                elevation: 10,
                shadowColor: Colors.pink.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              buttonTheme: LoginButtonTheme(
                splashColor: Colors.pinkAccent.shade100,
                backgroundColor: Colors.redAccent.shade400,
                highlightColor: Colors.pink.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
              inputTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18, // Adjust vertical padding to move text higher
                  horizontal: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always, // Keep label always visible
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.pink.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black45),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black45, width: 2),
                ),
                labelStyle: TextStyle(
                  fontSize: 16, // Increase or decrease font size
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
