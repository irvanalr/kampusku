import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

/// Kelas AddStudentScreen untuk menampilkan antarmuka layar tambah mahasiswa
class AddStudentScreen extends StatefulWidget {
  /// Konstruktor kelas AddStudentScreen
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

/// State untuk AddStudentScreen
class _AddStudentScreenState extends State<AddStudentScreen> {
  /// Instance dari StudentController untuk mengelola operasi terkait mahasiswa
  final StudentController studentController = Get.put(StudentController());

  /// Controller untuk masing-masing field input
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Menangani klik di luar field input untuk menghilangkan fokus keyboard
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        /// Struktur dasar tampilan layar dengan AppBar dan body
        appBar: AppBar(
          title: const Text(
            'Input Data',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          /// Memungkinkan scroll jika konten melebihi ukuran layar
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Field input untuk nomor mahasiswa
              TextField(
                controller: nomorController,
                decoration: const InputDecoration(labelText: 'Nomor'),
              ),
              const SizedBox(height: 16),
              /// Field input untuk nama mahasiswa
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              const SizedBox(height: 16),
              // /Field input untuk tanggal lahir mahasiswa
              TextField(
                controller: tanggalLahirController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  hintText: 'DD-MM-YYYY',
                ),
                readOnly: true, /// Field ini hanya dapat diubah dengan memilih tanggal dari date picker
                onTap: () async {
                  /// Menampilkan date picker untuk memilih tanggal
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    /// Memformat tanggal yang dipilih ke format DD-MM-YYYY
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    tanggalLahirController.text = formattedDate; /// Mengatur nilai controller
                  }
                },
              ),
              const SizedBox(height: 16),
              /// Field input untuk jenis kelamin mahasiswa
              TextField(
                controller: jenisKelaminController,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              const SizedBox(height: 16),
              /// Field input untuk alamat mahasiswa
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(height: 20),
              /// Tombol atau button untuk menambahkan mahasiswa
              ElevatedButton(
                onPressed: () {
                  /// Membuat instance baru dari Student dengan data dari input
                  Student newStudent = Student(
                    nomor: nomorController.text,
                    name: nameController.text,
                    tanggalLahir: tanggalLahirController.text,
                    jenisKelamin: jenisKelaminController.text,
                    alamat: alamatController.text,
                  );
                  /// Menambahkan mahasiswa menggunakan StudentController
                  studentController.addStudent(newStudent);
                  /// Kembali ke layar sebelumnya setelah penambahan
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Add Student',
                  style: TextStyle(
                      color: Colors.white
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
