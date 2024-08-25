import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../models/student.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  /// Mendapatkan instance database, jika belum diinisialisasi, maka akan memanggil _initDb untuk membuat dan membuka database.
  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  /// Menginisialisasi database dengan menentukan path dan membuka database dengan versi 1 serta membuat tabel-tabel yang diperlukan.
  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mahasiswa.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  /// Membuat tabel-tabel yang diperlukan di database saat pertama kali dibuat, termasuk tabel 'users' dan 'students'.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      password TEXT
    )
  ''');
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

    // Hash password default untuk admin
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
  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    var dbClient = await db;

    // Meng-hash password untuk pencocokan
    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

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
