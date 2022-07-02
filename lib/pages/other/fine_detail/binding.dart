import 'package:get/get.dart';

import 'logic.dart';

class FineDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FineDetailLogic());
  }
}
