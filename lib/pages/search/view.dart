import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/search/widget/serach_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SearchPage extends StatelessWidget {
  final logic = Get.find<SearchLogic>();
  final state = Get
      .find<SearchLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(builder: (logic) {
      return SearchPages(photos: logic.homeUser,isAppoint: logic.isAppoint);
    });
  }
}
