import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class MyOrderModel {
  String userId;
  String vendorId;
  String orderId;
  String mealId;
  var subStart;
  var subEnd;
  String mealPrice;
  String userPhone;
  String vendorPhone;
  String extraNotes;
  bool isConfirmed;
  bool isCancelled;

  MyOrderModel({
    this.mealPrice,
    this.mealId,
    this.subEnd,
    this.subStart,
    this.orderId,
    this.userId,
    this.userPhone,
    this.vendorId,
    this.vendorPhone,
    this.extraNotes,
    this.isConfirmed,
    this.isCancelled,
  });

  MyOrderModel.fromMap(Map<String, dynamic> data) {
    userId = data["userId"];
    vendorId = data["vendorId"];
    mealId = data["mealId"];
    orderId = data["orderId"];
    subStart = (data["subStart"] as Timestamp).toDate();
    subEnd = (data["subStart"] as Timestamp).toDate();
    mealPrice = data["mealPrice"];
    userPhone = data["userPhone"];
    vendorPhone = data["vendorPhone"];
    extraNotes = data["extraNotes"];
    isConfirmed = data["isConfirmed"];
    isCancelled = data["isCancelled"];
  }
}
