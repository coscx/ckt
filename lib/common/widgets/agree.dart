import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:flutter_ckt/common/widgets/protocol_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../routers/names.dart';

class Agree extends StatefulWidget {
  @override
  _AgreeState createState() => _AgreeState();
}

class _AgreeState extends State<Agree> with ProtocolModel {

  @override
  void initState() {
    _init();
    super.initState();
  }
  _init() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      bool agree = StorageService.to.getBool("agree");
      if (agree == true) {
        Get.offAllNamed(AppRoutes.LOGIN);
      } else {
        var isAgreement = await showProtocolFunction(context);
        if (isAgreement) {
          StorageService.to.setBool("agree", true);
          Get.offAllNamed(AppRoutes.LOGIN);
        }
      }
    });

}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
