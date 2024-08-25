import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  final String bodyString = "Aplikasi Kampusku merupakan aplikasi yang digunakan untuk pendataan mahasiswa. User nantinya bisa menambahkan, update dan hapus data mahasiswa.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
              padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  bodyString,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                  textAlign: TextAlign.center,
                )
              ],
          ),
        ),
      ),
    );
  }
}
