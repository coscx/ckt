import 'package:get/get.dart';

import 'logic.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerLogic());
  }
}
