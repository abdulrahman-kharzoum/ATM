import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/functions/validate_input.dart';
import '../../cubits/auth/login/login_cubit.dart';
import '../custom_text_fields/custom_text_field.dart';

class LoginMobileWidget extends StatelessWidget {
  const LoginMobileWidget({
    super.key,
    required this.loginCubit,
    required this.validator,
    required this.showPassword,
  });

  final LoginCubit loginCubit;
  final Validate validator;
  final bool showPassword;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: mediaQuery.height,
      ),
      child: IntrinsicHeight(
        child: Form(
          key: loginCubit.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: mediaQuery.height / 9),
              // Logo
              SizedBox(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: mediaQuery.height / 5,
                ),
              ),
              SizedBox(height: mediaQuery.height / 50),
              CustomFormTextField(
                keyboardType: TextInputType.text,
                controller: loginCubit.usernameController,
                colorIcon: Colors.grey,
                hintText: 'username',
                nameLabel: 'Username',
                validator: validator.validateUsername,
              ),
              SizedBox(height: mediaQuery.height / 50),
              // Password Field
              CustomFormTextField(
                obscureText: showPassword,
                keyboardType: TextInputType.number,
                controller: loginCubit.passwordController,
                icon: showPassword ? Icons.visibility_off : Icons.visibility,
                colorIcon: Colors.grey,
                hintText: '****',
                nameLabel: 'Password',
                onPressedIcon: () {
                  BlocProvider.of<LoginCubit>(context)
                      .toggleShowPassword(!showPassword);
                },
                validator: validator.validatePassword,
              ),

              SizedBox(height: mediaQuery.height / 40),
              // Login Button
              SizedBox(
                width: mediaQuery.width,
                height: mediaQuery.height / 15,
                child: ElevatedButton(
                  onPressed: () async {
                    if (loginCubit.formKey.currentState!.validate()) {
                      await loginCubit.login(context: context);
                      print(loginCubit.usernameController.text.toString());
                      print(loginCubit.passwordController.text.toString());
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: mediaQuery.width / 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height / 60),
              // Register Button
              SizedBox(
                width: mediaQuery.width,
                height: mediaQuery.height / 15,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register_screen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQuery.width / 25,
                    ),
                  ),
                ),
              ),
              SizedBox(height: mediaQuery.height / 20),
              // Language Change Button

              SizedBox(height: mediaQuery.height / 20),
            ],
          ),
        ),
      ),
    );
  }
}
