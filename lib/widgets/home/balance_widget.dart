import 'package:atm/cubits/balance_cubit/balance_cubit.dart';
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
    context.read<BalanceCubit>().getBalance(userId);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BalanceCubit, BalanceState>(
      builder: (context, state) {
        if (state is BalanceFetchedState ) {

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
        }
        else if(state is BalanceUpdatedState){

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

        }
        else if (state is BalanceFailedState) {
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

        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           bal,
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //               fontSize: widget.mediaQuery.width / 7),
        //         ),
        //         Text(
        //           'SPY',
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.white,
        //               fontSize: widget.mediaQuery.width / 15),
        //         ),
        //       ],
        //     ),
        //     Text(
        //       'Your current balance',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           color: Colors.white,
        //           fontSize: widget.mediaQuery.width / 25),
        //     ),
        //   ],
        // );
        return Container();
      },
    );
  }
}
