import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/myorder_model.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/modules/login/user_model.dart';

class HomeController extends GetxController {
  LoginController loginC = Get.find();
  var tempId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  RxList<MyOrderModel> myOrders = RxList<MyOrderModel>([]);
  Position currentPos;

  final count = 0.obs;
  var index = 0;

  @override
  void onInit() {
    tempId = Get.arguments;
    print("INI TEMP ID = $tempId");
    vendors.bindStream(getAllVendors());
    super.onInit();
  }

  @override
  void onReady() async {
    myOrders.bindStream(getAllMyOrders());
    currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Future.delayed(Duration(seconds: 1)).then((value) => updatePage());
    super.onReady();
  }

  @override
  void onClose() {}

  void updateIndex(int a) {
    index = a;
    update();
  }

  void updatePage() {
    update();
  }

  double distanceCalculator(
      double latA, double longA, double latB, double longB) {
    double distanceInMeters =
        Geolocator.distanceBetween(latA, longA, latB, longB);
    distanceInMeters = distanceInMeters / 1000;
    return distanceInMeters;
  }

  Stream<List<VendorModel>> getAllVendors() {
    return firestore.collection("vendors").snapshots().map((query) {
      return query.docs.map((e) {
        //print("data Vendor ${e.data()}");
        return VendorModel.fromMap(e.data());
      }).toList();
    });
  }

  Stream<List<MyOrderModel>> getAllMyOrders() {
    return firestore
        .collection("orders")
        .where("customer.userId", isEqualTo: tempId)
        .orderBy("details.subEnd", descending: true)
        .snapshots()
        .map((query) {
      return query.docs.map((e) {
        print("data MyOrder ${e.data()}");
        return MyOrderModel.fromMap(e.data());
      }).toList();
    });
  }

  statusCondition(num a) {
    switch (a) {
      case 1:
        return Chip(
          label: Text(
            "Cancelled",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        );
        break;
      case 2:
        return Chip(
          label: Text(
            "Confirmed",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
        break;
      default:
        return Chip(
          label: Text("Waiting Confirmation"),
          backgroundColor: Colors.yellow,
        );
        break;
    }
  }

  colorCondition(num a) {
    switch (a) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.green;
      default:
        return Colors.yellow;
        break;
    }
  }
}
