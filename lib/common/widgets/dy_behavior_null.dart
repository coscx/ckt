import 'dart:io';
import 'package:flutter/material.dart';

class DyBehaviorNull extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return child;
    }
  }
}


