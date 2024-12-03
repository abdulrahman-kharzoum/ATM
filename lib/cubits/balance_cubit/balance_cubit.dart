import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/server/dio_settings.dart';
import '../../core/shared/local_network.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit() : super(BalanceInitial());

  Future<void> getBalance(int userId) async {
    emit(BalanceLoadingState());

    try {
      final response = await dio().get(
        'users/$userId',
        options: Dio.Options(
          headers: {'Authorization': 'Bearer '},
        ),
      );

      if (response.statusCode == 200) {

        final data = response.data;
        final balance = data['balance'];
        print("balance : $balance");
        emit(BalanceFetchedState(balance: balance));
      } else {

        emit(BalanceFailedState(errorMessage: 'Failed to fetch balance'));
      }
    } catch (e) {
      emit(BalanceFailedState(errorMessage: 'Error: $e'));
    }
  }
  Future<void> updateBalance({
    required int userId,
    required String operation,
    required int amount,
  }) async {
    if (amount <= 0) {
      emit(BalanceFailedState(errorMessage: "Amount must be greater than 0"));
      return;
    }
    final token = await CashNetwork.getCashData(key: 'authToken');
    if (operation != 'add' && operation != 'subtract') {
      emit(BalanceFailedState(
          errorMessage: "Operation must be 'add' or 'subtract'"));
      return;
    }


    emit(BalanceLoadingState());

    try {
      final response = await dio().put(
        'users/${userId}/balance',
        data: {
          'amount': amount,
          'operation': operation,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {

        emit(BalanceUpdatedState(balance:response.data['data']['balance']));
      } else {
        emit(BalanceFailedState(
            errorMessage: response.data['error'] ?? 'Unexpected error occurred'));
      }
    } on DioException catch (e) {
      emit(BalanceFailedState(
          errorMessage: e.response?.data['message'] ?? 'Network error occurred'));
    } catch (e) {
      emit(BalanceFailedState(errorMessage: 'An error occurred: $e'));
    }
  }



}
