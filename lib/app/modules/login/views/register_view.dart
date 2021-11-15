import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';

class RegisterView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registration Page"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: context.height,
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  LimitedBox(
                    maxHeight: 100,
                    child: Container(
                      alignment: Alignment.topLeft,
                      width: double.infinity,
                      child: Text(
                        'Registrasi',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.name, //BELUM ADA
                          decoration: const InputDecoration(
                            //Form Email
                            border: OutlineInputBorder(),
                            hintText: 'ex: Brill Richky',
                            labelText: 'Name',
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 12,
                          controller: controller.phone, //BELUM ADA
                          decoration: const InputDecoration(
                            //Form Password
                            border: OutlineInputBorder(),
                            hintText: 'ex: 081339630807',
                            labelText: 'No. HP',
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: controller.email, //BELUM ADA
                          decoration: const InputDecoration(
                            //Form Email
                            border: OutlineInputBorder(),
                            hintText: 'ex: email_saya@google.com',
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: controller.password, //BELUM ADA
                          obscureText: true,
                          decoration: const InputDecoration(
                            //Form Password
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan Password',
                            labelText: 'Password',
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          //Button Login
                          onPressed: () {
                            controller
                                .signUp(); //LoginPage > AuthController > Auth?:Home:Login
                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
