import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  Rx<bool> isFishSelected = false.obs;
  Rx<bool> isPeanutSelected = false.obs;
  Rx<bool> isMilkSelected = false.obs;

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
      Get.snackbar("GAGAL", "GAGAL");
    } else {
      addOrder();
    }
  }

  void addOrder() async {
    try {
      firestore.collection("orders").add({
        "userId": loginC.userModel.value.id,
        "vendorId": storeC.vendor.id,
        "mealId": mealplan.id,
        "subStart": startSub.value,
        "subEnd": startSub.value.add(Duration(days: 7)),
        "vendorPhone": storeC.vendor.phone,
        "userPhone": loginC.userModel.value.phone,
        "mealPrice": mealplan.price,
        "extraNotes": extraNotes.text.trim(),
        "isConfirmed": false,
        "isCancelled": false,
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
