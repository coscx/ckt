import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/services/storage.dart';
import 'state.dart';

class CalcucationLogic extends GetxController {
  final CalcucationState state = CalcucationState();
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  FocusNode textFieldNode = FocusNode();
  @override
  void onInit() {
    usernameController.text= StorageService.to.getString("name");
    passwordController.text= StorageService.to.getString("mobile");

    update();
    super.onInit();
  }
}
