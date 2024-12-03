import 'package:atm/models/transaction_model.dart';
import 'package:atm/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.transaction});
  final TransactionModel transaction;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: mediaQuery.width,
      padding: EdgeInsets.symmetric(vertical: mediaQuery.height / 80),
      margin: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 20, vertical: mediaQuery.height / 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: transaction.type == 'deposit'
            ? Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 2)),
                child: Icon(
                  Icons.arrow_drop_up,
                  color: Colors.green,
                ))
            : Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red)),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.red,
                ),
              ),
        title: Text('${transaction.type} ' 'balance'),
        trailing: Text('${transaction.amount}' 'SPY'),
      ),
    );
  }
}
