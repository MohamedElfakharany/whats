import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/states.dart';

class WhatsCubit extends Cubit<WhatsStates> {
  WhatsCubit() : super(WhatsInitialState());

  static WhatsCubit get(context) => BlocProvider.of(context);

  Future login({
    @required String email,
    @required String password,
    String lang = 'en',
    String token,
  }) async {
    try {
      emit(WhatsLoginLoadingState());
    } catch (e) {
      emit(WhatsLoginErrorState(e.toString()));
    }
  }

  Future register({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) async {
    try {
      var response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print(response.user.email);
      }
      if (kDebugMode) {
        print(response.user.uid);
      }
      emit(WhatsRegisterSuccessState());
    }catch(error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(WhatsRegisterErrorState(error.toString()));
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(WhatsChangePasswordVisibilityState());
  }
}
