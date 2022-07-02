import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/widgets/agree.dart';
import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Agree();
  }
}
