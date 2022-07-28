import 'package:get/get.dart';

import '../search/logic.dart';
import 'logic.dart';

class MyUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyUserLogic());
    Get.lazyPut<SearchLogic>(() => SearchLogic());
  }
}
