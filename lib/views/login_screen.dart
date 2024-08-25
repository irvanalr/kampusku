import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Variabel untuk melacak nilai pada TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  /// Untuk menjadikan TextField tidak terlihat dan terlihat
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var user = await DBHelper().getUser(
                        _usernameController.text,
                        _passwordController.text,
                      );
                      if (user != null) {
                        Get.off(() => const DashboardScreen());
                      } else {
                        Get.snackbar(
                          'Perhatian',
                          'Username dan password anda salah !!!',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.blue,
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}