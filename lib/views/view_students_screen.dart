import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampusku/views/show_student_screen.dart';
import '../controllers/student_controller.dart';
import 'edit_student_screen.dart';
import '../models/student.dart';

/// Widget untuk menampilkan daftar mahasiswa
class ViewStudentsScreen extends StatelessWidget {
  /// Inisialisasi controller mahasiswa menggunakan GetX
  final StudentController studentController = Get.put(StudentController());

  ViewStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Menampilkan judul di AppBar
        title: const Text(
          'Data Mahasiswa',
          style: TextStyle(color: Colors.white),
        ),
        /// Menentukan warna ikon di AppBar
        iconTheme: const IconThemeData(color: Colors.white),
        /// Menentukan warna latar belakang AppBar
        backgroundColor: Colors.blue,
      ),
      /// Mengamati perubahan state pada daftar mahasiswa
      body: Obx(() {
        /// Jika daftar mahasiswa kosong, tampilkan teks 'No data available'
        if (studentController.students.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          /// Menampilkan daftar mahasiswa menggunakan ListView
          return ListView.builder(
            /// Jumlah item yang akan ditampilkan berdasarkan jumlah mahasiswa
            itemCount: studentController.students.length,
            /// Membuat widget ListTile untuk setiap item mahasiswa
            itemBuilder: (context, index) {
              final student = studentController.students[index];
              /// Mengambil data mahasiswa pada indeks tertentu
              return ListTile(
                /// Menampilkan nama mahasiswa sebagai judul ListTile
                title: Text(student.name ?? ''),
                /// Menampilkan dialog opsi saat item ListTile ditekan
                onTap: () {
                  _showStudentOptions(context, student);
                },
              );
            },
          );
        }
      }),
    );
  }

  /// Menampilkan dialog dengan opsi untuk melihat, mengedit, atau menghapus data mahasiswa
  void _showStudentOptions(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          /// Menampilkan judul dialog
          title: const Text('Pilih'),
          content: Column(
            /// Menyesuaikan ukuran kolom agar pas dengan konten
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Opsi untuk melihat data mahasiswa
              ListTile(
                leading: const Icon(Icons.remove_red_eye),
                title: const Text('Lihat Data'),
                onTap: () {
                  Get.back();
                  Get.to(() => ShowStudentScreen(student: student));
                },
              ),
              /// Opsi untuk mengedit data mahasiswa
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Update Data'),
                onTap: () {
                  Get.back();
                  Get.to(() => EditStudentScreen(student: student));
                },
              ),
              /// Opsi untuk menghapus data mahasiswa
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Hapus Data'),
                onTap: () {
                  Get.back();
                  _confirmDelete(context, student);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Menampilkan dialog konfirmasi sebelum menghapus data mahasiswa
  void _confirmDelete(BuildContext context, Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          /// Menampilkan judul dialog konfirmasi
          title: const Text('Konfirmasi Hapus'),
          /// Menampilkan pesan konfirmasi
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: <Widget>[
            /// Tombol untuk membatalkan penghapusan
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Get.back();
              },
            ),
            /// Tombol untuk mengkonfirmasi penghapusan
            TextButton(
              child: const Text('Hapus'),
              onPressed: () {
                Get.back();
                /// Memanggil fungsi untuk menghapus mahasiswa dari daftar
                studentController.deleteStudent(student.id!);
              },
            ),
          ],
        );
      },
    );
  }
}