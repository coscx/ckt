import 'package:get/get.dart';

import '../../common/entities/home/common.dart';
import 'state.dart';

class SearchFlowLogic extends GetxController {
  final SearchFlowState state = SearchFlowState();
  List<SelectItem> selectItems = Get.arguments;
  @override
  void onInit() {
    super.onInit();
  }
}
