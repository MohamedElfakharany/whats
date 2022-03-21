import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whats/modules/auth/register/cubit/cubit.dart';
import 'package:whats/modules/auth/register/cubit/states.dart';
import 'package:whats/modules/social_layout.dart';
import 'package:whats/shared/components/components.dart';
import 'package:whats/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => WhatsRegisterCubit(),
      child: BlocConsumer<WhatsRegisterCubit, WhatsRegisterStates>(
        listener: (context, state) {
          if (state is WhatsRegisterErrorState) {
            showToast(
              msg: state.error.toString(),
              state: ToastState.ERROR,
            );
          }
          if (state is WhatsRegisterSuccessState) {
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
          if (state is WhatsCreateUserErrorState) {
            showToast(msg: state.error, state: ToastState.ERROR);
          }
          if (state is WhatsRegisterErrorState) {
            showToast(msg: state.error, state: ToastState.ERROR);
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
                        'REGISTER',
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
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_iphone),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Phone';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
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
                            return 'Please Enter Valide Email Address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: WhatsRegisterCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(
                              WhatsRegisterCubit.get(context).suffix,
                            ),
                            onPressed: () {
                              WhatsRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (value) {
                          WhatsRegisterCubit.get(context).register(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password is Empty';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! WhatsRegisterLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              WhatsRegisterCubit.get(context).register(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
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
