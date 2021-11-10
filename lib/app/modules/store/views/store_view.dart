import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/store/mealplan_model.dart';
import 'package:rantangan_app/app/routes/app_pages.dart';

import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(controller.vendor.name),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("PESAN SEKARANG"),
        onPressed: () {
          Get.toNamed(Routes.ORDER,
              arguments: controller.mealplans[controller.index]);
        },
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.network(
                    controller.vendor.imageurl,
                    fit: BoxFit.cover,
                  ),
                  width: double.infinity,
                  height: context.height * 0.3,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.height * 0.225,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.store_rounded),
                                title: Text(controller.vendor.name),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      size: 13,
                                    ),
                                    Text(
                                        " ${controller.distanceKM.toStringAsFixed(2)} KM"),
                                  ],
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(controller.vendor.address),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView(
                    padding: const EdgeInsets.all(10),
                    children:
                        controller.mealplans.map((MealPlanModel mealplan) {
                      return MealPlansList(
                        mealplan: mealplan,
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealPlansList extends GetView<StoreController> {
  final MealPlanModel mealplan;
  const MealPlansList({Key key, this.mealplan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          Text(mealplan.name),
          Divider(),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: Center(child: Text("Variasi\nMenu Pagi")),
                ),
                Container(
                  height: 50,
                  width: context.width * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mealplan.menu.menuPagi.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: 5),
                        height: 50,
                        child: Chip(
                          label: Text(mealplan.menu.menuPagi[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: Center(child: Text("Variasi\nMenu Siang")),
                ),
                Container(
                  height: 50,
                  width: context.width * 0.7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mealplan.menu.menuSiang.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(right: 5),
                        height: 50,
                        child: Chip(
                          label: Text(mealplan.menu.menuSiang[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
