import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/myorder_model.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/modules/login/user_model.dart';

class HomeController extends GetxController {
  LoginController loginC = Get.find();
  UserModel usermodel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  RxList<MyOrderModel> myOrders = RxList<MyOrderModel>([]);
  Position currentPos;

  final count = 0.obs;
  var index = 0;

  @override
  void onInit() async {
    this.usermodel = loginC.userModel.value;
    vendors.bindStream(getAllVendors());
    print(usermodel.toString());
    currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    super.onInit();
  }

  @override
  void onReady() async {
    myOrders.bindStream(getAllMyOrders());
    super.onReady();
  }

  @override
  void onClose() {}

  void updateIndex(int a) {
    index = a;
    update();
  }

  void updatePage() {
    update();
  }

  double distanceCalculator(
      double latA, double longA, double latB, double longB) {
    double distanceInMeters =
        Geolocator.distanceBetween(latA, longA, latB, longB);
    distanceInMeters = distanceInMeters / 1000;
    return distanceInMeters.roundToDouble();
  }

  Stream<List<VendorModel>> getAllVendors() {
    return firestore.collection("vendors").snapshots().map((query) {
      return query.docs.map((e) {
        //print("data Vendor ${e.data()}");
        return VendorModel.fromMap(e.data());
      }).toList();
    });
  }

  Stream<List<MyOrderModel>> getAllMyOrders() {
    return firestore
        .collection("orders")
        .where("userId", isEqualTo: usermodel.id)
        .snapshots()
        .map((query) {
      return query.docs.map((e) {
        print("data MyOrder ${e.data()}");
        return MyOrderModel.fromMap(e.data());
      }).toList();
    });
  }

  void increment() => count.value++;
}
