import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../themes/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login_screen');
    });

    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/background.jpg',
                height: mediaQuery.height,
                width: mediaQuery.width,
                fit: BoxFit.cover,
              ),
            ),
            // Logo Animation
            Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: mediaQuery.height / 3,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ))
                .animate()
                .fade(duration: const Duration(milliseconds: 100))
                .slideY(begin: 1, end: 0, duration: const Duration(milliseconds: 500)),
          ],
        ),
      ),
    );
  }
}
