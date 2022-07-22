import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/total_user/widget/discovery_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TotalUserPage extends StatelessWidget {
  final logic = Get.find<TotalUserLogic>();
  final state = Get.find<TotalUserLogic>().state;

  @override
  Widget build(BuildContext context) {
    return DiscoveryPage();
  }
}
