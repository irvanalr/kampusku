import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampusku/views/add_student_screen.dart';
import 'package:kampusku/views/information_screen.dart';
import 'package:kampusku/views/login_screen.dart';
import 'view_students_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          await ExitApp.handlePop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.to(() => ViewStudentsScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.list_alt, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('LIHAT DATA', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    Get.to(() => AddStudentScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('INPUT DATA', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    Get.to(() => const InformationScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outlined, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('INFORMASI', style: TextStyle(color: Colors.white)),
                      ],
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

/// Class untuk logout
class ExitApp {
  static DateTime? currentBackPressTime;

  static Future<void> handlePop(BuildContext context) async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.snackbar(
        'Perhatian',
        'Tekan sekali lagi untuk logout !!!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      Get.off(const LoginScreen());
    }
  }
}