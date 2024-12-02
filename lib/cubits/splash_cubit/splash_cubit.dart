import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/material.dart';
import '../../core/shared/local_network.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  int checkInternetCounter = -1;

  Future<void> generateKeys() async {
    String? publicKey = CashNetwork.getCashData(key: 'public_key');
    String? privateKey = CashNetwork.getCashData(key: 'public_key');
    if ((publicKey == null || publicKey.isEmpty) ||
        (privateKey == null || privateKey.isEmpty)) {
      print('generate new keys');
      final keyPair = await RSA.generate(2048);
      publicKey = keyPair.publicKey;
      privateKey = keyPair.privateKey;
      print('the public key is => $publicKey');
      print('the private key is => $privateKey');
      CashNetwork.insertToCash(key: 'public_key', value: publicKey);
      CashNetwork.insertToCash(key: 'private_key', value: privateKey);
    } else {
      print('already have keys');
      print('the public key is => $publicKey');
      print('the private key is => $privateKey');
    }
  }

  Future<void> initState({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 2));
    print('starting');
    // checkLoginStatus(context: context);
    await generateKeys();
    emit(SplashLoginState(isLogIn: false));
  }

  Future<void> checkLoginStatus({required BuildContext context}) async {
    try {
      String? token = CashNetwork.getCashData(key: 'token');

      if (token.isEmpty) {
        print('check state is => Don\'t found a token');
        // await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoginState(isLogIn: false));
      } else {
        String? isVerified = CashNetwork.getCashData(key: 'is_verified');
        if (isVerified == 'false') {
          emit(SplashLoginState(isLogIn: false));
          return;
        }
        print('check state is => found a token : $token');
        // await Future.delayed(const Duration(seconds: 2));
        emit(SplashLoginState(isLogIn: true));
      }
    } catch (e) {
      print(e);
    }
  }
}
