import 'package:atm/models/transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dio;

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/functions/apis_error_handler.dart';
import '../../core/server/dio_settings.dart';
part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit() : super(TransactionsInitial());
  List<TransactionModel> allTransactions = [];

  PagingController<int, TransactionModel> pagingController =
      PagingController(firstPageKey: 1);
  final int pageSize = 5;

  Future<void> initState(
      {required BuildContext context, required int userId}) async {
    pagingController.addPageRequestListener(
      (pageKey) {
        getAllTransactions(context: context, pageKey: pageKey, userId: userId);
      },
    );
  }

  Future<void> getAllTransactions({
    required BuildContext context,
    required int pageKey,
    required int? userId,
  }) async {
    try {
      final response = await dio().get(
        'users/$userId/transactions',
        queryParameters: {
          'page': pageKey,
        },
        options: Dio.Options(
          headers: {'Authorization': 'Bearer '},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData =
            await response.data['data']['transactions'] as List;
        List<TransactionModel> newTransactions = await jsonData
            .map(
              (e) => TransactionModel.fromJson(e),
            )
            .toList();
        allTransactions.addAll(newTransactions);
        emit(TransactionsSuccessState(
            transactions: newTransactions,
            isReachMax: response.data['data']['current_page'] ==
                response.data['data']['last_page']));
      }
    } on DioException catch (e) {
      errorHandler(e: e, context: context);
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(TransactionsFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(TransactionsFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}