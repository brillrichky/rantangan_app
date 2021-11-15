import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserModel {
  String id;
  String name;
  String email;
  String address;
  String phone;
  GeoPoint position;

  UserModel({
    this.name,
    this.id,
    this.email,
    this.phone,
    this.address,
    this.position,
  });

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.data()["id"];
    email = snapshot.data()["email"];
    name = snapshot.data()["name"];
    phone = snapshot.data()["phone"];
    position = snapshot.data()["position"];
    _convertGeotoAddress(position);
    print(snapshot.data().toString());
  }

  void _convertGeotoAddress(GeoPoint pos) async {
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

  void _convertPostoAddress(Position pos) async {
    try {
      List<Placemark> listPlaceMarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      Placemark place = listPlaceMarks[0];
      position = GeoPoint(pos.latitude, pos.longitude);
      address =
          "${place.street}, ${place.administrativeArea}, ${place.subAdministrativeArea}";
    } catch (e) {
      address = "ERROR";
      print(e);
    }
  }

  void setAddress() async {
    Position currentPos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await _convertPostoAddress(currentPos);
    print(address);
    print(currentPos.toString());
  }

  void updateUser(String name) {
    this.name = name;
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
}
