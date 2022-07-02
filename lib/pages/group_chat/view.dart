import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/group_chat/widget/group_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GroupChatPage extends StatelessWidget {
  final logic = Get.find<GroupChatLogic>();
  final state = Get.find<GroupChatLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupChatLogic>(builder: (logic) {
      return GroupPage(messageList: logic.messageList,
        memId: logic.memId,
        model: logic.model,);
    });
  }
}
