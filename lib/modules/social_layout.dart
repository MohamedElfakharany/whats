import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/modules/add_new_post/add_new_post_screen.dart';
import 'package:whats/modules/notifications/notifications_screen.dart';
import 'package:whats/modules/search/search_screen.dart';
import 'package:whats/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhatsCubit, WhatsStates>(
      listener: (context, state) {
        if (state is WhatsAddNewPostState) {
          navigateTo(context, const AddNewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = WhatsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  navigateTo(context, const NotificationsScreen());
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, const SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_add_outlined),
                label: 'New Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle_sharp),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_applications_outlined),
                label: 'Settings',
              ),
            ],
          ),
          drawer: const Drawer(
            child: Center(
              child: Text('DRAWER'),
            ),
          ),
        );
      },
    );
  }
}

// Conditional Builder for Email verification

/*
ConditionalBuilder(
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
                ],
              );
            },
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          */
