import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:whats/bloc_observer.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/modules/auth/login/cubit/cubit.dart';
import 'package:whats/modules/auth/login/login_screen.dart';
import 'package:whats/modules/auth/register/cubit/cubit.dart';
import 'package:whats/modules/social_layout.dart';
import 'package:whats/shared/network/local/cache_helper.dart';
import 'package:whats/shared/network/local/constants.dart';
import 'package:whats/shared/styles/themes.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
    () {
      initializeDateFormatting().then((_) => runApp(MyApp(
            startWidget: widget,
          )));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({
    this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => WhatsCubit()..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => WhatsLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => WhatsRegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
