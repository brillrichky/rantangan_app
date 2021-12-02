import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class MyOrderModel {
  Customer customer;
  Vendor vendor;
  Meal meal;
  String orderId;
  DateTime subStart;
  DateTime subEnd;
  String extraNotes;
  var status;

  MyOrderModel({
    this.subEnd,
    this.subStart,
    this.orderId,
    this.customer,
    this.vendor,
    this.meal,
    this.extraNotes,
    this.status,
  });

  MyOrderModel.fromMap(Map<String, dynamic> data) {
    customer = Customer.fromMap(data["customer"]);
    vendor = Vendor.fromMap(data["vendor"]);
    meal = Meal.fromMap(data["meal"]);
    orderId = data["orderId"];
    subStart = (data["details"]["subStart"] as Timestamp).toDate();
    subEnd = (data["details"]["subEnd"] as Timestamp).toDate();
    extraNotes = data["details"]["extraNotes"];
    status = data["details"]["status"];
  }
}

class Customer {
  String id;
  String name;
  String phone;
  GeoPoint pos;
  String address;

  Customer({
    this.id,
    this.name,
    this.phone,
    this.pos,
    this.address,
  });

  Customer.fromMap(Map<String, dynamic> data) {
    id = data["userId"];
    name = data["userName"];
    phone = data["userPhone"];
    pos = data["userPos"];
    _convertGeotoAddress(pos);
  }

  void _convertGeotoAddress(GeoPoint pos) async {
    try {
      List<Placemark> listPlaceMarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      Placemark place = listPlaceMarks[0];
      address = "${place.street}, ${place.subLocality}";
    } catch (e) {
      address = "ERROR";
      print(e);
    }
  }
}

class Vendor {
  String id;
  String name;
  String phone;
  GeoPoint pos;
  String address;

  Vendor({
    this.id,
    this.name,
    this.phone,
    this.pos,
    this.address,
  });

  Vendor.fromMap(Map<String, dynamic> data) {
    id = data["vendorId"];
    name = data["vendorName"];
    phone = data["vendorPhone"];
    pos = data["vendorPos"];
    _convertGeotoAddress(pos);
  }

  void _convertGeotoAddress(GeoPoint pos) async {
    try {
      List<Placemark> listPlaceMarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      Placemark place = listPlaceMarks[0];
      address = "${place.street}, ${place.subLocality}";
    } catch (e) {
      address = "ERROR";
      print(e);
    }
  }
}

class Meal {
  String id;
  String name;
  String price;

  Meal({
    this.id,
    this.name,
    this.price,
  });

  Meal.fromMap(Map<String, dynamic> data) {
    id = data["mealId"];
    name = data["mealName"];
    price = data["mealPrice"];
  }
}
