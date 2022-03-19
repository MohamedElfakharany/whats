import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/modules/auth/register/cubit/states.dart';

class WhatsRegisterCubit extends Cubit<WhatsRegisterStates> {
  WhatsRegisterCubit() : super(WhatsRegisterInitialState());

  static WhatsRegisterCubit get(context) => BlocProvider.of(context);

  Future register({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) async {
    try {
      emit(WhatsRegisterLoadingState());
      var response = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    } catch (error) {
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
    emit(WhatsRegisterchangePasswordVisibilityState());
  }
}
