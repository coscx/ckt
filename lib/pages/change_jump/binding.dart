import 'package:get/get.dart';

import 'logic.dart';

class ChangeJumpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeJumpLogic());
  }
}
