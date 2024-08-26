import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

/// Widget SplashScreen yang berfungsi sebagai layar pembuka aplikasi
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Variabel untuk mengatur opacity (transparansi) dari ikon dan teks
  double _iconOpacity = 0.0;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    /// Memulai animasi fade-in untuk ikon setelah penundaan 1 detik
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _iconOpacity = 1.0;
      });
    });

    /// Memulai animasi fade-in untuk teks setelah penundaan 1 detik
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _textOpacity = 1.0;
      });
    });

    /// Menavigasi ke halaman login setelah total 5 detik dari awal
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Body Scaffold yang berisi animasi fade-in ikon dan teks di tengah layar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, /// Posisikan elemen secara vertikal di tengah
          children: <Widget>[
            /// Menampilkan ikon dengan animasi fade-in selama 2,5 detik setelah penundaan 1 detik
            AnimatedOpacity(
              opacity: _iconOpacity,
              duration: const Duration(milliseconds: 2500), /// Durasi animasi fade-in ikon
              child: const Icon(Icons.school, size: 100, color: Colors.blue), /// Ikon yang ditampilkan
            ),
            const SizedBox(height: 20), /// Memberi jarak antara ikon dan teks
            /// Menampilkan teks dengan animasi fade-in selama 2,5 detik setelah penundaan 1 detik
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(milliseconds: 2500), /// Durasi animasi fade-in teks
              child: const Text(
                'Kampusku', /// Teks yang ditampilkan
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), /// Gaya teks
              ),
            ),
          ],
        ),
      ),
    );
  }
}
