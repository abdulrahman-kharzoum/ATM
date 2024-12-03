part of 'transactions_cubit.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}
final class TransactionLoadingState extends TransactionsState {}
final class TransactionPerformedState extends TransactionsState {
  final String message;

  TransactionPerformedState({required this.message});
}
class TransactionBalanceFetchedState extends TransactionsState {
  final String balance;

  TransactionBalanceFetchedState({required this.balance});
}
final class TransactionsSuccessState extends TransactionsState {
  final List<TransactionModel> transactions;
  final bool isReachMax;
  TransactionsSuccessState(
      {required this.transactions, required this.isReachMax});
}

final class TransactionsFailedState extends TransactionsState {
  final String errorMessage;
  TransactionsFailedState({
    required this.errorMessage,
  });
}
