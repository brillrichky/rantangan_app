import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/controllers/home_controller.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/store/mealplan_model.dart';

class StoreController extends GetxController {
  HomeController homeC = Get.find();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //CollectionReference mealplans = FirebaseFirestore.instance.collection('mealplans');
  RxList<MealPlanModel> mealplans = RxList<MealPlanModel>([]);

  VendorModel vendor;
  double distanceKM;

  final count = 0.obs;
  @override
  void onInit() {
    vendor = Get.arguments;
    distanceKM =
        distanceCalculator(vendor.position.latitude, vendor.position.longitude);
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
    double lat,
    double long,
  ) {
    print(homeC.currentPos.toString());
    double distanceInMeters = Geolocator.distanceBetween(
        lat, long, homeC.currentPos.latitude, homeC.currentPos.longitude);
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
