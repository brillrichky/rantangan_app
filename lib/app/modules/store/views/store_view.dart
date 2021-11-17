import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text("PESAN SEKARANG"),
      //   onPressed: () {
      //     Get.toNamed(Routes.ORDER,
      //         arguments: controller.mealplans[controller.index]);
      //   },
      // ),
      body: Container(
        height: context.height,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: controller.vendor.imageurl.isEmpty
                          ? AssetImage(
                              'assets/images/placeholder-restaurant-2.png')
                          : NetworkImage(controller.vendor.imageurl),
                    ),
                  ),
                  width: double.infinity,
                  height: context.height * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        width: double.infinity,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(controller.vendor.address)),
                              ),
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
                () => controller.mealplans.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.all(10),
                        children:
                            controller.mealplans.map((MealPlanModel mealplan) {
                          return MealPlansList(
                            mealplan: mealplan,
                          );
                        }).toList())
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.boxOpen,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                            Text("Toko belum memiliki paket",
                                style: Theme.of(context).textTheme.headline5),
                          ],
                        ),
                      ),
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
    return Card(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mealplan.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mealplan.description,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text("Paket Mengandung Bahan:"),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mealplan.allergen.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(right: 5),
                          height: 50,
                          child: Chip(
                            backgroundColor: Colors.redAccent,
                            label: Text(mealplan.allergen[index]),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 50,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 90,
                    child: Center(child: Text("Variasi\nMenu Pagi")),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 50,
                    width: context.width * 0.63,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mealplan.menu.menuPagi.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(right: 5, left: 5),
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
                    width: 90,
                    child: Center(child: Text("Variasi\nMenu Siang")),
                  ),
                  Container(
                    color: Colors.grey,
                    height: 50,
                    width: context.width * 0.63,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mealplan.menu.menuSiang.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(right: 5, left: 5),
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
            Container(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text("+ Berlangganan"),
                  onPressed: () {
                    Get.toNamed(Routes.ORDER, arguments: mealplan);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
