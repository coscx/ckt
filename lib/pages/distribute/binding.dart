import 'package:get/get.dart';

import 'logic.dart';

class DistributeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DistributeLogic());
  }
}
