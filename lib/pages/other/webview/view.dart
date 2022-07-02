import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/common_webview.dart';
import 'logic.dart';

class WebviewPage extends StatelessWidget {
  final logic = Get.find<WebviewLogic>();
  final state = Get.find<WebviewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CommonWebViewPage(htmlUrl: logic.url,pageTitle: logic.title,);
  }
}
