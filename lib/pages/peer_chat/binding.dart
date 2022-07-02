import 'package:get/get.dart';

import 'logic.dart';

class PeerChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PeerChatLogic());
  }
}
