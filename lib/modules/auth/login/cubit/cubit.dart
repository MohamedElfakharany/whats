import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/modules/auth/login/cubit/states.dart';

class WhatsLoginCubit extends Cubit<WhatsLoginStates> {
  WhatsLoginCubit() : super(WhatsLoginInitialState());

  static WhatsLoginCubit get(context) => BlocProvider.of(context);

  Future login({
    @required String email,
    @required String password,
    String lang = 'en',
    String token,
  }) async {
    try {
      emit(WhatsLoginLoadingState());
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(response.user.email);
      print(response.user.uid);
      emit(WhatsLoginSuccessState());
    } catch (e) {
      print(e.toString());
      emit(WhatsLoginErrorState(e.toString()));
    }
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void WhatsLoginchangePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginchangePasswordVisibilityState());
  }
}
