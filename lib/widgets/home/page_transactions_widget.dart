import 'package:atm/core/dialogs.dart';
import 'package:atm/core/shimmer/transaction_shimmer.dart';
import 'package:atm/models/transaction_model.dart';
import 'package:atm/widgets/home/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../cubits/transactions_cubit/transactions_cubit.dart';

class PageTransactionsWidget extends StatelessWidget {
  const PageTransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionsCubit = context.read<TransactionsCubit>();
    final mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsSuccessState) {
          final isLastPage = state.isReachMax;
          if (isLastPage) {
            transactionsCubit.pagingController
                .appendLastPage(state.transactions);
          } else {
            final nextPageKey = (transactionsCubit.allTransactions.length ~/
                    transactionsCubit.pageSize) +
                1;
            transactionsCubit.pagingController
                .appendPage(state.transactions, nextPageKey);
          }
        } else if (state is TransactionsFailedState) {
          errorDialog(context: context, text: state.errorMessage);
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: mediaQuery.height / 1.55,
          child: PagedListView<int, TransactionModel>(
            padding: EdgeInsets.zero,
            pagingController: transactionsCubit.pagingController,
            builderDelegate: PagedChildBuilderDelegate<TransactionModel>(
              itemBuilder: (context, item, index) => TransactionWidget(
                transaction: item,
              ).animate().fade(
                    duration: const Duration(milliseconds: 500),
                  ),
              noItemsFoundIndicatorBuilder: (context) =>
                  const Center(child: Text('No Data')),
              firstPageProgressIndicatorBuilder: (context) => Center(
                child: TransactionShimmer(
                  height: mediaQuery.height / 9,
                ),
              ),
              newPageProgressIndicatorBuilder: (context) => Center(
                child: TransactionShimmer(
                  height: mediaQuery.height / 9,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
