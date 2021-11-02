import 'package:flutter/material.dart';

import 'package:get/get.dart';

class VendorlistView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VendorlistView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'VendorlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
