import 'package:get/get.dart';

import 'logic.dart';

class TotalUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TotalUserLogic());
  }
}
