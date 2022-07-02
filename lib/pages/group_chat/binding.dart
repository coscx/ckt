import 'package:get/get.dart';

import 'logic.dart';

class GroupChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GroupChatLogic());
  }
}
