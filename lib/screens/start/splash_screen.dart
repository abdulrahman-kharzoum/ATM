import 'package:atm/cubits/splash_cubit/splash_cubit.dart';
import 'package:atm/cubits/transactions_cubit/transactions_cubit.dart';
import 'package:atm/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes/color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoginState) {
          Future.delayed(
            const Duration(seconds: 3),
            () {
              Navigator.of(context).pushReplacementNamed('/login_screen');
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(
              //     builder: (context) => BlocProvider(
              //       create: (context) => TransactionsCubit()
              //         ..initState(context: context, userId: 1),
              //       child: HomeScreen(),
              //     ),
              //   ),
              //   (route) => true,
              // );
            },
          );
        }
      },
      builder: (context, state) {
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
                    .slideY(
                        begin: 1,
                        end: 0,
                        duration: const Duration(milliseconds: 500)),
              ],
            ),
          ),
        );
      },
    );
  }
}
