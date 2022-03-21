import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/models/user_model.dart';
import 'package:whats/shared/network/local/constants.dart';

class WhatsCubit extends Cubit<WhatsStates> {
  WhatsCubit() : super(WhatsInitialState());

  static WhatsCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    try {
      emit(WhatsGetUserLoadingState());
      var response =
          await FirebaseFirestore
              .instance
              .collection('users')
              .doc(uId)
              .get();
      userModel = UserModel.fromJson(response.data());
      emit(WhatsGetUserSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(WhatsGetUserErrorState(error.toString()));
    }
  }
}
