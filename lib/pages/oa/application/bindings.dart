import 'package:flutter_ckt/pages/conversion/logic.dart';
import 'package:flutter_ckt/pages/conversion/view.dart';
import 'package:flutter_ckt/pages/flow_page/logic.dart';
import 'package:flutter_ckt/pages/frame/login/logic.dart';
import 'package:flutter_ckt/pages/home/logic.dart';
import 'package:flutter_ckt/pages/main/index.dart';
import 'package:flutter_ckt/pages/oa/home_message/logic.dart';
import 'package:flutter_ckt/pages/oa/person/logic.dart';
import 'package:flutter_ckt/pages/oa/work/logic.dart';
import 'package:flutter_ckt/pages/peer_chat/logic.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OAApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OAApplicationController>(() => OAApplicationController());
    Get.lazyPut<HomeMessageLogic>(() => HomeMessageLogic());
    Get.lazyPut<PersonLogic>(() => PersonLogic());
    Get.lazyPut<WorkLogic>(() => WorkLogic());

  }
}
