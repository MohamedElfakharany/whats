import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/modules/auth/login/cubit/cubit.dart';
import 'package:whats/modules/auth/login/cubit/states.dart';
import 'package:whats/modules/auth/register/register_screen.dart';
import 'package:whats/modules/social_layout.dart';
import 'package:whats/shared/components/components.dart';
import 'package:whats/shared/network/local/cache_helper.dart';
import 'package:whats/shared/network/local/constants.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => WhatsLoginCubit(),
      child: BlocConsumer<WhatsLoginCubit, WhatsLoginStates>(
        listener: (context, state) {
          if (state is WhatsLoginErrorState) {
            showToast(
              msg: state.error.toString(),
              state: ToastState.ERROR,
            );
          }
          if (state is WhatsLoginSuccessState) {
            try {
              CacheHelper.saveData(key: 'uId', value: state.uId);
              navigateAndFinish(
                context,
                const SocialLayout(),
              );
            } catch (error) {
              if (kDebugMode) {
                print(error.toString());
              }
            }
          }
        },
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
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: WhatsLoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              WhatsLoginCubit.get(context).suffix,
                            ),
                            onPressed: () {
                              WhatsLoginCubit.get(context)
                                  .WhatsLoginChangePasswordVisibility();
                            },
                          ),
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password is too short';
                          }
                        },
                        onFieldSubmitted: (value) {
                          WhatsLoginCubit.get(context).login(
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
                                WhatsLoginCubit.get(context).login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
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
