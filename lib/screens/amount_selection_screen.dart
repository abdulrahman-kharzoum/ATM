import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/transactions_cubit/transactions_cubit.dart';

class AmountSelectionScreen extends StatelessWidget {
  final String operation;

  const AmountSelectionScreen({Key? key, required this.operation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amounts = operation == 'add'
        ? [1000, 5000, 10000, 15000, 20000]
        : [1000, 5000, 10000, 15000, 20000];

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF101727),

        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // Pops the current screen
          },
        ),

      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF101727), Color(0xFF111418)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 10),
              Text(
                operation == 'add' ? 'Deposit' : 'Withdraw',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Container(
                height: 480,
                width: 369,
                decoration: BoxDecoration(
                  color: const Color(0xFF232938),
                  borderRadius: BorderRadius.circular(23),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: [
                          for (var amount in amounts)
                            _buildAmountButton(context, amount),
                          _buildOtherButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(BuildContext context, int amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 55,
        width: 110,
        child: ElevatedButton(
          onPressed: () {
            _performTransaction(context, amount);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xf000000ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(85),
              side: const BorderSide(width: 0.69, color: Color(0xFF8FA0A1)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          ),
          child: Text(
            '$amount SYP',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtherButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 55,
        width: 110,
        child: ElevatedButton(
          onPressed: () {
            _showCustomAmountDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xf000000ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(85),
              side: const BorderSide(width: 0.69, color: Color(0xFF8FA0A1)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          ),
          child: const Text(
            'Other',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _performTransaction(BuildContext context, int amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF101727), // Same as the page background color
          title: Text(
            operation == 'add' ? 'Confirm Deposit' : 'Confirm Withdrawal',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to ${operation == 'add' ? 'deposit' : 'withdraw'} $amount SYP?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                // Perform the transaction if confirmed
                _executeTransaction(context, amount);
                Navigator.pop(context); // Close the dialog
              },
              child: Text(operation == 'add' ? 'Deposit' : 'Withdraw', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _executeTransaction(BuildContext context, int amount) async {

    try {
      await context.read<TransactionsCubit>().performTransaction(
        userId: 1,
        operation: operation,
        amount: amount,
      );

      // // Show success message after transaction
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       operation == 'add' ? 'Deposit successful!' : 'Withdrawal successful!',
      //       style: TextStyle(color: Colors.white),
      //     ),
      //     backgroundColor: Colors.green,
      //   ),
      // );
    } catch (e) {
      // Show failure message in case of an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Transaction failed: $e',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCustomAmountDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final amount = int.tryParse(controller.text);
                if (amount != null && amount > 0) {
                  _performTransaction(context, amount);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid amount')),
                  );
                }
              },
              child: Text(operation == 'add' ? 'Deposit' : 'Withdraw'),
            ),
          ],
        );
      },
    );
  }
}
