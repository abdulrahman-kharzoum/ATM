part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class ShowRegisterPassword extends RegisterState {
  final bool show;
  ShowRegisterPassword(this.show);
}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterFailedState extends RegisterState {
  final String errorMessage;
  RegisterFailedState({required this.errorMessage});
}
