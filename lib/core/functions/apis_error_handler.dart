import 'package:atm/core/dialogs.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../shared/connect.dart';

void errorHandler(
    {required DioException e, required BuildContext context}) async {
  if (e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.unknown) {
    await checkInternet()
        // ignore: use_build_context_synchronously
        ? serverToast(context: context)
        : internetToast(context: context);
    print("Connection Error.");
    return;
  } else if (e.type == DioExceptionType.connectionTimeout) {
    print("connection timeout.");
    return;
  } else if (e.type == DioExceptionType.sendTimeout) {
    print("Send timeout.");
    return;
  } else {
    print(
        '=============================dio exception method ===============================');
    if (e.response!.statusCode! > 500) {
      print('The response code is => ${e.response!.statusCode!}');
      errorDialog(context: context, text: 'Server is down');
      return;
    }
  }
}

void errorHandlerWithoutInternet(
    {required DioException e, required BuildContext context}) {
  if (e.type == DioExceptionType.receiveTimeout) {
    print("Receive timeout.");
    return;
  } else if (e.type == DioExceptionType.sendTimeout) {
    print("Send timeout.");
    return;
  } else {
    print(
        '=============================dio exception method ===============================');
    // if (e.response!.statusCode! > 500) {
    print('The response code is => ${e.response!.statusCode!}');
    errorDialog(
        context: context,
        text:
            "We are experiencing some technical issues on our end.\nPlease try again later.");
    return;
  }
}
