import 'package:flutter/material.dart';
import '../models/student.dart';

/// Widget yang menampilkan detail informasi mahasiswa
class ShowStudentScreen extends StatelessWidget {
  /// Objek student yang akan ditampilkan
  final Student student;

  /// Konstruktor untuk ShowStudentScreen, menerima objek student sebagai parameter
  const ShowStudentScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar yang menampilkan judul "Detail Mahasiswa"
      appBar: AppBar(
        title: const Text(
          'Detail Mahasiswa', /// Judul di AppBar
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white), /// Warna ikon di AppBar
        backgroundColor: Colors.blue, /// Warna latar belakang AppBar
      ),
      /// Body dari Scaffold yang menampilkan detail mahasiswa
      body: Padding(
        padding: const EdgeInsets.all(16.0), /// Padding di sekitar konten
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, /// Konten disejajarkan ke kiri
          children: <Widget>[
            /// Menampilkan nomor mahasiswa
            Text('Nomor: ${student.nomor}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8), /// Jarak vertikal antara elemen
            /// Menampilkan nama mahasiswa
            Text('Nama: ${student.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8), /// Jarak vertikal antara elemen
            /// Menampilkan tanggal lahir mahasiswa
            Text('Tanggal Lahir: ${student.tanggalLahir}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8), /// Jarak vertikal antara elemen
            /// Menampilkan jenis kelamin mahasiswa
            Text('Jenis Kelamin: ${student.jenisKelamin}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8), /// Jarak vertikal antara elemen
            /// Menampilkan alamat mahasiswa
            Text('Alamat: ${student.alamat}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}