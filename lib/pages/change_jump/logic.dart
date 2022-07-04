import 'package:get/get.dart';

import '../../common/routers/names.dart';
import 'state.dart';

class ChangeJumpLogic extends GetxController {
  final ChangeJumpState state = ChangeJumpState();
  @override
  void onInit() {

    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.offAndToNamed(AppRoutes.Application);

    });

    super.onInit();
  }
}
