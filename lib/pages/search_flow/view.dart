import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/search_flow/widget/wx_search_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SearchFlowPage extends StatelessWidget {
  final logic = Get.find<SearchFlowLogic>();
  final state = Get.find<SearchFlowLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WxSearchPage(selectItems:logic.selectItems,);
  }
}
