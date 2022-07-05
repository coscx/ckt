import 'package:get/get.dart';

import 'logic.dart';

class CalcucationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalcucationDetailLogic());
  }
}
