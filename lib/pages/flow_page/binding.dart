import 'package:get/get.dart';

import 'logic.dart';

class FlowPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FlowPageLogic());
  }
}
