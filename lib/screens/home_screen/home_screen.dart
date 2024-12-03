import 'package:atm/core/shared/local_network.dart';
import 'package:atm/widgets/home/balance_widget.dart';
import 'package:atm/widgets/home/page_transactions_widget.dart';
import 'package:flutter/material.dart';

import '../../themes/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.dark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await CashNetwork.clearCash();
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login_screen',
                (route) => true,
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: Stack(
          children: [
            Positioned(
              right: mediaQuery.width / 30,
              top: 3,
              child: Opacity(
                opacity: 0.08,
                child: const Image(
                  image: AssetImage('assets/images/circles.png'),
                ),
              ),
            ),
            Positioned(
              left: mediaQuery.width / 30,
              bottom: mediaQuery.height / 20,
              child: Opacity(
                opacity: 0.08,
                child: const Image(
                  image: AssetImage('assets/images/circles.png'),
                ),
              ),
            ),
            SizedBox(
              width: mediaQuery.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mediaQuery.height / 10,
                  ),
                  BalanceWidget(mediaQuery: mediaQuery),
                  SizedBox(
                    height: mediaQuery.height / 70,
                  ),
                  PageTransactionsWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
