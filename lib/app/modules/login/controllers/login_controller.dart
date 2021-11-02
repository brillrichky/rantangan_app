import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/user_model.dart';
import 'package:rantangan_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Rx<User> firebaseUser;
  Rx<UserModel> userModel = UserModel().obs;

  final count = 0.obs;
  String usersCollection = "users";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  @override
  void onClose() {}

  _setInitialScreen(User user) {
    if (user == null) {
      //Get.toNamed(Routes.LOGIN);
      Get.offAllNamed(Routes.LOGIN);
    } else {
      //Get.toNamed(Routes.HOME);
      Get.offAllNamed(Routes.HOME);
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

  _initializeUserModel(String userId) async {
    userModel.value = await firestore
        .collection(usersCollection)
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void increment() => count.value++;
}
