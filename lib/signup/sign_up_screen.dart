import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/signup/bloc/cubit/sign_up_cubit.dart';

import '../gen/assets.gen.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(), child: const _HomeContent()),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.assest.images.female
                        .image(width: 88, height: 88),
                  ),
                  const Text("Create Account with",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // BlocListener<SignUpCubit, SignUpState>(
                      //   listener: (context, state) {
                      //     if (state is SignUpFailedState) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //               content: Text("Github signup is not supported")));
                      //     }
                      //   },
                      //   child: AccountHolder(
                      //     imagePath: Assets.assest.images.github.path,
                      //     onTap: () =>
                      //         {context.read<SignUpCubit>().signUpWithGithub()},
                      //   ),
                      // ),
                      AccountHolder(
                          imagePath: Assets.assest.images.github.path,
                          onTap: () =>
                              {context.read<SignUpCubit>().signUpWithGithub()},
                        ),
                      AccountHolder(
                              imagePath: Assets.assest.images.google.path,
                              onTap: ()=>{
                                context.read<SignUpCubit>().signUpwithGoogle()
                              },),
                      AccountHolder(
                          imagePath: Assets.assest.images.linkedin.path),
                    ],
                  ),
                  // BlocSelector<SignUpCubit, SignUpState, String?>(
                  //       selector: (state) {
                  //         if(state is SignUpFailedState) {
                  //           if (kDebugMode) {
                  //             print('Reason? ${state.reason}');
                  //           }
                  //           return state.provider;
                  //         }
                  //         return null;
                  //       },
                  //       builder: (context, state) {
                  //         print('Update???'); //tai sao cua minh lai thay doi
                  //         if(state == null) {
                  //           return const SizedBox.shrink();
                  //         }
                  //         return Text("Unable to loggin with $state");
                  //       },
                  //     ),
                  // BlocBuilder<SignUpCubit, SignUpState>(
                  //   buildWhen: (previous, current) => previous.runtimeType != current.runtimeType || 
                  //   (current is SignUpFailedState && previous is SignUpFailedState && previous.provider != current.provider),
                  //   builder: (context, state) {
                  //     if(state is SignUpFailedState){
                  //       if (kDebugMode) {
                  //         print('Reload???');
                  //       }
                  //       return Text("Unable to loggin with ${state.provider}");
                  //     }

                  //     return const SizedBox.shrink();
                  //   },
                  // ),
                  BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if(state is SignUpFailedState && state.provider == 'Github')
                      {
                               ScaffoldMessenger.of(context).showSnackBar(
                                 const SnackBar(
                                     content: Text("Github signup is not supported")));
                           
                      }
                    },
                    builder: (context, state) {
                      if(state is SignUpFailedState && state.provider == 'Google')
                      {
                        return const Text("Google signup is not supported");
                      }
                      
                      return Container();
                    },
                  ),
                  const Text("Or",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                  IconTextField(
                      imagePath: Assets.assest.images.user.path,
                      hintText: "Name"),
                  IconTextField(
                      imagePath: Assets.assest.images.email.path,
                      hintText: "Email"),
                  IconTextField(
                      imagePath: Assets.assest.images.password.path,
                      hintText: "Password"),
                  TextButton(onPressed: () {}, child: const Text("Signup")),
                  const Text("Or",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Color.fromRGBO(02, 37, 68, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class AccountHolder extends StatelessWidget {
  const AccountHolder({
    required this.imagePath,
    this.onTap,
    super.key,
  });
  final String imagePath;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 40,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(2, 2)),
            ]),
        margin: const EdgeInsets.all(8),
        child: Image.asset(
          imagePath,
          width: 43,
          height: 43,
        ),
      ),
    );
  }
}

class IconTextField extends StatelessWidget {
  const IconTextField({required this.imagePath, this.hintText, super.key});
  final String imagePath;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 40),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8.0),
                  hintText: hintText),
            ),
          )),
        ],
      ),
    );
  }
}
