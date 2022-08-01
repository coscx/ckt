import 'package:flutter_ckt/pages/friend/logic.dart';
import 'package:flutter_ckt/pages/my_user/logic.dart';
import 'package:get/get.dart';

import '../lost_user/logic.dart';
import 'logic.dart';

class TotalUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TotalUserLogic());
    Get.lazyPut(() => MyUserLogic());

  }
}
