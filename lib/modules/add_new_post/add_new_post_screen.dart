import 'package:flutter/material.dart';

class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'AddNewPostScreen',
        ),
      ),
    );
  }
}
