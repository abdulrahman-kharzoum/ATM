import 'package:atm/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/shared/local_network.dart';
import 'core/functions/statics.dart';
import 'cubits/balance_cubit/balance_cubit.dart';
import 'cubits/transactions_cubit/transactions_cubit.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await CashNetwork.cashInitialization();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TransactionsCubit()..initState(context: context, userId: 1),
      ),
      BlocProvider(
        create: (context) => BalanceCubit(),
      ),
    ], child: const MyApp()),
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
        routes: routes);
  }
}
