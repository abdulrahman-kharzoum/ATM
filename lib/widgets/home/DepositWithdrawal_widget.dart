import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/transactions_cubit/transactions_cubit.dart';
import '../../screens/amount_selection_screen.dart';
class DepositWithdrawalRow extends StatelessWidget {
  final int userId;

  const DepositWithdrawalRow({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionPerformedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is TransactionsFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is TransactionLoadingState;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TButton(
              label: 'Deposit',
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
              ),
              onTap: isLoading
                  ? null
                  : () {
                // Navigate to the amount selection screen for deposit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmountSelectionScreen(operation: 'add'),
                  ),
                );
              },
            ),
            TButton(
              label: 'Withdrawal',
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orangeAccent],
              ),
              onTap: isLoading
                  ? null
                  : () {
                // Navigate to the amount selection screen for withdrawal
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmountSelectionScreen(operation: 'subtract'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class TButton extends StatelessWidget {
  final String label;
  final Gradient gradient;
  final VoidCallback? onTap;

  TButton({
    required this.label,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}