import 'package:atm/core/dialogs.dart';
import 'package:atm/cubits/register_cubit/register_cubit.dart';
import 'package:atm/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/validate_input.dart';
import '../custom_text_fields/custom_text_field.dart';

class RegisterMobileWidget extends StatelessWidget {
  const RegisterMobileWidget({
    super.key,
    required this.registerCubit,
    required this.validator,
    required this.showPassword,
  });

  final RegisterCubit registerCubit;
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
          key: registerCubit.formKey,
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
              Text(
                'Register',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: mediaQuery.width / 15),
              ),
              SizedBox(height: mediaQuery.height / 50),

              CustomFormTextField(
                keyboardType: TextInputType.text,
                controller: registerCubit.usernameController,
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
                controller: registerCubit.passwordController,
                icon: showPassword ? Icons.visibility_off : Icons.visibility,
                colorIcon: Colors.grey,
                hintText: '****',
                nameLabel: 'Password',
                onPressedIcon: () {
                  BlocProvider.of<RegisterCubit>(context)
                      .toggleShowPassword(!showPassword);
                },
                validator: validator.validatePassword,
              ),

              SizedBox(height: mediaQuery.height / 10),
              // Login Button
              SizedBox(
                width: mediaQuery.width/2 ,
                height: 60,
                // height: mediaQuery.height / 25,
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterLoadingState) {
                      loadingDialog(
                          context: context,
                          mediaQuery: mediaQuery,
                          title: 'Loading...');
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (registerCubit.formKey.currentState!.validate()) {
                          print(
                              registerCubit.usernameController.text.toString());
                          print(
                              registerCubit.passwordController.text.toString());
                          await registerCubit.register(context: context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          // minimumSize: Size(mediaQuery.width /50, 100)
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: mediaQuery.width / 25,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: mediaQuery.height / 6),
              // Register Button
            ],
          ),
        ),
      ),
    );
  }
}
