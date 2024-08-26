import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

/// Kelas untuk tampilan layar edit data mahasiswa
class EditStudentScreen extends StatefulWidget {
  /// Menyimpan controller dan data mahasiswa yang akan diedit
  final StudentController studentController = Get.put(StudentController());
  final Student student;

  /// Konstruktor kelas dengan parameter key dan data mahasiswa
  EditStudentScreen({super.key, required this.student});

  @override
  State<EditStudentScreen> createState() => _EditStudentScreenState();
}

/// State dari kelas EditStudentScreen
class _EditStudentScreenState extends State<EditStudentScreen> {
  /// Kontroler untuk setiap field input
  final TextEditingController _nomorController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _jenisKelaminController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Mengatur nilai awal kontroler dengan data mahasiswa yang ada
    /// menggunakan Null Coalescing Operator
    _nomorController.text = widget.student.nomor ?? '';
    _nameController.text = widget.student.name ?? '';
    _tanggalLahirController.text = widget.studentController.formatDateForDisplay(widget.student.tanggalLahir) ?? '';
    _jenisKelaminController.text = widget.student.jenisKelamin ?? '';
    _alamatController.text = widget.student.alamat ?? '';

    return GestureDetector(
      onTap: () {
        /// Menyembunyikan keyboard jika area di luar input ditekan
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Data', /// Judul yang ditampilkan di AppBar
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue, /// Warna latar belakang AppBar
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), /// Padding di sekitar konten
          child: Column(
            children: <Widget>[
              /// Input field untuk nomor mahasiswa
              TextField(
                controller: _nomorController,
                decoration: const InputDecoration(labelText: 'Nomor'), /// Label untuk input
              ),
              const SizedBox(height: 16), /// Jarak vertikal antara input fields
              /// Input field untuk nama mahasiswa
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'), /// Label untuk input
              ),
              const SizedBox(height: 16),
              /// Input field untuk tanggal lahir mahasiswa
              TextField(
                controller: _tanggalLahirController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  hintText: 'DD-MM-YYYY', /// Teks petunjuk format tanggal
                ),
                readOnly: true, /// Membuat field tidak dapat diedit secara langsung
                onTap: () async {
                  /// Menampilkan dialog pemilih tanggal saat field diketuk
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    /// Mengatur tanggal yang dipilih ke dalam kontroler
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    _tanggalLahirController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 16),
              /// Input field untuk jenis kelamin mahasiswa
              TextField(
                controller: _jenisKelaminController,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'), // Label untuk input
              ),
              const SizedBox(height: 16),
              /// Input field untuk alamat mahasiswa
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'), // Label untuk input
              ),
              const SizedBox(height: 20),
              /// Tombol untuk menyimpan perubahan data mahasiswa
              ElevatedButton(
                onPressed: () {
                  /// Memperbarui data mahasiswa melalui controller
                  widget.studentController.updateStudent(
                    Student(
                      id: widget.student.id,
                      nomor: _nomorController.text,
                      name: _nameController.text,
                      tanggalLahir: _tanggalLahirController.text,
                      jenisKelamin: _jenisKelaminController.text,
                      alamat: _alamatController.text,
                    ),
                  );
                  Get.back(); /// Kembali ke tampilan sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, /// Warna latar belakang tombol
                ),
                child: const Text(
                  'Update Data', /// Teks tombol
                  style: TextStyle(
                      color: Colors.white /// Warna teks tombol
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