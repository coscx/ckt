import 'package:get/get.dart';

import 'logic.dart';

class CalcucationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalcucationLogic());
  }
}
