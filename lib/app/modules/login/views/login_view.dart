import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rantangan_app/app/modules/login/views/register_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: context.height,
            padding: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.gg,
                    size: 100,
                  ),
                  LimitedBox(
                    maxHeight: 100,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Rantangan',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  LimitedBox(
                    maxHeight: 50,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Katering Harian',
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'subscription based cathering',
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.email,
                          decoration: const InputDecoration(
                            //Form Email
                            border: OutlineInputBorder(),
                            hintText: 'Masukkan Email',
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: controller.password,
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
                                .signIn(); //LoginPage > AuthController > Auth?:Home:Login
                          },
                          child: Text('Login'),
                        ),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum memiliki akun?"),
                              TextButton(
                                onPressed: () {
                                  Get.to(RegisterView());
                                },
                                child: Text('Buat Akun'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
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
