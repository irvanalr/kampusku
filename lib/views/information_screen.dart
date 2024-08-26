import 'package:flutter/material.dart';

// Kelas untuk tampilan layar informasi aplikasi
class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  /// String yang berisi informasi tentang aplikasi
  final String bodyString = "Aplikasi Kampusku merupakan aplikasi yang digunakan untuk pendataan mahasiswa. User nantinya bisa menambahkan, update dan hapus data mahasiswa.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar adalah bilah aplikasi di bagian atas layar
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi', /// Judul yang ditampilkan di AppBar
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), /// Warna ikon di AppBar
        backgroundColor: Colors.blue, /// Warna latar belakang AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), /// Padding di sekitar konten
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, /// Menyelaraskan kolom di tengah vertikal
            crossAxisAlignment: CrossAxisAlignment.center, /// Menyelaraskan kolom di tengah horizontal
            children: <Widget>[
              /// Widget Text untuk menampilkan informasi aplikasi
              Text(
                bodyString, /// Menggunakan string informasi aplikasi
                style: const TextStyle(
                    fontSize: 16 /// Ukuran font untuk teks
                ),
                textAlign: TextAlign.center, /// Menyelaraskan teks di tengah
              )
            ],
          ),
        ),
      ),
    );
  }
}
