import 'package:get/get.dart';

import 'logic.dart';

class SelectResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectResultLogic());
  }
}
