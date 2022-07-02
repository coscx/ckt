import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/search_appoint/widget/serach_page.dart';
import 'package:get/get.dart';

import '../search/widget/serach_page.dart';
import 'logic.dart';

class SearchAppointPage extends StatelessWidget {
  final logic = Get.find<SearchAppointLogic>();
  final state = Get.find<SearchAppointLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchAppointLogic>(builder: (logic) {
      return SearchPagesAppoint(photos: logic.homeUser,isAppoint: logic.isAppoint);
    });
  }
}
