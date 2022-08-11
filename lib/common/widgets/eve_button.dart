import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

getEveButton(Function callBack) {
  return ElevatedButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(StadiumBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.transparent,
          ))), //圆
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor:
      MaterialStateProperty.all(Colors.green.withOpacity(0.9)), //背景颜色
      foregroundColor: MaterialStateProperty.all(Colors.white), //字体颜色
    ),
    onPressed: () {
      callBack();
    },
    child: Text("保存",
        style: TextStyle(
            color: Colors.white,
            fontSize: 36.sp,
            fontWeight: FontWeight.w400)),
  );
}
getUpdateEveButton(Function callBack) {
  return ElevatedButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(StadiumBorder(
          side: BorderSide(
            style: BorderStyle.solid,
            color: Colors.transparent,
          ))), //圆
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor:
      MaterialStateProperty.all(Colors.green.withOpacity(0.9)), //背景颜色
      foregroundColor: MaterialStateProperty.all(Colors.white), //字体颜色
    ),
    onPressed: () {
      callBack();
    },
    child: Text("更新",
        style: TextStyle(
            color: Colors.white,
            fontSize: 36.sp,
            fontWeight: FontWeight.w400)),
  );
}