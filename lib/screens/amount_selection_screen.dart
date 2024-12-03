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
    // Perform the transaction based on the amount and operation (deposit/withdraw)
    context.read<TransactionsCubit>().performTransaction(
      userId: 1, // Pass the user ID if needed
      operation: operation,
      amount: amount,
    );
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
