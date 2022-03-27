import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats/cubit/cubit.dart';
import 'package:whats/cubit/states.dart';
import 'package:whats/shared/components/components.dart';
import 'package:whats/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();

  EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WhatsCubit, WhatsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = WhatsCubit.get(context).userModel;
        var profileImage = WhatsCubit.get(context).profileImage;

        nameController.text = userModel.name;
        bioController.text = userModel.bio;
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Edit Profile', actions: [defaultTextButton(function: () {}, data: 'UPDATE'), const SizedBox(width: 10.0)]),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 270,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
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
                          CircleAvatar(
                            backgroundColor: defaultColor,
                            child: IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 68,
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(65.0),
                            child:  profileImage == null ?  CachedNetworkImage(
                              imageUrl: userModel.imageProfile,
                              placeholder: (context, url) => const SizedBox(
                                child: Center(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: 130,
                              height: 130,
                            ) : FileImage(profileImage),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: defaultColor,
                          child: IconButton(
                            onPressed: () {
                              WhatsCubit.get(context).getProfileImage();
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              defaultFormField(
                textController: nameController,
                textType: TextInputType.name,
                prefIcon: Icons.perm_identity,
                labelText: 'NAME',
                validatedText: 'name',
              ),
              defaultFormField(
                textController: bioController,
                textType: TextInputType.text,
                prefIcon: Icons.insert_drive_file_outlined,
                labelText: 'Bio ...',
                validatedText: 'bio',
              ),
            ],
          ),
        );
      },
    );
  }
}