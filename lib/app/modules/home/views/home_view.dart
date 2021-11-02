import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/views/history_view.dart';
import 'package:rantangan_app/app/modules/home/views/profile_view.dart';
import 'package:rantangan_app/app/modules/home/views/vendorlist_view.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final LoginController loginC = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.index,
            children: [
              VendorlistView(),
              HistoryView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: controller.index,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            controller.updateIndex(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.inbox_outlined),
              title: Text('History'),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.account_box_outlined),
              title: Text('Profile'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }
}
