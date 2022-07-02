import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/widgets/new_amaps.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AmapPage extends StatelessWidget {
  final logic = Get.find<AmapLogic>();
  final state = Get.find<AmapLogic>().state;

  @override
  Widget build(BuildContext context) {
    return AMaps();
  }
}
