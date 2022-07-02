import 'package:flutter/material.dart';
import './widget/fine_detail.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FineDetailPage extends StatelessWidget {
  final logic = Get.find<FineDetailLogic>();
  final state = Get.find<FineDetailLogic>().state;

   FineDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimeLinePage(loanId: logic.loanId,);
  }
}
