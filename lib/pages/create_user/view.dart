import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/create_user/widget/CreateUserPage.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CreateUserPage extends StatelessWidget {
  final logic = Get.find<CreateUserLogic>();
  final state = Get.find<CreateUserLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CreateUserPages();
  }
}
