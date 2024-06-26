part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpFailedState extends SignUpState {
  final String provider;
  final String reason;

  SignUpFailedState({required this.provider,required this.reason});

}
