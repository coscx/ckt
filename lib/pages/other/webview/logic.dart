import 'package:get/get.dart';

import 'state.dart';

class WebviewLogic extends GetxController {
  final WebviewState state = WebviewState();

  String title = "";
  String url = "";
  @override
  // TODO: implement listeners
void onInit() {
    var args =Get.arguments;
    title = args['title'];
    url = args['url'];
    super.onInit();
  }
}
