import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart'; // Add this import for GlobalKey<FormState>
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool _showPassword = false;


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void toggleShowPassword(bool show) {
    _showPassword = show;
    emit(ShowPassword(_showPassword));
  }

  void validateLogin({required String username, required String password}) {
    emit(LoginLoading());

    if (username.isEmpty) {
      emit(LoginFailure(errorMessage: "Please enter your username."));
    } else if (password.isEmpty) {
      emit(LoginFailure(errorMessage: "Please enter your PIN."));
    } else if (password.length != 4 || !RegExp(r'^\d+$').hasMatch(password)) {
      emit(LoginFailure(errorMessage: "PIN must be a 4-digit number."));
    } else {
      emit(LoginSuccess());
    }
  }
}