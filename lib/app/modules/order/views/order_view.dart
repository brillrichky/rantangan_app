import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';

import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  final LoginController loginC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.mealplan.name),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 100,
              width: double.infinity,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      child: Text("Detail Pengiriman:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${loginC.userModel.value.name}",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${loginC.userModel.value.phone}",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "${loginC.userModel.value.address}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        labelText: "Pilih Tanggal Berlangganan",
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) {
                        controller.isDateNull.value = true;
                        if (e?.day == null) return null;
                        if (e.isBefore(DateTime.now()))
                          return "Tidak dapat memilih ditanggal ini";
                        if ([6, 7].contains(e.weekday))
                          return "Tidak dapat memilih Sabtu dan Minggu";
                        controller.isDateNull.value = false;
                        return null;
                      },
                      mode: DateTimeFieldPickerMode.date,
                      onDateSelected: (DateTime value) {
                        controller.startSub.value = value;
                        print(controller.startSub.value);
                      },
                    ),
                    Obx(
                      () => Container(
                        width: double.infinity,
                        child: Text(
                          "Berakhir pada: ${DateFormat.yMMMMd().format(controller.startSub.value.add(Duration(days: 7)))}",
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Obx(
                    //       () => FilterChip(
                    //           label: Text("Ikan"),
                    //           selected: controller.isFishSelected.value,
                    //           onSelected: (value) {
                    //             controller.isFishSelected.value = value;
                    //           }),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Obx(
                    //       () => FilterChip(
                    //           label: Text("Kacang"),
                    //           selected: controller.isPeanutSelected.value,
                    //           onSelected: (value) {
                    //             controller.isPeanutSelected.value = value;
                    //           }),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Obx(
                    //       () => FilterChip(
                    //           label: Text("Susu"),
                    //           selected: controller.isMilkSelected.value,
                    //           onSelected: (value) {
                    //             controller.isMilkSelected.value = value;
                    //           }),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
            Divider(),
            Text("Menu ini mengandung"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.mealplan.allergen.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 5),
                      height: 50,
                      child: Chip(
                        label: Text(controller.mealplan.allergen[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text("Yaho"),
                    ],
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              height: 100,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Tipe Pembayaran: "),
                        Text(
                          "TUNAI",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("CHECKOUT"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
