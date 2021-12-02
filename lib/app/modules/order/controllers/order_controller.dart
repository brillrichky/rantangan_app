import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/modules/store/controllers/store_controller.dart';
import 'package:rantangan_app/app/modules/store/mealplan_model.dart';

class OrderController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginController loginC = Get.find();
  StoreController storeC = Get.find();
  MealPlanModel mealplan;

  Rx<bool> isDateNull = true.obs;

  TextEditingController extraNotes = TextEditingController();
  Rx<DateTime> startSub = DateTime.now().obs;
  DateTime endSub = null;

  @override
  void onInit() {
    mealplan = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void orderValidator() {
    if (isDateNull.isTrue) {
      Get.snackbar("Gagal!", "Pilih tanggal yang sesuai!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else if (isDistanceValid() == false) {
      Get.snackbar("Gagal!", "Jarak Terlalu Jauh!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } else {
      addOrder();
      Get.back();
    }
  }

  bool isDistanceValid() {
    double distance = distanceCalculator(
      loginC.userModel.value.position.latitude,
      loginC.userModel.value.position.longitude,
      storeC.vendor.position.latitude,
      storeC.vendor.position.longitude,
    );
    double maxrange = 15.0;
    return distance.isEqual(maxrange) || distance.isLowerThan(maxrange);
  }

  double distanceCalculator(
      double latA, double longA, double latB, double longB) {
    double distanceInMeters =
        Geolocator.distanceBetween(latA, longA, latB, longB);
    distanceInMeters = distanceInMeters / 1000;
    return distanceInMeters;
  }

  void addOrder() async {
    try {
      firestore.collection("orders").add({
        "customer": {
          "userId": loginC.userModel.value.id,
          "userName": loginC.userModel.value.name,
          "userPhone": loginC.userModel.value.phone,
          "userPos": GeoPoint(
            loginC.userModel.value.position.latitude,
            loginC.userModel.value.position.longitude,
          ),
        },
        "vendor": {
          "vendorId": storeC.vendor.id,
          "vendorName": storeC.vendor.name,
          "vendorPos": GeoPoint(
            storeC.vendor.position.latitude,
            storeC.vendor.position.longitude,
          ),
          "vendorPhone": storeC.vendor.phone,
        },
        "meal": {
          "mealId": mealplan.id,
          "mealName": mealplan.name,
          "mealPrice": mealplan.price,
        },
        "details": {
          "subStart": startSub.value,
          "subEnd": startSub.value.add(Duration(days: 7)),
          "extraNotes": "${extraNotes.text}",
          "status": 0,
        }
      }).then((value) {
        _insertOrderId(value.id);
        print("Sukses add OrderId");
        Get.snackbar("SUKSES!", "Tunggu konfirmasi dari Penjual!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      });
    } catch (e) {
      return print("Error");
    }
  }

  void _insertOrderId(var id) async {
    try {
      firestore.collection("orders").doc(id).update({
        "orderId": id,
      }).then((value) {
        print("Sukses Insert OrderId");
      });
    } catch (e) {
      return print("Error");
    }
  }
}
