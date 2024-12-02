import 'dart:convert';

import 'package:atm/core/functions/encryption.dart';
import 'package:atm/core/shared/local_network.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../core/functions/apis_error_handler.dart';
import '../../core/server/dio_settings.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  void toggleShowPassword(bool show) {
    _showPassword = show;
    emit(ShowRegisterPassword(_showPassword));
  }

  Future<void> register({required BuildContext context}) async {
    emit(RegisterLoadingState());
    print(
        'the original public key is => ${await CashNetwork.getCashData(key: 'public_key')}');
    final data = {
      "username": usernameController.text,
      "password": passwordController.text,
      "public_key": await CashNetwork.getCashData(key: 'public_key'),
    };
    print('The data we will send => $data');
    final encryptedData = await Encryption().encryptMessage(
      data: json.encode(data),
    );
    print('the encrypted data => $encryptedData');
    print('--------------------------------------------------');
    try {
      final response = await dio().post(
        'auth/register',
        data: json.encode({
          'encryptedData': encryptedData,
        }),
      );
      print(
          '--------------------- status code is ${response.statusCode}\n ${response.data}');
      final decryptedData = await Encryption().decryptMessage(
        encryptedData: response.data['encryptedData'],
      );
      print('The decrypted data is => $decryptedData');

      Navigator.pop(context);
    } on DioException catch (e) {
      Navigator.pop(context);
      errorHandler(e: e, context: context);

      print(
          'The failed status code is ${e.response!.statusCode}\n${e.response!.data}');
      emit(RegisterFailedState(errorMessage: e.response!.data['errors'][0]));
    } catch (e) {
      Navigator.pop(context);
      print('================ catch exception =================');
      print(e);
      emit(RegisterFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
