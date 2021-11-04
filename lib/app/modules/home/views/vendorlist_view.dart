import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/routes/app_pages.dart';

class VendorlistView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
          padding: const EdgeInsets.all(10),
          children: controller.vendors.map((VendorModel vendor) {
            return SingleVendorWidget(
              vendor: vendor,
            );
          }).toList()),
    );
  }
}

class SingleVendorWidget extends GetView<HomeController> {
  final LoginController loginC = Get.find();
  final VendorModel vendor;
  SingleVendorWidget({Key key, this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.STORE, arguments: vendor);
        },
        child: Container(
          height: context.height * 0.4,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.store,
                      size: 50,
                    ),
                    title: Text(vendor.name),
                    subtitle: Text(vendor.address),
                    trailing: Icon(Icons.arrow_right),
                    isThreeLine: true,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: vendor.imageurl.isEmpty
                          ? AssetImage(
                              'assets/images/placeholder-restaurant.png')
                          : NetworkImage(vendor.imageurl),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
