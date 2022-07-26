import 'package:flt_im_plugin/conversion.dart';
import 'package:get/get.dart';

import '../../common/routers/names.dart';
import '../../common/services/storage.dart';
import 'state.dart';

class SelectResultLogic extends GetxController {
  final SelectResultState state = SelectResultState();
  void onTap(int? id ,String? name) {
    if (id ==null) return;
    Get.back(result: { "id": id, "name": name});
  }
}
