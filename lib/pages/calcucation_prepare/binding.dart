import 'package:get/get.dart';

import 'logic.dart';

class CalcucationPrepareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalcucationPrepareLogic());
  }
}
