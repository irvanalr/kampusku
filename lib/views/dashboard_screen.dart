import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampusku/views/add_student_screen.dart';
import 'package:kampusku/views/information_screen.dart';
import 'package:kampusku/views/login_screen.dart';
import 'view_students_screen.dart';

/// Kelas DashboardScreen untuk menampilkan antarmuka layar utama aplikasi
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key}); /// Konstruktor kelas dengan parameter key

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, /// Mengatur apakah tampilan dapat dipop dari stack
      onPopInvokedWithResult: (didPop, result) async {
        /// Mengatur apa yang terjadi ketika pengguna mencoba untuk kembali dari tampilan
        if (didPop) return; /// Jika tampilan sudah dipop, tidak melakukan apa-apa
        await ExitApp.handlePop(context); /// Menangani aksi saat tombol kembali ditekan
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard', /// Judul yang ditampilkan di AppBar
            style: TextStyle(color: Colors.white), // Gaya teks
          ),
          automaticallyImplyLeading: false, /// Tidak menampilkan tombol kembali secara otomatis
          backgroundColor: Colors.blue, /// Warna latar belakang AppBar
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, /// Menyusun widget di tengah-tengah
            children: <Widget>[

              /// Lihat Data
              InkWell(
                onTap: () {
                  Get.to(() => ViewStudentsScreen()); /// Navigasi ke ViewStudentsScreen saat diklik
                },
                child: Container(
                  /// Memberikan jarak horizontal dan vertical untuk widget ROW
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.red, /// Warna latar belakang tombol
                    borderRadius: BorderRadius.circular(8.0), /// Sudut melengkung tombol
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, /// Mengatur ukuran baris
                    children: [
                      Icon(Icons.list_alt, color: Colors.white), /// Ikon untuk tombol
                      SizedBox(width: 8.0), /// Jarak antara ikon dan teks
                      Text('LIHAT DATA', style: TextStyle(color: Colors.white)), /// Teks tombol
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8), /// Jarak vertikal antara tombol

              /// Input Data
              InkWell(
                onTap: () {
                  Get.to(() => const AddStudentScreen()); /// Navigasi ke AddStudentScreen saat diklik
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue, /// Warna latar belakang tombol
                    borderRadius: BorderRadius.circular(8.0), /// Sudut melengkung tombol
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, /// Mengatur ukuran baris
                    children: [
                      Icon(Icons.add, color: Colors.white), /// Ikon untuk tombol
                      SizedBox(width: 8.0), /// Jarak antara ikon dan teks
                      Text('INPUT DATA', style: TextStyle(color: Colors.white)), /// Teks tombol
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8), /// Jarak vertikal antara tombol

              /// Informasi
              InkWell(
                onTap: () {
                  Get.to(() => const InformationScreen()); /// Navigasi ke InformationScreen saat diklik
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow[800], /// Warna latar belakang tombol
                    borderRadius: BorderRadius.circular(8.0), /// Sudut melengkung tombol
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, /// Mengatur ukuran baris
                    children: [
                      Icon(Icons.info_outlined, color: Colors.white), /// Ikon untuk tombol
                      SizedBox(width: 8.0), /// Jarak antara ikon dan teks
                      Text('INFORMASI', style: TextStyle(color: Colors.white)), /// Teks tombol
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kelas ExitApp untuk menangani logika keluar aplikasi
class ExitApp {
  static DateTime? currentBackPressTime; /// Variabel untuk menyimpan waktu tekan tombol kembali

  static Future<void> handlePop(BuildContext context) async {
    DateTime now = DateTime.now(); /// Mendapatkan waktu saat ini
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      /// Jika tombol kembali ditekan lebih dari 2 detik sebelumnya
      currentBackPressTime = now; /// Memperbarui waktu tekan tombol kembali
      Get.snackbar(
        'Perhatian', /// Judul snackbar
        'Tekan sekali lagi untuk logout !!!', /// Pesan snackbar
        snackPosition: SnackPosition.BOTTOM, /// Posisi snackbar
        backgroundColor: Colors.red, /// Warna latar belakang snackbar
        colorText: Colors.white, /// Warna teks snackbar
      );
    } else {
      Get.off(const LoginScreen()); /// Navigasi ke LoginScreen jika tombol kembali ditekan dua kali
    }
  }
}
