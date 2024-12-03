import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/functions/validate_input.dart';
import '../../cubits/auth/login/login_cubit.dart';
import '../../themes/color.dart';
import '../custom_text_fields/custom_text_field.dart';


class LoginWebWidget extends StatelessWidget {
  const LoginWebWidget({
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
          child: SizedBox(
            width: mediaQuery.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: mediaQuery.height / 90),
                Container(
                  width: mediaQuery.width / 3,
                  padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.width / 50,
                    vertical: mediaQuery.height / 90,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 51, 55),
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: mediaQuery.height / 90),
                      SizedBox(
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: mediaQuery.height / 6,
                        ),
                      ),
                      SizedBox(
                        width: mediaQuery.width / 3,
                        child: CustomFormTextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: loginCubit.usernameController,
                          colorIcon: Colors.grey,
                          hintText: 'username',
                          nameLabel: 'Username',
                          validator: validator.validateUsername,
                        ),
                      ),
                      SizedBox(height: mediaQuery.height / 50),
                      SizedBox(
                        width: mediaQuery.width / 3,
                        child: CustomFormTextField(
                          obscureText: showPassword,
                          keyboardType: TextInputType.text,
                          controller: loginCubit.passwordController,
                          icon: showPassword ? Icons.visibility_off : Icons.visibility,
                          colorIcon: Colors.grey,
                          hintText: '****',
                          nameLabel: 'Password',
                          onPressedIcon: () {
                            BlocProvider.of<LoginCubit>(context).toggleShowPassword(!showPassword);
                          },
                          validator: validator.validatePassword,
                        ),
                      ),
                      SizedBox(height: mediaQuery.height / 40),
                      SizedBox(
                        width: mediaQuery.width / 3,
                        height: mediaQuery.height / 15,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (loginCubit.formKey.currentState!.validate()) {
                              print(loginCubit.usernameController.text.toString());
                              print(loginCubit.passwordController.text.toString());
                              await loginCubit.login(context: context);
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: mediaQuery.width / 80,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.height / 60),
                      SizedBox(
                        width: mediaQuery.width / 3,
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
                              fontSize: mediaQuery.width / 80,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery.height / 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
