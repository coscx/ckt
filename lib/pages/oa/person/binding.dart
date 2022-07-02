import 'package:get/get.dart';

import 'logic.dart';

class PersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonLogic());
  }
}
