import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Rantangan',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Katering Harian',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'subscription based cathering',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: controller.email,
                    decoration: const InputDecoration(
                      //Form Email
                      hintText: 'Masukkan Email',
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    controller: controller.password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      //Form Password
                      hintText: 'Masukkan Password',
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    //Button Login
                    onPressed: () {
                      controller
                          .signIn(); //LoginPage > AuthController > Auth?:Home:Login
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Register Page
                    },
                    child: Text('Buat Akun'),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.redAccent,
                  //   ),
                  //   onPressed: () {
                  //     Get.snackbar(
                  //         "Login Vendor [Error]", "error: belum tersedia",
                  //         snackPosition: SnackPosition.BOTTOM,
                  //         backgroundColor: Colors.red,
                  //         colorText: Colors.white);
                  //   },
                  //   child: Text('Mode Penjual'),
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}
