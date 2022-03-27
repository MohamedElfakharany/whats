import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/modules/settings/edit_profile.dart';
import 'package:whats/shared/components/components.dart';
import 'package:whats/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhatsCubit, WhatsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = WhatsCubit.get(context).userModel;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 270,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.all(8.0),
                          elevation: 5,
                          child: CachedNetworkImage(
                            imageUrl: userModel.imageCover,
                            fit: BoxFit.cover,
                            height: 200,
                            placeholder: (context, url) => const SizedBox(
                              child: CircularProgressIndicator(),
                              height: 60.0,
                              width: 60.0,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 68,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65.0),
                        child: CachedNetworkImage(
                          imageUrl: userModel.imageProfile,
                          placeholder: (context, url) => const SizedBox(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: 130,
                          height: 130,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userModel.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                userModel.bio,
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('100',
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('Posts',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('256',
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('Photos',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('10K',
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('Followers',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text('93',
                                style: Theme.of(context).textTheme.titleLarge),
                            Text('Following',
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        child: const Text(
                          'Add Photo',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 25,
                      ),
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
