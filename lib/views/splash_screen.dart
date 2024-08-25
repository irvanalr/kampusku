import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Opacity state variables
  double _iconOpacity = 0.0;
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    /// animasi fadein untuk Icon
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _iconOpacity = 1.0;
      });
    });

    /// animasi fadeout untuk text
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _textOpacity = 1.0;
      });
    });

    /// Navigasi ke halaman login
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() => const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              opacity: _iconOpacity,
              duration: const Duration(seconds: 1),
              child: const Icon(Icons.school, size: 100, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _textOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                'Kampusku',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
