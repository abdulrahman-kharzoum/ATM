import 'package:atm/cubits/register_cubit/register_cubit.dart';
import 'package:atm/cubits/splash_cubit/splash_cubit.dart';
import 'package:atm/screens/home_screen/home_screen.dart';
import 'package:atm/screens/register_screen/register_screen.dart';
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
  '/': (context) => BlocProvider(
        create: (context) => SplashCubit()..initState(context: context),
        child: SplashScreen(),
      ),
  '/login_screen': (context) => BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
  '/register_screen': (context) => BlocProvider(
        create: (context) => RegisterCubit(),
        child: const RegisterScreen(),
      ),
  '/key_generation': (context) => const KeyGenerationScreen(),
  '/home_screen': (context) => const HomeScreen(),
};
