import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/db_helper.dart';
import 'dashboard_screen.dart';

/// Layar login yang memungkinkan pengguna memasukkan nama pengguna dan kata sandi
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Variabel untuk melacak nilai pada TextField nama pengguna
  final TextEditingController _usernameController = TextEditingController();
  /// Variabel untuk melacak nilai pada TextField kata sandi
  final TextEditingController _passwordController = TextEditingController();
  /// Boolean untuk mengatur apakah kata sandi ditampilkan atau tidak
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Menghilangkan fokus dari TextField ketika mengetuk di luar
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        /// AppBar yang menampilkan judul layar login
          appBar: AppBar(
            title: const Text(
              'Login', /// Judul yang ditampilkan di AppBar
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue, /// Warna latar belakang AppBar
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0), /// Padding di sekitar konten
                child: Column(
                  children: <Widget>[
                    /// TextField untuk memasukkan nama pengguna
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    /// TextField untuk memasukkan kata sandi dengan fitur penglihatan
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          /// Ikon untuk mengubah visibilitas kata sandi
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              /// Mengubah status visibilitas kata sandi
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword, /// Menyembunyikan teks kata sandi
                    ),
                    const SizedBox(height: 20), /// Jarak vertikal antara elemen
                    /// Tombol login untuk mengautentikasi pengguna
                    ElevatedButton(
                      onPressed: () async {
                        /// Memeriksa kredensial pengguna menggunakan DBHelper
                        var user = await DBHelper().getUser(
                          _usernameController.text,
                          _passwordController.text,
                        );
                        if (user != null) {
                          /// Mengalihkan ke DashboardScreen jika pengguna valid
                          Get.off(() => const DashboardScreen());
                        } else {
                          /// Menampilkan snackbar jika kredensial salah
                          Get.snackbar(
                            'Perhatian',
                            'Username dan password anda salah !!!',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, /// Warna latar belakang tombol
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white /// Warna teks tombol
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