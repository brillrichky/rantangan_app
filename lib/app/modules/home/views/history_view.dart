import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/home/myorder_model.dart';

class HistoryView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyOrder'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView(
            padding: const EdgeInsets.all(10),
            children: controller.myOrders.map((MyOrderModel myorder) {
              return MyOrderWidget(
                myorder: myorder,
              );
            }).toList()),
      ),
    );
  }
}

class MyOrderWidget extends GetView<HomeController> {
  final MyOrderModel myorder;
  MyOrderWidget({Key key, this.myorder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.store,
                        size: 50,
                      ),
                      title: Text(myorder.orderId),
                      subtitle:
                          Text("${DateFormat.yMMMMd().format(myorder.subEnd)}"),
                      trailing: Icon(Icons.arrow_right),
                      isThreeLine: true,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.verified_user,
                        size: 50,
                      ),
                      title: Text(myorder.userId) ?? Text("Error"),
                      subtitle: Text(myorder.userPhone) ?? Text("Error"),
                      trailing: Icon(Icons.arrow_right),
                      isThreeLine: true,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.store,
                        size: 50,
                      ),
                      title: Text(myorder.vendorId) ?? Text("Error"),
                      subtitle: Text(myorder.vendorPhone) ?? Text("Error"),
                      trailing: Icon(Icons.arrow_right),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
