import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/setting/widget/setting_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  final logic = Get.find<SettingLogic>();
  final state = Get.find<SettingLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SettingPages();
  }
}
