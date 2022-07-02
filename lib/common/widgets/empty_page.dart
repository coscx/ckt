import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 说明: 

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 300,
      alignment: Alignment.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Icon(Icons.style, color: Colors.grey, size: 190.sp),
             Container(
              padding:  EdgeInsets.only(top: 32.h),
              child:  Text(
                "暂无数据",
                style:  TextStyle(
                  fontSize: 30.sp,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
    );
  }
}
