import 'package:get/get.dart';

import 'logic.dart';

class PublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PublicLogic());
  }
}
