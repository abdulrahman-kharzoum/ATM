import 'dart:convert';

import 'package:atm/core/shared/local_network.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/functions/apis_error_handler.dart';
import '../../../core/functions/encryption.dart';
import '../../../core/server/dio_settings.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  void toggleShowPassword(bool show) {
    _showPassword = show;
    emit(ShowPassword(_showPassword));
  }

  Future<void> login({
    required BuildContext context,
  }) async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoading());
      final publicKey = await CashNetwork.getCashData(key: 'public_key');
      print(
          'the User public key is => ${await CashNetwork.getCashData(key: 'public_key')}');

      if (publicKey == null || publicKey.isEmpty) {
        print('Public key is null or empty');
        emit(LoginFailure(errorMessage: 'Public key is missing'));
        return;
      }
      final token = await CashNetwork.getCashData(key: 'authToken');
      if(token.isEmpty){
        print("Token is missing");
      }

      final loginData = {
        'username': usernameController.text,
        'password': passwordController.text,
        'public_key': await CashNetwork.getCashData(key: 'public_key'),
      };
      print("loginData : $loginData");
      final encryptedData = await Encryption().encryptMessage(
        data: json.encode(loginData),
      );
      print("encrypted Data : $encryptedData");
      print('--------------------------------------------------');

      try {
        final response = await dio().post(
          'auth/login',
          data: json.encode({
            'encryptedData': encryptedData,
          }),
          // options: Options(
          //   headers: {
          //     'Authorization': 'Bearer $token',
          //     'Content-Type': 'application/json',
          //   },
          // ),
        );
        print(
            '--------------------- status code is ${response.statusCode}\n ${response.data}');
        if (response.statusCode == 200) {
          print(response);
          final decryptedData = await Encryption().decryptMessage(
            encryptedData: response.data['encryptedData'],
          );
          print('The decrypted data is => $decryptedData');
          var responseDecode = json.decode(decryptedData);
          if (responseDecode['message'] == 'Wrong Credentials') {
            emit(LoginFailure(
                errorMessage: "Login failed \n" + responseDecode['errors']));
          }
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(
              errorMessage: "Login failed \n" + response.data['error']));
        }
      } on DioException catch (e) {
        Navigator.pop(context);
        errorHandler(e: e, context: context);
        print(
            'The failed status code is ${e.response!.statusCode}\n${e.response!.data}');
        emit(LoginFailure(errorMessage: e.response!.data['errors'][0]));
      } catch (e) {
        Navigator.pop(context);
        print('================ catch exception =================');
        print(e);
        emit(LoginFailure(errorMessage: 'Login failed \n Wrong username or password'));
        print(e);
      }
    }
  }
}
