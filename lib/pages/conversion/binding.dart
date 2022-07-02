import 'package:get/get.dart';

import 'logic.dart';

class ConversionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversionLogic());
  }
}
