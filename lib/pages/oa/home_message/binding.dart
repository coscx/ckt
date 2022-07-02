import 'package:get/get.dart';

import '../../search/logic.dart';
import 'logic.dart';

class HomeMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeMessageLogic());
    Get.lazyPut<SearchLogic>(() => SearchLogic());
  }
}
