import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../helpers/db_helper.dart';
import '../models/student.dart';

class StudentController extends GetxController {
  // observable atau variabel pengamatan students berbentuk list
  var students = <Student>[].obs;
  // observable atau variable pengamatan isLoading berbentuk bool
  var isLoading = true.obs;

  // init getx untuk mendapatkan data mahasiswa
  // dengan memanggil fungsi fetchStudents
  // init akan di jalankan ketika class StudentController di panggil
  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  // fungsi mendapatkan data mahasiswa
  void fetchStudents() async {
    isLoading(true);
    try {
      var studentsFromDb = await DBHelper().getStudents();
      students.assignAll(studentsFromDb);
    } finally {
      isLoading(false);
    }
  }

  // fungsi untuk menambahkan data mahasiswa
  void addStudent(Student student) async {
    student.tanggalLahir = formatDateForDb(student.tanggalLahir);
    await DBHelper().insertStudent(student);
    fetchStudents();
  }

  // fungsi untuk mengupdate data mahasiswa
  void updateStudent(Student student) async {
    student.tanggalLahir = formatDateForDb(student.tanggalLahir);
    await DBHelper().updateStudent(student);
    fetchStudents();
  }

  // fungsi untuk menghapus data mahasiswa
  void deleteStudent(int id) async {
    await DBHelper().deleteStudent(id);
    fetchStudents();
  }

  // Fungsi untuk format tanggal ke format YYYY-MM-DD
  String? formatDateForDb(String? date) {
    if (date == null) return null;
    final inputFormat = DateFormat('dd-MM-yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  // Fungsi untuk format tanggal ke format DD-MM-YYYY (untuk ditampilkan)
  String? formatDateForDisplay(String? date) {
    if (date == null) return null;
    final inputFormat = DateFormat('yyyy-MM-dd');
    final outputFormat = DateFormat('dd-MM-yyyy');
    final parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }
}
