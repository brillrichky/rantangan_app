import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/login/controllers/login_controller.dart';
import 'package:rantangan_app/app/modules/store/mealplan_model.dart';

class StoreController extends GetxController {
  HomeController homeC = Get.find();
  LoginController loginC = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //CollectionReference mealplans = FirebaseFirestore.instance.collection('mealplans');
  RxList<MealPlanModel> mealplans = RxList<MealPlanModel>([]);

  VendorModel vendor;

  final count = 0.obs;
  @override
  void onInit() {
    vendor = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    mealplans.bindStream(getAllMealPlans());
    super.onReady();
  }

  @override
  void onClose() {}

  double distanceCalculator(
      double latA, double longA, double latB, double longB) {
    double distanceInMeters =
        Geolocator.distanceBetween(latA, longA, latB, longB);
    distanceInMeters = distanceInMeters / 1000;
    return distanceInMeters;
  }

  Stream<List<MealPlanModel>> getAllMealPlans() {
    return firestore
        .collection("mealplans")
        .where("vendorId", isEqualTo: vendor.id)
        .snapshots()
        .map((query) {
      return query.docs.map((e) {
        print("data Meal Plan ${e.data()}");
        return MealPlanModel.fromMap(e.data());
      }).toList();
    });
  }
}
