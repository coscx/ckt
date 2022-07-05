import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/calcucation_detail/widget/calcucation_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CalcucationDetailPage extends StatelessWidget {
  final logic = Get.find<CalcucationDetailLogic>();
  final state = Get.find<CalcucationDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CalcucationPages();
  }
}
