import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class MyOrderModel {
  String userId;
  String vendorId;
  String orderId;
  var subStart;
  var subEnd;
  String mealPrice;
  String userPhone;
  String vendorPhone;
  String extraNotes;
  bool isConfirmed;

  MyOrderModel({
    this.mealPrice,
    this.subEnd,
    this.subStart,
    this.orderId,
    this.userId,
    this.userPhone,
    this.vendorId,
    this.vendorPhone,
    this.extraNotes,
    this.isConfirmed,
  });

  MyOrderModel.fromMap(Map<String, dynamic> data) {
    userId = data["userId"];
    vendorId = data["vendorId"];
    orderId = data["orderId"];
    subStart = (data["subStart"] as Timestamp).toDate();
    subEnd = (data["subStart"] as Timestamp).toDate();
    mealPrice = data["mealPrice"];
    userPhone = data["userPhone"];
    vendorPhone = data["vendorPhone"];
    extraNotes = data["extraNotes"];
    isConfirmed = data["isConfirmed"];
  }
}
