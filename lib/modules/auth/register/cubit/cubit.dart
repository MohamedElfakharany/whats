import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/models/user_model.dart';
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
      createUser(
        uId: response.user.uid,
        email: email,
        phone: phone,
        name: name,
      );

    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(WhatsRegisterErrorState(error.toString()));
    }
  }

  Future createUser({
    @required String name,
    @required String phone,
    @required String email,
    @required String uId,
  }) async {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      isEmailVerified: false,
    );

    try {
      var response = await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toMap());
      emit(WhatsRegisterSuccessState(uId));
      emit(WhatsCreateUserSuccessState());
    } catch (error) {
      WhatsCreateUserErrorState(error.toString());
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
