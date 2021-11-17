import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/user_model.dart';
import 'package:rantangan_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Rx<User> firebaseUser;
  Rx<UserModel> userModel = UserModel().obs;
  Position currentPos;

  final count = 0.obs;
  String usersCollection = "users";

  @override
  void onInit() {
    getCurrentPos();
    super.onInit();
  }

  @override
  void onReady() async {
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  @override
  void onClose() {}

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      Get.offAllNamed(Routes.HOME, arguments: user.uid);
    }
  }

  void signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        debugPrint(result.toString());
        String _userId = result.user.uid;
        _initializeUserModel(_userId);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign in Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signUp() async {
    try {
      //showLoading();
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
        String _userId = result.user.uid;
        _addUsertoFireStore(_userId);
        _initializeUserModel(_userId);
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign Up Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void updateUser() async {
    try {
      firestore.collection(usersCollection).doc(userModel.value.id).update({
        "name": userModel.value.name,
        "email": userModel.value.email,
        "phone": userModel.value.phone,
        "position": GeoPoint(
          userModel.value.position.latitude,
          userModel.value.position.longitude,
        ),
      }).then(
        (value) => Get.snackbar("Update Berhasil", "Data Tersimpan",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white),
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Update Failed", "${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  _initializeUserModel(String userId) async {
    userModel.value = await firestore
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  _addUsertoFireStore(_userId) async {
    firestore.collection(usersCollection).doc(_userId).set({
      "name": name.text.trim(),
      "id": _userId,
      "email": email.text.trim(),
      "phone": phone.text.trim(),
      "position": GeoPoint(currentPos.latitude, currentPos.longitude),
    });
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void changeAddress() async {
    await userModel.value.setAddress();
    update();
  }

  void changeName() {
    userModel.value.name = this.name.text.trim();
    update();
  }

  void changePhone() {
    userModel.value.phone = this.phone.text.trim();
    update();
  }

  void increment() => count.value++;

  void getCurrentPos() async {
    currentPos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
