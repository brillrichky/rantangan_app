import 'package:get/get.dart';
import 'package:rantangan_app/app/modules/home/vendor_model.dart';
import 'package:rantangan_app/app/modules/store/mealplan_model.dart';

class OrderController extends GetxController {
  final count = 0.obs;
  Rx<bool> isDateNull = true.obs;
  Rx<bool> isFishSelected = false.obs;
  Rx<bool> isPeanutSelected = false.obs;
  Rx<bool> isMilkSelected = false.obs;

  Rx<DateTime> startSub = DateTime.now().obs;
  MealPlanModel mealplan;
  DateTime endSub = null;

  @override
  void onInit() {
    mealplan = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
