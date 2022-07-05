import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/dy_behavior_null.dart';
import 'logic.dart';

class CalcucationExactPage extends StatelessWidget {
  final logic = Get.find<CalcucationExactLogic>();
  final state = Get.find<CalcucationExactLogic>().state;

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xffefefef),
      child: Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme.of(context).copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light, // Status bar
              ),
            ),
          ),
          child: SafeArea(
            child: Obx(() {
              return Scaffold(
                  backgroundColor: Color(0xffefefef),
                  appBar: AppBar(
                    titleSpacing: 220.w,
                    leadingWidth: 100.w,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: Column(
                    children: [

                      ScrollConfiguration(
                          behavior: DyBehaviorNull(),
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                padding: EdgeInsets.only(top: 100.h),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.red,
                                      )
                                    ]),
                              )
                          )),
                    ],
                  )
              );
            }),
          )),
    );
  }
}
