import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';

class ProfileView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ProfileView'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout))),
      body: Center(
        child: Text(
          'ProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
