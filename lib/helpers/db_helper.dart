import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/student.dart';

/// Kelas DBHelper untuk mengelola koneksi dan operasi database
class DBHelper {
  /// Instansi tunggal dari DBHelper, menerapkan pola Singleton
  static final DBHelper _instance = DBHelper._internal();

  /// Factory constructor untuk mengembalikan instansi tunggal
  factory DBHelper() => _instance;

  /// Konstruktor privat untuk menginisialisasi DBHelper
  DBHelper._internal();

  /// Variabel untuk menyimpan instansi database
  static Database? _db;

  /// Mendapatkan instansi database
  /// Jika database belum diinisialisasi, maka akan memanggil _initDb untuk membuat dan membuka database
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  /// Menginisialisasi database dengan menentukan path dan membuka database dengan versi 1
  /// Juga membuat tabel-tabel yang diperlukan saat pertama kali database dibuat
  Future<Database> _initDb() async {
    // Mendapatkan path direktori untuk database
    String dbPath = await getDatabasesPath();
    // Menentukan path lengkap untuk file database
    String path = join(dbPath, 'mahasiswa.db');

    // Membuka database dan memanggil _onCreate untuk membuat tabel
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Membuat tabel-tabel yang diperlukan di database saat pertama kali dibuat
  /// Tabel 'users' untuk menyimpan data pengguna dan tabel 'students' untuk menyimpan data mahasiswa
  Future<void> _onCreate(Database db, int version) async {
    // Membuat tabel 'users'
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
    )
  ''');

    // Membuat tabel 'students'
    await db.execute('''
    CREATE TABLE students (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nomor TEXT,
      name TEXT,
      tanggalLahir TEXT,
      jenisKelamin TEXT,
      alamat TEXT
    )
  ''');

    // Meng-hash password default untuk admin dan menyimpannya ke tabel 'users'
    var password = 'Asdf1234';
    var bytes = utf8.encode(password); // Mengonversi password ke bytes
    var hashedPassword = sha256.convert(bytes).toString(); // Meng-hash password

    // Menyimpan data user admin ke tabel 'users'
    await db.insert('users', {
      'username': 'admin',
      'password': hashedPassword,
    });
  }

  /// Mengambil data pengguna dari tabel 'users' berdasarkan username dan password yang telah di-hash
  Future<Map<String, dynamic>?> getUser(String username, String password) async {
    var dbClient = await db;

    // Meng-hash password untuk pencocokan
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

    // Query untuk mencari pengguna berdasarkan username dan password yang di-hash
    List<Map<String, dynamic>> maps = await dbClient.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, hashedPassword]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  /// Menambahkan data pengguna baru ke tabel 'users'
  Future<int> insertUser(Map<String, dynamic> user) async {
    var dbClient = await db;
    return await dbClient.insert('users', user);
  }

  /// Menambahkan data mahasiswa baru ke tabel 'students'
  Future<int> insertStudent(Student student) async {
    var dbClient = await db;
    return await dbClient.insert('students', student.toMap());
  }

  /// Memperbarui data mahasiswa berdasarkan ID di tabel 'students'
  Future<int> updateStudent(Student student) async {
    var dbClient = await db;
    return await dbClient.update('students', student.toMap(),
        where: 'id = ?', whereArgs: [student.id]);
  }

  /// Menghapus data mahasiswa berdasarkan ID dari tabel 'students'
  Future<int> deleteStudent(int id) async {
    var dbClient = await db;
    return await dbClient.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  /// Mengambil semua data mahasiswa dari tabel 'students' dan mengonversinya menjadi list objek Student
  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query('students');
    return maps.map((student) => Student.fromMap(student)).toList();
  }
}
