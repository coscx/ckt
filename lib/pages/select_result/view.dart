import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/friend/widget/friends_page.dart';
import 'package:flutter_ckt/pages/select_result/widget/select_result_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SelectResultPage extends StatelessWidget {
  final logic = Get.find<SelectResultLogic>();
  final state = Get.find<SelectResultLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SelectPage(onResendClick: (data) {  },);
  }
}
