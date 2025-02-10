import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_flow/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  String _username = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
        _email = user.email ?? "No email available";
        _username = _email.split('@')[0]; // Extract everything before '@'
      });
    }
  }

  Future<void> _showEditProfileDialog() async {
    final TextEditingController emailController =
        TextEditingController(text: _email);
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController currentPasswordController =
        TextEditingController(); // Added field for reauthentication

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "New Email"),
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: "New Password"),
                obscureText: true,
              ),
              TextField(
                controller: currentPasswordController,
                decoration:
                    const InputDecoration(labelText: "Current Password"),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (currentPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter your current password."),
                    ),
                  );
                  return;
                }
                await _updateUserProfile(
                  emailController.text,
                  newPasswordController.text,
                  currentPasswordController.text, // Pass current password
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserProfile(
      String newEmail, String newPassword, String currentPassword) async {
    try {
      if (_user == null) return;

      // Get user email
      String? email = _user!.email;
      if (email == null) {
        throw FirebaseAuthException(
            code: "no-email", message: "No email associated with this account");
      }

      // Reauthenticate with current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await _user!.reauthenticateWithCredential(credential);

      // Update email if it is different
      if (newEmail.isNotEmpty && newEmail != _email) {
        await _user!.verifyBeforeUpdateEmail(newEmail);
        setState(() {
          _email = newEmail;
          _username = newEmail.split('@')[0]; // Update username
        });
      }

      // Update password if provided
      if (newPassword.isNotEmpty) {
        await _user!.updatePassword(newPassword);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/icons/profile_icon.png'),
            ),
            const SizedBox(height: 20),
            Text(
              "Name: $_username",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Email: $_email",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showEditProfileDialog,
              child: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
