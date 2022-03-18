import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/modules/auth/register_screen.dart';
import 'package:whats/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => WhatsCubit(),
      child: BlocConsumer<WhatsCubit, WhatsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Login now to connect with friends',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please Enter True Email Address';
                          }
                          return '';
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: WhatsCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              WhatsCubit.get(context).suffix,
                            ),
                            onPressed: () {
                              WhatsCubit.get(context).changePasswordVisibility();
                            },
                          ),
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password is too short';
                          }
                          return '';
                        },
                        onFieldSubmitted: (value){
                          WhatsCubit.get(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! WhatsLoginLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            try {
                              if (formKey.currentState.validate()) {
                                WhatsCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                if (kDebugMode) {
                                  print(formKey.currentState.validate());
                                }
                              }
                              else{
                                if (kDebugMode) {
                                  print(formKey.currentState.validate());
                                }
                                if (kDebugMode) {
                                  print('mohamed');
                                }
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
                              }
                              if (kDebugMode) {
                                print('ali');
                              }
                            }
                          },
                          text: 'Login',
                          isUpperCase: true,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account..?!',
                          ),
                          defaultTextButton(
                            function: () {
                              navigateTo(context, RegisterScreen());
                            },
                            data: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}