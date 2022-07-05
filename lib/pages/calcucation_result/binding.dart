import 'package:get/get.dart';

import 'logic.dart';

class CalcucationResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalcucationResultLogic());
  }
}
