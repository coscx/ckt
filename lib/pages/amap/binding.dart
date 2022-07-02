import 'package:get/get.dart';

import 'logic.dart';

class AmapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AmapLogic());
  }
}
