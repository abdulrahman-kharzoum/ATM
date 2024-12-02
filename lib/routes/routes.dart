import 'package:atm/cubits/splash_cubit/splash_cubit.dart';
import 'package:atm/screens/register_screen.dart';
import 'package:atm/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/login/login_cubit.dart';
import '../screens/key_generation.dart';
import '../screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  // '/': (context) =>
  //     BlocProvider(
  //       create: (context) => SplashCubit()..checkInternetCounter,
  //       child: SplashScreen(),
  //     ),
  '/': (context) => SplashScreen(),
  '/login_screen': (context) =>
      BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
  '/register_screen': (context) => const RegisterScreen(),
  '/key_generation': (context) => const KeyGenerationScreen(),
};
