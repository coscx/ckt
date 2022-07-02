import 'package:get/get.dart';

import '../search/logic.dart';
import 'logic.dart';

class SearchAppointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchAppointLogic());
    Get.lazyPut(() => SearchLogic());
  }
}
