import 'package:get/get.dart';

import 'logic.dart';

class SearchFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFlowLogic());
  }
}
