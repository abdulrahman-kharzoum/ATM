import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/transactions_cubit/transactions_cubit.dart';
class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key, required this.mediaQuery});
  final Size mediaQuery;

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  void initState() {
    super.initState();

    final userId = 1;
    context.read<TransactionsCubit>().getBalance(userId);
  }

  @override
  Widget build(BuildContext context) {
    String bal = "100";
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionBalanceFetchedState) {
          bal = state.balance;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.balance} ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: widget.mediaQuery.width / 7),
                  ),
                  Text(
                    'SPY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: widget.mediaQuery.width / 15),
                  ),
                ],
              ),
              Text(
                'Your current balance',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: widget.mediaQuery.width / 25),
              ),
            ],
          );
        } else if (state is TransactionsFailedState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        else if(state is BalanceLoadingState){
          return Center(child: CircularProgressIndicator()); // Loading state
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bal,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: widget.mediaQuery.width / 7),
                ),
                Text(
                  'SPY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: widget.mediaQuery.width / 15),
                ),
              ],
            ),
            Text(
              'Your current balance',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: widget.mediaQuery.width / 25),
            ),
          ],
        );
      },
    );
  }
}
