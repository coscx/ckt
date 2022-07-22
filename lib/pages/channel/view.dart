import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/channel/widget/channel_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ChannelPage extends StatelessWidget {
  final logic = Get.find<ChannelLogic>();
  final state = Get.find<ChannelLogic>().state;

  @override
  Widget build(BuildContext context) {
    return ChannelsPages();
  }
}
