import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/routes/app_pages.dart';

class ProfileView extends GetView<LoginController> {
  final HomeController homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ProfileView'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                controller.signOut();
              },
              icon: Icon(Icons.logout))),
      body: Container(
        height: context.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  child: CircleAvatarText(controller: controller),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                controller.userModel.value.name ?? "ERROR",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.edit),
                                onPressed: () {
                                  Get.toNamed(Routes.EDIT);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          controller.userModel.value.phone ?? "ERROR",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        child: Text("Address:"),
                      ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              controller.userModel.value.address ?? "ERROR",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                controller.updateUser();
                              },
                              child: Text("SAVE"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: OutlinedButton(
                              onPressed: () async {
                                await controller.changeAddress();
                                homeC.updatePage();
                                Get.snackbar(
                                  "Berhasil, Alamat saat ini:",
                                  "${controller.userModel.value.address}",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              },
                              child: Text("Change Address"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("Log Out"),
                  onPressed: () {
                    controller.signOut();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarText extends StatelessWidget {
  const CircleAvatarText({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    try {
      return Text(
        "${controller.userModel.value.name.substring(0, 2).toUpperCase()}",
        style: TextStyle(fontSize: 40, color: Colors.white),
      );
    } catch (e) {
      return Text(
        "null",
        style: TextStyle(fontSize: 40, color: Colors.white),
      );
    }
  }
}
