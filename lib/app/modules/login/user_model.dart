import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String address;
  GeoPoint position;

  UserModel({
    this.name,
    this.id,
    this.address,
    this.position,
  });

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.data()["id"];
    email = snapshot.data()["email"];
    name = snapshot.data()["name"];
    position = snapshot.data()["position"];
    print(snapshot.data().toString());
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
