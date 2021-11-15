import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';

import '../controllers/edit_controller.dart';

class EditView extends GetView<EditController> {
  final LoginController loginC = Get.find();
  final HomeController HomeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          centerTitle: true,
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
                        'Edit Profile',
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
                          controller: loginC.name, //BELUM ADA
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
                          controller: loginC.phone, //BELUM ADA
                          decoration: const InputDecoration(
                            //Form Password
                            border: OutlineInputBorder(),
                            hintText: 'ex: 081339630807',
                            labelText: 'No. HP',
                          ),
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            loginC.changeName();
                            loginC.changePhone();
                            HomeC.updatePage();
                            Get.back();
                          },
                          child: Text('Submit'),
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
