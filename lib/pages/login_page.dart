import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medi_flow/utils/assets_path.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String name = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Loading Time..
  Duration get loadingTime => const Duration(milliseconds: 2000);

  Future<String?> _authUser(LoginData data) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // Return null if login is successful
    } catch (e) {
      return e.toString(); // Return the error message to display on the UI
    }
  }

  Future<String?> _recoverPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; // Return null if password reset is successful
    } catch (e) {
      return e.toString(); // Return the error message to display on the UI
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.name!, // `name` is nullable, add `!` to handle non-null
        password: data.password!,
      );
      return null; // Return null if signup is successful
    } catch (e) {
      return e.toString(); // Return the error message to display on the UI
    }
  }

// google sign in methods
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String?> _googleLogin(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the Google Sign-In
        return "Google Sign-In was canceled";
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushReplacementNamed('/pages/home_page');

      return null; // Login success
    } catch (e) {
      return e.toString(); // Return error message if Google Sign-In fails
    }
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
            onLogin: (loginData) async {
              final error = await _authUser(loginData);
              if (error == null) {
                // Navigate to HomePage
                Navigator.of(context).pushReplacementNamed('/pages/home_page');
              }
              return error;
            },
            onRecoverPassword: _recoverPassword,
            //onSignup: _signupUser,
            onSignup: (signupData) async {
              final error = await _signupUser(signupData);
              if (error == null) {
                // Navigate to HomePage
                Navigator.of(context).pushReplacementNamed('/pages/home_page');
              }
              return error;
            },
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacementNamed('/pages/home_page');
            },
            theme: LoginTheme(
              switchAuthTextColor: Colors.redAccent.shade400,
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
                floatingLabelBehavior:
                    FloatingLabelBehavior.always, // Keep label always visible
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

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final error = await _googleLogin(context);
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                  }
                },
                icon: SvgPicture.asset(
                  'assets/icons/google_icon.svg', // Your Google icon location
                  height: 24,
                  width: 24,
                ),
                label: const Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
