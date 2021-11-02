import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RegisterView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RegisterViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
