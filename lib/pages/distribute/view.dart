import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/distribute/widget/change_user.dart';
import 'package:get/get.dart';

import 'logic.dart';

class DistributePage extends StatelessWidget {
  final logic = Get.find<DistributeLogic>();
  final state = Get.find<DistributeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return  ErpUserPage(uuid: logic.uuid);
  }
}
