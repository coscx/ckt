import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_ckt/common/entities/loan/loan.dart';
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
MyItem getStatus(Data data) {
  String status = "";
  Color color = const Color(0xffFF6666);
  String icon = "";

  if (data.status == 9) {
    status = "放款失败";
    color = const Color(0xff4CD070);
    icon = "assets/images/default/fine_fail.png";

  }
  if (data.status == 11) {
    status = "资质不符";
    color = const Color(0xff4CD070);
    icon = "assets/images/default/fine_no.png";
  }
  if (data.status == 10) {
    status = "客户放弃";
    color = const Color(0xff6360CA);
    icon = "assets/images/default/fine_lost.png";
  }
  if (data.status == 1) {
    status = "联系中";
    color = const Color(0xff4DA1EE);
    icon = "assets/images/default/fine_call.png";
  }
  if (data.status == 8) {
    status = "已放款";
    color = const Color(0xffD8AA0F);
    icon = "assets/images/default/fine_success.png";
  }
  return MyItem(
    icon: icon,
    name: data.csName,
    status: status,
    money: data.loanAmount.toString(),
    time: data.submitTime,
    count: data.loanCycle.toString(),
    color: color,
  );
}
class FineContent extends StatefulWidget {
  final String icon;
  final String name;
  final String money;
  final String count;
  final String status;
  final String time;
  final Color color;

  const FineContent(
      {Key? key, required this.icon,
        required this.name,
        required this.money,
        required this.count,
        required this.status,
        required this.time,
        required this.color}) : super(key: key);

  @override
  _FineContentState createState() => _FineContentState();
}

class _FineContentState extends State<FineContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, left: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                        style: TextStyle(
                            color: Colors.black, fontSize: 30.sp)),
                    Text(widget.time,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 25.sp)),
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
                      style: TextStyle(color: widget.color, fontSize: 26.sp))),
            ],
          ),
        ],
      ),
    );
  }
}