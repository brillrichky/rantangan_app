import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

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
    _convertPostoAddress(position);
    print(snapshot.data().toString());
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
