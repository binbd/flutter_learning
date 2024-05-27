import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

bool isValidEmailFormat(String email) {
  final emailRegex = RegExp(
  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$', 
  caseSensitive: false,
  );
  return emailRegex.hasMatch(email);
}

enum PasswordStrength { weak, fair, strong }

PasswordStrength checkPasswordStrength(String password) {
  final lengthRequirement = RegExp(r'.{8,}'); // At least 8 characters
  final uppercaseRequirement = RegExp(r'[A-Z]');
  final lowercaseRequirement = RegExp(r'[a-z]');
  final numberRequirement = RegExp(r'[0-9]');
  final specialCharRequirement = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool hasUppercase = uppercaseRequirement.hasMatch(password);
  bool hasLowercase = lowercaseRequirement.hasMatch(password);
  bool hasNumber = numberRequirement.hasMatch(password);
  bool hasSpecialChar = specialCharRequirement.hasMatch(password);
  bool hasMinLength = lengthRequirement.hasMatch(password);

  if (hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar) {
    return PasswordStrength.strong;
  } else if (hasMinLength && (hasUppercase || hasLowercase) && (hasNumber || hasSpecialChar)) {
    return PasswordStrength.fair;
  } else {
    return PasswordStrength.weak;
  }
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final List<String> reasons = ["Dev is ill", "Dev is out","Dev is missing"];
  final Random random = Random();
  
  String _name ="";
  String _email ="";
  String _password = "";

  set name(String name) {
    _name = name;
  }

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  void signUpWithGithub()
  {
    //can't signup
    //emit(SignUpFailedState(provider: "GitHub",reason: reasons[random.nextInt(reasons.length)]));
    //emit(SignUpFailedState(provider: "Github",reason: "Github sign up is not supported"));
    emit(SignUpWithGithubState());
  }

  void signUpwithGoogle()
  {
    //emit(SignUpFailedState(provider: "Google", reason: reasons[random.nextInt(reasons.length)]));
    emit(SignUpWithGoogleState());
  }

  void signUpName()
  {
    //emit(SignUpFailedState(provider: "Name", reason: "must not be empty"));
    if(_name.isEmpty) {
      emit(SignUpFailedState(provider: "Name", reason: "Must noe be empty"));
    }
  }

  void signUpEmail()
  {
    if(_email.isEmpty){
      emit(SignUpFailedState(provider: "Email", reason: "must not be empty"));
    }
    
  }

  void signUpPassword()
  {
    if(_password.isEmpty){
      emit(SignUpFailedState(provider: "Password", reason: "must not be empty"));
    }
    
  }

  void signUpSuccessful()
  {
    emit(SignUpSuccessState(provider: "SignUp",text: "success"));
  }

  void signUp(){
    if(_name.isEmpty) {
      emit(SignUpFailedState(provider: "Name", reason: "Must noe be empty"));
    }
    else if(_email.isEmpty){
      emit(SignUpFailedState(provider: "Email", reason: "must not be empty"));
    }
    else if(_password.isEmpty){
      emit(SignUpFailedState(provider: "Password", reason: "must not be empty"));
    }
    else {
      //check the email & password validity here
      if(!isValidEmailFormat(_email))
      {
        emit(SignUpInvalidEmail());
      }
      else if(checkPasswordStrength(_password) == PasswordStrength.weak)
      {
        emit(SignUpInvalidPassword());
      }
      else{
        signUpSuccessful();
      }
      
    }
      
  }


}
