part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpFailedState extends SignUpState {
  final String provider;
  final String reason;

  SignUpFailedState({required this.provider,required this.reason});

}

final class SignUpWithGithubState extends SignUpState {

}

final class SignUpWithGoogleState extends SignUpState{

}

final class SignUpInvalidEmail extends SignUpState{

}

final class SignUpInvalidPassword extends SignUpState{

}



final class SignUpSuccessState extends SignUpState {
  final String provider;
  final String text;

  SignUpSuccessState({required this.provider,required this.text});

}