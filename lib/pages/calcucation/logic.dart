import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'state.dart';

class CalcucationLogic extends GetxController {
  final CalcucationState state = CalcucationState();
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  FocusNode textFieldNode = FocusNode();
}
