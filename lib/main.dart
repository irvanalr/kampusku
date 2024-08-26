import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/splash_screen.dart';

void main() {
  /// Fungsi utama yang dijalankan saat aplikasi dimulai
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Membangun aplikasi dengan GetMaterialApp yang mendukung navigasi dan manajemen state menggunakan GetX
    return GetMaterialApp(
      /// Menentukan judul aplikasi
      title: 'Kampusku',
      /// Menentukan tema aplikasi dengan warna utama biru
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /// Menentukan layar utama yang akan ditampilkan saat aplikasi dibuka
      home: const SplashScreen(),
    );
  }
}