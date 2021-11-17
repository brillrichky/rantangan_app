import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        () {
          return controller.myOrders.isNotEmpty
              ? ListView(
                  padding: const EdgeInsets.all(10),
                  children: controller.myOrders.map((MyOrderModel myorder) {
                    return MyOrderWidget(
                      myorder: myorder,
                    );
                  }).toList())
              : Center(child: Text("KOSONG"));
        },
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
                    OrderHeader(myorder: myorder),
                    CustomerDetails(myorder: myorder),
                    VendorDetails(myorder: myorder),
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

class VendorDetails extends StatelessWidget {
  const VendorDetails({
    Key key,
    @required this.myorder,
  }) : super(key: key);

  final MyOrderModel myorder;

  @override
  Widget build(BuildContext context) {
    CollectionReference vendors =
        FirebaseFirestore.instance.collection('vendors');
    return FutureBuilder<DocumentSnapshot>(
        future: vendors.doc(myorder.vendorId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data["name"]) ?? Text("Error"),
              subtitle: Text(myorder.vendorPhone) ?? Text("Error"),
              trailing: Icon(Icons.arrow_right),
              isThreeLine: true,
            );
          }
          return ListTile(
            leading: Icon(
              Icons.verified_user,
              size: 50,
            ),
            title: Text(myorder.userId) ?? Text("Error"),
            subtitle: Text(myorder.userPhone) ?? Text("Error"),
            trailing: Icon(Icons.arrow_right),
            isThreeLine: true,
          );
        });
  }
}

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({
    Key key,
    @required this.myorder,
  }) : super(key: key);

  final MyOrderModel myorder;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(myorder.userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data["name"]) ?? Text("Error"),
              subtitle: Text(myorder.userPhone) ?? Text("Error"),
              trailing: Icon(Icons.arrow_right),
              isThreeLine: true,
            );
          }
          return ListTile(
            leading: Icon(
              Icons.verified_user,
              size: 50,
            ),
            title: Text(myorder.userId) ?? Text("Error"),
            subtitle: Text(myorder.userPhone) ?? Text("Error"),
            trailing: Icon(Icons.arrow_right),
            isThreeLine: true,
          );
        });
  }
}

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    Key key,
    @required this.myorder,
  }) : super(key: key);

  final MyOrderModel myorder;

  @override
  Widget build(BuildContext context) {
    CollectionReference meals =
        FirebaseFirestore.instance.collection('mealplans');
    return FutureBuilder<DocumentSnapshot>(
        future: meals.doc(myorder.mealId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data.data() as Map<String, dynamic>;
            return ListTile(
              leading: FaIcon(
                FontAwesomeIcons.box,
                size: 30,
              ),
              title: Text("${data["name"]}"),
              subtitle: Text("${DateFormat.yMMMMd().format(myorder.subEnd)}"),
              trailing: myorder.isConfirmed == false
                  ? myorder.isCancelled == true
                      ? Chip(
                          label: Text(
                            "Cancelled",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        )
                      : Chip(
                          label: Text("Waiting Confirmation"),
                          backgroundColor: Colors.yellow,
                        )
                  : Chip(
                      label: Text(
                        "Confirmed",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    ),
              isThreeLine: true,
            );
          }
          return ListTile(
            leading: Icon(
              Icons.store,
              size: 50,
            ),
            title: Text(myorder.orderId),
            subtitle: Text("${DateFormat.yMMMMd().format(myorder.subEnd)}"),
            trailing: Icon(Icons.arrow_right),
            isThreeLine: true,
          );
        });
  }
}
