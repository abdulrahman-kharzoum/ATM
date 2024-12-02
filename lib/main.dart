import 'package:atm/routes/routes.dart';
import 'package:flutter/material.dart';

import 'core/functions/statics.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    Statics.isPlatformDesktop = mediaQuery.width > 700;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: routes
    );
  }
}
