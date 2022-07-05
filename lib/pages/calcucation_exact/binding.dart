import 'package:get/get.dart';

import 'logic.dart';

class CalcucationExactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalcucationExactLogic());
  }
}
