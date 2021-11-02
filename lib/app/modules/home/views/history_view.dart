import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HistoryView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
