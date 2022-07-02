import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/peer_chat/widget/peer_page.dart';
import 'package:get/get.dart';
import 'logic.dart';

class PeerChatPage extends StatelessWidget {
  final logic = Get.find<PeerChatLogic>();
  final state = Get
      .find<PeerChatLogic>()
      .state;

  PeerChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PeerChatLogic>(builder: (logic) {
      return PeerPage(messageList: logic.messageList,
        memId: logic.memId,
        model: logic.model,);
    });
  }

}
