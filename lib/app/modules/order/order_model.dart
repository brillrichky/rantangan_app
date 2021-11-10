import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String vendorId;
  String orderId;
  DateTime dateStart;
  DateTime dateEnd;
  String chargeBill;
  String userPhone;
  String vendorPhone;
  GeoPoint userPos;
  GeoPoint vendorPos;
  List<String> tags;

  UserModel({
    this.userId,
    this.vendorId,
    this.orderId,
    this.dateEnd,
    this.dateStart,
    this.chargeBill,
    this.tags,
    this.userPhone,
    this.userPos,
    this.vendorPhone,
    this.vendorPos,
  });
}

  // User.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   age = json['age'];
  //   friends = json['friends'].cast<String>();
  // }

  // Map<String, dynamic> toJson() {
  //   final data = <String, dynamic>{};
  //   data['name'] = name;
  //   data['age'] = age;
  //   data['friends'] = friends;
  //   return data;
  // }
