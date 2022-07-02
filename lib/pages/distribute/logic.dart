import 'package:get/get.dart';

import 'state.dart';

class DistributeLogic extends GetxController {
  final DistributeState state = DistributeState();
  String uuid ="";
  @override
  void onInit() {
    uuid =Get.arguments;
    super.onInit();
  }
}
