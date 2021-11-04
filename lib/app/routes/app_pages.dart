import 'package:get/get.dart';

import 'package:rantangan_app/app/modules/home/bindings/home_binding.dart';
import 'package:rantangan_app/app/modules/home/views/home_view.dart';
import 'package:rantangan_app/app/modules/login/bindings/login_binding.dart';
import 'package:rantangan_app/app/modules/login/views/login_view.dart';
import 'package:rantangan_app/app/modules/order/bindings/order_binding.dart';
import 'package:rantangan_app/app/modules/order/views/order_view.dart';
import 'package:rantangan_app/app/modules/store/bindings/store_binding.dart';
import 'package:rantangan_app/app/modules/store/views/store_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      //binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.STORE,
      page: () => StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
  ];
}
