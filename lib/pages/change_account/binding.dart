import 'package:get/get.dart';

import 'logic.dart';

class ChangeAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeAccountLogic());
  }
}
