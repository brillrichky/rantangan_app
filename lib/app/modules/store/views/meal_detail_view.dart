import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MealDetailView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MealDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MealDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
