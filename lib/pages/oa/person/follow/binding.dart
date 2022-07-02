import 'package:get/get.dart';

import 'logic.dart';

class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowLogic());
  }
}
