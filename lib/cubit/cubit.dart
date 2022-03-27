import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/models/user_model.dart';
import 'package:whats/modules/add_new_post/add_new_post_screen.dart';
import 'package:whats/modules/chat/chats_screen.dart';
import 'package:whats/modules/home/home_screen.dart';
import 'package:whats/modules/settings/settings_screen.dart';
import 'package:whats/modules/users/users_screen.dart';
import 'package:whats/shared/network/local/constants.dart';

class WhatsCubit extends Cubit<WhatsStates> {
  WhatsCubit() : super(WhatsInitialState());

  static WhatsCubit get(context) => BlocProvider.of(context);
  UserModel userModel;

  void getUserData() async {
    try {
      emit(WhatsGetUserLoadingState());
      var response =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      userModel = UserModel.fromJson(response.data());
      emit(WhatsGetUserSuccessState());
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(WhatsGetUserErrorState(error.toString()));
    }
  }

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const HomeScreen(),
    const ChatsScreen(),
    const AddNewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];
  List<String> titles = [
    'News Feed',
    'Chats Screen',
    'AddNewPost Screen',
    'Users Screen',
    'Settings Screen',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(WhatsAddNewPostState());
    } else {
      currentIndex = index;
      emit(WhatsChangeBottomNavState());
    }
  }

  File profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    try {
      XFile pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        profileImage = File(pickedImage.path);
        emit(WhatsProfileImagePickedSuccessState());
      } else {
        if (kDebugMode) {
          print('no image selected');
        }
        emit(WhatsProfileImagePickedErrorState());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
