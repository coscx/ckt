import 'package:get/get.dart';

import '../search/logic.dart';
import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut<SearchLogic>(() => SearchLogic());
  }
}
