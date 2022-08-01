import 'package:flutter_ckt/common/entities/loan/saleman.dart';
import 'package:flutter_ckt/pages/calcucation/logic.dart';
import 'package:flutter_ckt/pages/channel/logic.dart';
import 'package:flutter_ckt/pages/conversion/logic.dart';
import 'package:flutter_ckt/pages/flow_page/logic.dart';
import 'package:flutter_ckt/pages/home/logic.dart';
import 'package:flutter_ckt/pages/main/index.dart';
import 'package:flutter_ckt/pages/my_user/logic.dart';
import 'package:flutter_ckt/pages/other/fine/logic.dart';
import 'package:flutter_ckt/pages/total_user/logic.dart';
import 'package:get/get.dart';
import '../lost_user/logic.dart';
import '../mine/logic.dart';
import 'controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<TotalUserLogic>(() => TotalUserLogic());
    Get.lazyPut<FineLogic>(() => FineLogic());
    Get.lazyPut<MyUserLogic>(() => MyUserLogic());
    Get.lazyPut(() => LostLogic());
    Get.lazyPut<ChannelLogic>(() => ChannelLogic());
    Get.lazyPut<CalcucationLogic>(() => CalcucationLogic());
    Get.lazyPut<HomeLogic>(() => HomeLogic());
    Get.lazyPut<MineLogic>(() => MineLogic());
    Get.lazyPut<ConversionLogic>(() => ConversionLogic());
  }
}
