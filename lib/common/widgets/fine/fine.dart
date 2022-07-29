import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/saleman.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routers/names.dart';

class MyItem {
  final String icon;
  final String name;
  final String money;
  final String count;
  final String status;
  final String time;
  final Color color;

  const MyItem(
      {required this.icon,
      required this.name,
      required this.money,
      required this.count,
      required this.status,
      required this.time,
      required this.color});
}

MyItem getStatus(SaleManDataData data) {
  String status = "未知";
  Color color = const Color(0xffFF6666);
  String icon = "assets/images/default/fine_call.png";
  if (data.status == 1) {
    status = "待联系";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 2) {
    status = "待提交";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 3) {
    status = "待进件";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 4) {
    status = "待审批";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 5) {
    status = "待补件";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 6) {
    status = "待风控";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 7) {
    status = "待放款";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }

  if (data.status == 8) {
    status = "已放款";
    color = const Color(0xffD8AA0F);
    icon = "assets/images/default/fine_success.png";
  }
  if (data.status == 9) {
    status = "放款失败";
    color = const Color(0xff4CD070);
    icon = "assets/images/default/fine_fail.png";
  }
  if (data.status == 10) {
    status = "客户放弃";
    color = const Color(0xff6360CA);
    icon = "assets/images/default/fine_lost.png";
  }
  if (data.status == 11) {
    status = "资质不符";
    color = const Color(0xff4CD070);
    icon = "assets/images/default/fine_no.png";
  }

  return MyItem(
    icon: icon,
    name: data.csname.toString(),
    status: status,
    money: data.loanamount.toString(),
    time: data.createtime,
    count: data.loanamount.toString(),
    color: color,
  );
}

class FineContent extends StatefulWidget {
  final int id;
  final String icon;
  final String name;
  final String money;
  final String count;
  final String status;
  final String time;
  final Color color;
  final bool isSelect;
  final Function(bool, int, int) onChange;
  final int index;
  final bool allSelect;

  const FineContent({
    Key? key,
    required this.icon,
    required this.name,
    required this.money,
    required this.count,
    required this.status,
    required this.time,
    required this.color,
    required this.isSelect,
    required this.onChange,
    required this.index,
    required this.allSelect,
    required this.id,
  }) : super(key: key);

  @override
  _FineContentState createState() => _FineContentState();
}

class _FineContentState extends State<FineContent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.allSelect
            ? widget.onChange(false, widget.index, 1)
            : Get.toNamed(AppRoutes.FineDetail, arguments: widget.id);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h, left: 40.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.allSelect
                    ? Checkbox(
                        value: widget.isSelect,
                        shape: const CircleBorder(), //这里就是实现圆形的设置
                        onChanged: (e) {
                          widget.onChange(e!, widget.index, 0);
                        })
                    : Column(
                        children: [
                          SizedBox(
                              width: 90.w,
                              height: 90.h,
                              child: Image.asset(widget.icon))
                        ],
                      ),
                Container(
                  margin: EdgeInsets.only(top: 0.h, left: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 0.h),
                          child: Text(widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600))),
                      Text(
                          "贷款金额:  " +
                              widget.money +
                              "万 期数:  " +
                              widget.count +
                              "期",
                          style:
                              TextStyle(color: Colors.black, fontSize: 30.sp)),
                      Text(widget.time,
                          style:
                              TextStyle(color: Colors.grey, fontSize: 25.sp)),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      right: 40.w,
                    ),
                    child: Text(widget.status,
                        style:
                            TextStyle(color: widget.color, fontSize: 26.sp))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
