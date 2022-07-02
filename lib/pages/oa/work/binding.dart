import 'package:get/get.dart';

import 'logic.dart';

class WorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkLogic());
  }
}
