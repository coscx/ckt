import 'package:get/get.dart';

import 'logic.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebviewLogic());
  }
}
