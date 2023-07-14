import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/customer/widget/customer_page.dart';
import 'package:get/get.dart';

import '../peer_chat/widget/peer_page.dart';
import 'logic.dart';

class CustomerPage extends StatelessWidget {
  CustomerPage({Key? key}) : super(key: key);

  final logic = Get.find<CustomerLogic>();
  final state = Get.find<CustomerLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerLogic>(builder: (logic) {
      return CustomerInlinePage(messageList: logic.messageList,
        memId: logic.memId,
        model: logic.model,);
    });
  }
}
