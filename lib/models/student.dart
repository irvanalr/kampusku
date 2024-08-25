class Student {
  int? id;
  String? nomor;
  String? name;
  String? tanggalLahir;
  String? jenisKelamin;
  String? alamat;

  Student({
    this.id,
    this.nomor,
    this.name,
    this.tanggalLahir,
    this.jenisKelamin,
    this.alamat,
  });

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
