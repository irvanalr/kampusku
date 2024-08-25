import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/student_controller.dart';
import '../models/student.dart';

class AddStudentScreen extends StatelessWidget {
  final StudentController studentController = Get.put(StudentController());
  final TextEditingController nomorController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();

  AddStudentScreen({super.key});

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
            'Input Data',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nomorController,
                decoration: const InputDecoration(labelText: 'Nomor'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: tanggalLahirController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  hintText: 'DD-MM-YYYY',
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                    tanggalLahirController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jenisKelaminController,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Student newStudent = Student(
                    nomor: nomorController.text,
                    name: nameController.text,
                    tanggalLahir: tanggalLahirController.text,
                    jenisKelamin: jenisKelaminController.text,
                    alamat: alamatController.text,
                  );
                  studentController.addStudent(newStudent);
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
