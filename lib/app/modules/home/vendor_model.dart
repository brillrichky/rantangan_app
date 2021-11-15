import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_food_delivery/models/mealModel.dart';

class VendorModel {
  String id;
  String name;
  String email;
  GeoPoint position;
  String address;
  String imageurl;
  String phone;

  VendorModel({
    this.id,
    this.name,
    this.email,
    this.position,
    this.address,
    this.imageurl,
    this.phone,
  });

  // VendorModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   id = snapshot.data()["id"];
  //   name = snapshot.data()["name"];
  //   email = snapshot.data()["email"];
  //   position = snapshot.data()["position"];
  //   convertPostoAddress(position);
  // }

  VendorModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    name = data["name"];
    email = data["email"];
    position = data["position"];
    imageurl = data["imageURL"];
    phone = data["phone"];
    _convertPostoAddress(position);
  }

  void _convertPostoAddress(GeoPoint pos) async {
    try {
      List<Placemark> listPlaceMarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      Placemark place = listPlaceMarks[0];
      address =
          "${place.street}, ${place.administrativeArea}, ${place.subAdministrativeArea}";
    } catch (e) {
      address = "ERROR";
      print(e);
    }
  }
}
