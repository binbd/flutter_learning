import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final List<String> reasons = ["Dev is ill", "Dev is out","Dev is missing"];
  final Random random = Random();
  void signUpWithGithub()
  {
    //can't signup
    //emit(SignUpFailedState(provider: "GitHub",reason: reasons[random.nextInt(reasons.length)]));
    emit(SignUpFailedState(provider: "Github",reason: "Github sign up is not supported"));
  }

  void signUpwithGoogle()
  {
    emit(SignUpFailedState(provider: "Google", reason: reasons[random.nextInt(reasons.length)]));
  }

}
