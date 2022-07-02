import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chat/functions.dart';
import '../../pages/conversion/widget/object_util.dart';

class MoreWidgets {

  /*
  *  聊天页面-工具栏item
  */
  static Widget buildIcon(IconData icon, String text, {required OnItemClick o}) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 12.h,
        ),
        InkWell(
            onTap: () {

                o({});

            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: Container(
                width: 120.w,
                height: 108.h,
                color: ObjectUtil.getThemeLightColor(),
                child: Icon(icon, size: 40.sp),
              ),
            )),
        SizedBox(
          height: 5.h,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 20.sp),
        ),
      ],
    );
  }
}
