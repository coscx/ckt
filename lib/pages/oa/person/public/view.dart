import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PublicPage extends StatelessWidget {
  final logic = Get.find<PublicLogic>();
  final state = Get.find<PublicLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light, // Status bar
            ),
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              //去掉Appbar底部阴影
              leadingWidth: 150.w,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Container(
                  padding: EdgeInsets.only(left: 0.w, top: 0.w, bottom: 0),
                  child: Text("掉落公海通知",
                      style: TextStyle(
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontSize: 45.sp,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ))),
              actions: <Widget>[],
            ),
            body: Center(
              child: Container(
                alignment: FractionalOffset.center,
                child: Container(
                    padding: EdgeInsets.only(top: 200.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.notifications,
                            color: Colors.orangeAccent, size: 200.sp),
                        Container(
                          padding: EdgeInsets.only(top: 0.h),
                          child: Text(
                            "暂无通知",
                            style: TextStyle(
                              fontSize: 40.sp,
                              color: Colors.orangeAccent,
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )));
  }
}
