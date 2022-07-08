import 'package:get/get.dart';

import 'logic.dart';

class FriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendLogic());
  }
}
