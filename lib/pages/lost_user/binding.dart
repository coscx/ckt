import 'package:flutter_ckt/pages/friend/logic.dart';
import 'package:get/get.dart';

import '../search/logic.dart';
import 'logic.dart';

class LostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LostLogic());
    Get.lazyPut(() => FriendLogic());
    Get.lazyPut<SearchLogic>(() => SearchLogic());
  }
}
