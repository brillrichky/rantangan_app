import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/modules/login/user_model.dart';

class HomeController extends GetxController {
  LoginController loginC = Get.find();
  UserModel usermodel;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  Position currentPos;

  final count = 0.obs;
  var index = 0;

  @override
  void onInit() async {
    this.usermodel = loginC.userModel.value;
    print(usermodel.toString());
    currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    vendors.bindStream(getAllVendors());
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  void updateIndex(int a) {
    index = a;
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
        print("data Meal Plan ${e.data()}");
        return VendorModel.fromMap(e.data());
      }).toList();
    });
  }

  void increment() => count.value++;
}
