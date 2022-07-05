import 'package:get/get.dart';

import 'state.dart';

class CalcucationResultLogic extends GetxController {
  final CalcucationResultState state = CalcucationResultState();

  String result  = Get.arguments==null ?"":Get.arguments;

}
