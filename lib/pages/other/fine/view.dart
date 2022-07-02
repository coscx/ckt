import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/other/fine/widget/fin_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FinePage extends StatelessWidget {
  final logic = Get.put(FineLogic());
  final state = Get.find<FineLogic>().state;

  @override
  Widget build(BuildContext context) {
    return FinPages();
  }
}
