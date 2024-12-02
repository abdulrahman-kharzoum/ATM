import 'package:atm/cubits/register_cubit/register_cubit.dart';
import 'package:atm/widgets/auth/register_mobile_widget%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/validate_input.dart';
import '../../themes/color.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  void _closeLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final validator = Validate(context: context);
    final loginCubit = context.read<RegisterCubit>();
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool showPassword = state is ShowRegisterPassword ? state.show : true;
        return Scaffold(
          backgroundColor: AppColors.dark,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.dark,
            toolbarHeight: 1,
          ),
          body: Stack(
            children: [
              Positioned(
                right: mediaQuery.width / 30,
                top: 3,
                child: Opacity(
                  opacity: 0.08,
                  child: const Image(
                    image: AssetImage('assets/images/circles.png'),
                  ),
                ),
              ),
              Positioned(
                left: mediaQuery.width / 30,
                bottom: mediaQuery.height / 20,
                child: Opacity(
                  opacity: 0.08,
                  child: const Image(
                    image: AssetImage('assets/images/circles.png'),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.height / 20),
                child: RegisterMobileWidget(
                    registerCubit: loginCubit,
                    validator: validator,
                    showPassword: showPassword),
              ).animate().fade(
                    duration: const Duration(milliseconds: 500),
                  ),
            ],
          ),
        );
      },
    );
  }
}
