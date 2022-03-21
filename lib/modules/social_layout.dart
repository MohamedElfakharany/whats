import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhatsCubit, WhatsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Feed'),
          ),
          body: ConditionalBuilder(
            condition: WhatsCubit.get(context).userModel != null,
            builder: (context) {
              var model = FirebaseAuth.instance.currentUser.emailVerified;
              return Column(
                children: [
                  if (!model)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline_rounded),
                            const SizedBox(
                              width: 15.0,
                            ),
                            const Expanded(
                                child: Text('Please verify your email')),
                            const SizedBox(
                              width: 15.0,
                            ),
                            defaultTextButton(
                              function: () {
                                try {
                                  FirebaseAuth.instance.currentUser
                                      .sendEmailVerification();
                                  showToast(
                                      msg: 'check your mail',
                                      state: ToastState.SUCCESS);
                                } catch (error) {
                                  if (kDebugMode) {
                                    print(error.toString());
                                  }
                                }
                              },
                              data: 'send',
                              color2: Colors.lightBlue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Text('welcome'),
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
