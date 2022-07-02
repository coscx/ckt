import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/dy_behavior_null.dart';

/// 底部弹出框
class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({this.list, required this.onItemClickListener})
      : assert(list != null);
  final list;
  final OnItemClickListener onItemClickListener;

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

typedef OnItemClickListener = void Function(int index);

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  OnItemClickListener? onItemClickListener;
  var itemCount;
  double itemHeight = 80.h;
  double circular = 20.w;

  @override
  void initState() {
    super.initState();
    onItemClickListener = widget.onItemClickListener;
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = ScreenUtil().screenWidth;
    int listLength = widget.list.length;

    /// 最后还有一个cancel，所以加1
    itemCount = listLength + 1;
    var height;
    if (listLength == 1) {
      height = ((listLength + 2) * 90.h).toDouble();
    } else {
      height = ((listLength + 1) * 90.h).toDouble();
    }
    var cancelContainer = GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: itemHeight,
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: BoxDecoration(
            color: Colors.white, // 底色
            borderRadius: BorderRadius.circular(circular),
          ),
          child: Center(
            child: Text(
              "取消",
              style: TextStyle(
                  fontFamily: 'Robot',
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  color: const Color(0xff333333),
                  fontSize: 35.sp),
            ),
          ),
        ));
    var totalContainer = SizedBox(
      child: ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child:  ListView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              if (index == itemCount - 1) {
                return Container(
                  child: cancelContainer,
                  margin: EdgeInsets.only(top: 20.h),
                );
              }
              return getItemContainer(context, index, listLength);
            }),
      ),
      height: height,
      width: deviceWidth * 0.97,
    );
    var stack = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          bottom: 20.h,
          child: totalContainer,
        ),
      ],
    );
    return stack;
  }

  Widget getItemContainer(BuildContext context, int index, int listLength) {
    if (widget.list == null) {
      return Container();
    }
    var text = widget.list[index];
    var contentText = Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: const Color(0xFF333333),
          fontSize: 35.sp),
    );
    var decoration;


    if (listLength == 1) {
      decoration = BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(width: 1.w, color: const Color(0xffe5e5e5)));
    } else if (listLength > 1) {
      if (index == 0) {
        decoration = BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
          border: Border.all(width: 1.w, color: const Color(0xffe5e5e5)),
        );
      } else if (index == listLength - 1) {
        decoration = BoxDecoration(
          color: Colors.white, // 底色
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.w),
              bottomRight: Radius.circular(10.w)),
          border: Border.all(width: 1.w, color: const Color(0xffe5e5e5)),
        );
      } else {
        decoration = BoxDecoration(
          color: Colors.white, // 底色
          border: Border(
              left: BorderSide(color: Colors.white, width: 1.w),
              right: BorderSide(color: Colors.white, width: 1.w),
              bottom: BorderSide(width: 1.w, color: const Color(0xffe5e5e5))),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        if (onItemClickListener != null) {
          Navigator.pop(context);
          onItemClickListener!(index);
        }
      },
      child: Container(
          height: itemHeight,
          margin: EdgeInsets.only(left: 20.w, right: 20.w),
          decoration: decoration,
          child: Center(
            child: contentText,
          )),
    );
  }
}
