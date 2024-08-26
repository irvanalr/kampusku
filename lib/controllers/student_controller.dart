import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../helpers/db_helper.dart';
import '../models/student.dart';

// Kelas StudentController untuk mengelola data mahasiswa
class StudentController extends GetxController {
  /// Observable atau variabel pengamatan students berbentuk list
  /// Menyimpan daftar mahasiswa yang dapat di-observe oleh GetX
  var students = <Student>[].obs;

  /// Observable atau variabel pengamatan isLoading berbentuk bool
  /// Menyimpan status loading, true jika sedang mengambil data, false jika tidak
  var isLoading = true.obs;

  /// Init GetX untuk mendapatkan data mahasiswa
  /// Fungsi ini dipanggil saat kelas StudentController diinisialisasi
  @override
  void onInit() {
    fetchStudents(); // Memanggil fungsi fetchStudents untuk mengambil data mahasiswa
    super.onInit();
  }

  /// Fungsi untuk mendapatkan data mahasiswa dari database
  /// Mengubah status loading menjadi true saat mengambil data dan false setelah data diambil
  void fetchStudents() async {
    isLoading(true); // Menandakan bahwa proses pengambilan data sedang berlangsung
    try {
      var studentsFromDb = await DBHelper().getStudents(); // Mengambil data mahasiswa dari database
      students.assignAll(studentsFromDb); // Menyimpan data mahasiswa ke dalam observable list
    } finally {
      isLoading(false); // Mengubah status loading menjadi false setelah data diambil
    }
  }

  /// Fungsi untuk menambahkan data mahasiswa ke database
  /// Memformat tanggal lahir sebelum menyimpan dan kemudian memanggil fetchStudents untuk memperbarui daftar mahasiswa
  void addStudent(Student student) async {
    student.tanggalLahir = formatDateForDb(student.tanggalLahir); // Memformat tanggal lahir ke format yang sesuai dengan database
    await DBHelper().insertStudent(student); // Menambahkan mahasiswa ke database
    fetchStudents(); // Memperbarui daftar mahasiswa setelah penambahan
  }

  /// Fungsi untuk mengupdate data mahasiswa di database
  /// Memformat tanggal lahir sebelum memperbarui dan kemudian memanggil fetchStudents untuk memperbarui daftar mahasiswa
  void updateStudent(Student student) async {
    student.tanggalLahir = formatDateForDb(student.tanggalLahir); // Memformat tanggal lahir ke format yang sesuai dengan database
    await DBHelper().updateStudent(student); // Memperbarui data mahasiswa di database
    fetchStudents(); // Memperbarui daftar mahasiswa setelah pembaruan
  }

  /// Fungsi untuk menghapus data mahasiswa dari database
  /// Menghapus mahasiswa berdasarkan ID dan kemudian memanggil fetchStudents untuk memperbarui daftar mahasiswa
  void deleteStudent(int id) async {
    await DBHelper().deleteStudent(id); // Menghapus mahasiswa dari database berdasarkan ID
    fetchStudents(); // Memperbarui daftar mahasiswa setelah penghapusan
  }

  /// Fungsi untuk memformat tanggal ke format YYYY-MM-DD untuk disimpan di database
  String? formatDateForDb(String? date) {
    if (date == null) return null; // Mengembalikan null jika tanggal kosong
    final inputFormat = DateFormat('dd-MM-yyyy'); // Format input tanggal
    final outputFormat = DateFormat('yyyy-MM-dd'); // Format output tanggal untuk database
    final parsedDate = inputFormat.parse(date); // Mengonversi tanggal dari format input
    return outputFormat.format(parsedDate); // Mengonversi tanggal ke format output
  }

  /// Fungsi untuk memformat tanggal ke format DD-MM-YYYY untuk ditampilkan
  String? formatDateForDisplay(String? date) {
    if (date == null) return null; // Mengembalikan null jika tanggal kosong
    final inputFormat = DateFormat('yyyy-MM-dd'); // Format input tanggal
    final outputFormat = DateFormat('dd-MM-yyyy'); // Format output tanggal untuk tampilan
    final parsedDate = inputFormat.parse(date); // Mengonversi tanggal dari format input
    return outputFormat.format(parsedDate); // Mengonversi tanggal ke format output
  }
}
