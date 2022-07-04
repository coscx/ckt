import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/routers/routes.dart';
import 'package:flutter_ckt/common/store/store.dart';

import 'package:get/get.dart';

/// 第一次欢迎页面
class RouteWelcomeMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (GetPlatform.isAndroid) {
      if (ConfigStore.to.isAgree == false) {
        return null;
      }
    }
    if (UserStore.to.isLogin == true) {

      if (UserStore.to.profile.messageCount == 1) {
        return const RouteSettings(name: AppRoutes.OAApplication);
      }else{
        return const RouteSettings(name: AppRoutes.Application);
      }
    } else {
      return const RouteSettings(name: AppRoutes.LOGIN);
    }
  }
}
