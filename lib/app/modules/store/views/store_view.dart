import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StoreView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StoreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
