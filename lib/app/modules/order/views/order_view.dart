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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 110,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Rp ${controller.mealplan.price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Tipe Pembayaran: "),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "TUNAI",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.orderValidator();
                        },
                        child: Text("CHECKOUT"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.height,
          child: Column(
            children: [
              Card(
                child: Container(
                  color: Colors.white,
                  height: 210,
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
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                    width: double.infinity,
                                    child: Text("Catatan Tambahan")),
                                TextFormField(
                                  controller: controller.extraNotes,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
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
                        initialValue: controller.startSub.value,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) {
                          controller.isDateNull.value = true;
                          if (e?.day == null) return null;
                          if (e.isBefore(DateTime.now())) {
                            controller.isDateNull.value = true;
                            return "Tidak dapat memilih ditanggal ini";
                          }
                          if ([6, 7].contains(e.weekday)) {
                            controller.isDateNull.value = true;
                            return "Tidak dapat memilih Sabtu dan Minggu";
                          }
                          controller.isDateNull.value = false;
                          return null;
                        },
                        mode: DateTimeFieldPickerMode.date,
                        onDateSelected: (DateTime value) {
                          controller.startSub.value = value;
                          print(controller.startSub.value);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text("Berakhir pada: "),
                              Text(
                                "${DateFormat.yMMMMd().format(controller.startSub.value.add(Duration(days: 7)))}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         Text("Optional Request"),
              //         Container(
              //           height: 50,
              //           width: double.infinity,
              //           child: Row(
              //             children: [
              //               Obx(
              //                 () => FilterChip(
              //                     label: Text("Tidak Pedas"),
              //                     selected: controller.isFishSelected.value,
              //                     onSelected: (value) {
              //                       controller.isFishSelected.value = value;
              //                     }),
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Obx(
              //                 () => FilterChip(
              //                     label: Text("Extra Pedas"),
              //                     selected: controller.isPeanutSelected.value,
              //                     onSelected: (value) {
              //                       controller.isPeanutSelected.value = value;
              //                     }),
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Card(
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         width: double.infinity,
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Container(
              //               width: double.infinity,
              //               child: Text("Rincian Berlangganan:"),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
