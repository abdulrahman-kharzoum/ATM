part of 'balance_cubit.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}

final class BalanceFailedState extends BalanceState {
  final String errorMessage;
  BalanceFailedState({
    required this.errorMessage,
  });
}
final class BalanceLoadingState extends BalanceState {

}
class BalanceFetchedState extends BalanceState {
  final String balance;

  BalanceFetchedState({required this.balance});
}

class BalanceUpdatedState extends BalanceState {
  final String balance;

  BalanceUpdatedState({required this.balance});
}
