/// Representasi tipe data API database
/// Kelas ini digunakan untuk mewakili data mahasiswa dari database API
class Student {
  /// ID mahasiswa
  int? id;

  /// Nomor mahasiswa
  String? nomor;

  /// Nama mahasiswa
  String? name;

  /// Tanggal lahir mahasiswa
  String? tanggalLahir;

  /// Jenis kelamin mahasiswa
  String? jenisKelamin;

  /// Alamat mahasiswa
  String? alamat;

  /// Konstruktor untuk inisialisasi objek Student
  /// Parameter-parameter ini opsional dan dapat bernilai null
  Student({
    this.id,
    this.nomor,
    this.name,
    this.tanggalLahir,
    this.jenisKelamin,
    this.alamat,
  });

  /// Membuat instance Student dari Map
  /// Metode ini digunakan untuk mengonversi data yang diambil dari database
  factory Student.fromMap(Map<String, dynamic> data) {
    return Student(
      id: data['id'],
      nomor: data['nomor'],
      name: data['name'],
      tanggalLahir: data['tanggalLahir'],
      jenisKelamin: data['jenisKelamin'],
      alamat: data['alamat'],
    );
  }

  /// Mengonversi instance Student menjadi Map
  /// Metode ini digunakan untuk mempersiapkan data agar dapat disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomor': nomor,
      'name': name,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
      'alamat': alamat,
    };
  }
}
