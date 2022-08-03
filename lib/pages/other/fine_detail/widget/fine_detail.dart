import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../common/apis/common.dart';
import '../../../../common/entities/loan/saleman_detail.dart';
import '../../../../common/services/storage.dart';
import '../../../../common/widgets/bottom_picker/bottom_picker.dart';
import '../../../../common/widgets/bottom_picker/resources/arrays.dart';
import '../../../../common/widgets/chat_picture_preview.dart';
import '../../../../common/widgets/dy_behavior_null.dart';
import '../../../../common/widgets/im_util.dart';
import '../../../../common/widgets/tabbar/buttons_tabbar.dart';
import '../../../../common/widgets/timeline/timeline.dart';
import '../../../../common/widgets/timeline/timeline_model.dart';
import 'doodle.dart';
import 'fine_item.dart';

class TimeLinePage extends StatefulWidget {
  final int loanId;

  const TimeLinePage({Key? key, required this.loanId}) : super(key: key);

  @override
  createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage>
    with SingleTickerProviderStateMixin {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  TextEditingController loanController = TextEditingController();
  FocusNode loanFieldNode = FocusNode();
  int pageIx = 0;
  List<Circulations> circulations = <Circulations>[];
  SaleManDetailDataData? detail;

  List<Doodle> doodleList = <Doodle>[];
  String roleKey = "super";
  String selectDate = "";
  int lendingNum = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  String getTitle(Circulations data) {
    String status = "";
    Color color = const Color(0xffFF6666);
    String icon = "";
    if (data.status == 1) {
      status = "待联系";
      color = const Color(0xff4DA1EE);
      icon = "assets/images/default/fine_call.png";
    }
    if (data.status == 2) {
      status = "待提交(已联系)";
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
    if (data.status == 12) {
      status = "已联系";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 13) {
      status = "已提交";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 14) {
      status = "已进件";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }

    if (data.status == 23) {
      status = "已接收";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 40) {
      status = "通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 50) {
      status = "不通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 50) {
      status = "不通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 70) {
      status = "放款中";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    return status;
  }

  _getData() async {
    roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var d = await CommonAPI.getSuperDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!.reversed.toList();
        detail = d.data!.data!;
      }
    } else if (roleKey == "director") {
      var d = await CommonAPI.getManageDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!.reversed.toList();
        detail = d.data!.data!;
      }
    } else if (roleKey == "administration") {
      var d = await CommonAPI.getAdministrativeDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!.reversed.toList();
        detail = d.data!.data!;
      }
      var d1 = await CommonAPI.getLendingDetail(widget.loanId);
      lendingNum = d1.data!.data;
    } else if (roleKey == "salesman") {
      var d = await CommonAPI.getSaleManDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!.reversed.toList();
        detail = d.data!.data!;
      }
    } else {}
    doodleList = circulations.map((e) {
      List<Pic> p = <Pic>[];
      if (e.identificationurl != "" && e.identificationurl != null) {
        p.add(Pic(
            circulationId: e.circulationid,
            picType: e.status,
            picUrl:
                "http://192.168.1.200:85" + e.identificationurl.toString()));
      }
      if (e.deedurl != "" && e.deedurl != null) {
        p.add(Pic(
            circulationId: e.circulationid,
            picType: e.status,
            picUrl: "http://192.168.1.200:85" + e.deedurl.toString()));
      }
      return Doodle(
          current: 0,
          flag: "",
          opacity: 1,
          color: Colors.white,
          name: getTitle(e),
          time: e.createtime,
          content: e.createby.toString(),
          opUser: e.remark == null ? "" : e.remark.toString(),
          address: "",
          status: "",
          doodle:
              "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4016383514,3614601022&fm=26&gp=0.jpg",
          icon: const Icon(Icons.ac_unit, color: Colors.white),
          iconBackground: Colors.transparent,
          pics: p);
    }).toList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      timelineModel(TimelinePosition.Left),
      // timelineModel(TimelinePosition.Center),
      // timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
      appBar: AppBar(title: Text('详细信息')),
      body: ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                radius: 40.w,
                contentPadding: EdgeInsets.only(left: 40.w, right: 40.w),
                backgroundColor: Colors.blue,
                unselectedBackgroundColor: Color(0xffeeeeee),
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "流程图",
                  ),
                  Tab(
                    text: "个人信息",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(
                        child: PageView(
                            onPageChanged: (i) => setState(() => pageIx = i),
                            controller: pageController,
                            children: pages)),
                    Center(
                      child: detail == null
                          ? Container()
                          : buildBase(
                              Get.context!, detail!, 1, false, (a, b) {}, ""),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  timelineModel(TimelinePosition position) => Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w),
        padding: EdgeInsets.only(bottom: 10.h),
        child: Timeline.builder(
            lineColor: Color(0xff999999),
            iconSize: 2.sp,
            itemBuilder: centerTimelineBuilder,
            itemCount: doodleList.length,
            position: position),
      );

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final doodle = doodleList[i];
    final textTheme = Theme.of(context).textTheme;
    var picListView = <PicInfo>[];
    List<Pic>? p = doodle.pics;
    List<Widget> l = <Widget>[];

    if (p != null) {
      picListView = p.map((e) {
        return PicInfo(
          url: e.picUrl,
        );
      }).toList();

      for (int i = 0; i < p.length; i++) {
        var e = p[i];
        l.add(Container(
            padding: EdgeInsets.only(right: 10.w),
            width: 120.w,
            child: GestureDetector(
                onTap: () {
                  Get.to(() => IMUtil.previewPic(
                      index: i,
                      tag: e.picUrl != ""
                          ? e.picUrl
                          : ("assets/packages/images/ic_user_none_round.png"),
                      picList: picListView));
                },
                child: Image.network(e.picUrl))));
      }
    }

    return TimelineModel(
        Card(
          color: doodle.color.withOpacity(doodle.opacity),
          margin: EdgeInsets.symmetric(
            vertical: 16.h,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          child: Stack(children: [
            Container(
              decoration: doodle.current == 1
                  ? BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2.w,
                      ),
                    )
                  : null,
              width: ScreenUtil().screenWidth - 100.w,
              child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8.h),
                          Text(doodle.name,
                              style: TextStyle(
                                  color: i == 0 ? Colors.blue : Colors.black,
                                  fontSize: 34.sp),
                              textAlign: TextAlign.left),
                          doodle.pics == null
                              ? Container()
                              : Row(
                                  children: [...l],
                                ),
                          SizedBox(height: 8.h),
                          doodle.opUser != ""
                              ? Text(doodle.opUser, style: textTheme.caption)
                              : Container(),
                          doodle.opUser != ""
                              ? SizedBox(height: 8.h)
                              : Container(),
                          doodle.content != ""
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF4F5F8),
                                      borderRadius: BorderRadius.circular(6.w)),
                                  padding: EdgeInsets.all(12.w),
                                  child: Text(doodle.content,
                                      style: textTheme.subtitle1,
                                      textAlign: TextAlign.left))
                              : Container(),
                          doodle.content != ""
                              ? SizedBox(height: 8.h)
                              : Container(),
                          Text(doodle.time, style: textTheme.caption),
                          SizedBox(height: 8.h),
                        ],
                      ),
                      i == 0 ? buildButton(doodle.name) : Container()
                    ],
                  )),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: doodle.flag != ""
                    ? Container(
                        width: 120.w,
                        child: Image.asset(doodle.flag),
                      )
                    : Container())
          ]),
        ),
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: CircleAvatar(
                  radius: 20.w,
                  backgroundColor:
                      i == 0 ? Color(0xffc5e2ff) : Color(0xffeeeeee),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: CircleAvatar(
                  radius: 8.w,
                  backgroundColor: i == 0 ? Colors.blue : Color(0xffaaaaaa),
                ),
              ),
            ],
          ),
        ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == doodleList.length,
        iconBackground: doodle.iconBackground,
        icon: doodle.icon);
  }

  Widget buildButton(String name) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        primary: Colors.blue.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.w),
        ),
        //side: BorderSide(width: 2.w, color: Colors.blue),
      ),
      child: Container(
        child: Text(
          name,
          style: TextStyle(fontSize: 30.sp, color: Colors.white),
        ),
        padding:
            EdgeInsets.only(top: 20.h, left: 35.w, bottom: 20.h, right: 35.w),
      ),
      onPressed: () {
        showDialogs(detail!);
      },
    );
  }

  showDialogs(SaleManDetailDataData data) {
    String status = "";
    Color color = const Color(0xffFF6666);
    String icon = "";
    if (data.status == 1) {
      status = "待联系";
      color = const Color(0xff4DA1EE);
      icon = "assets/images/default/fine_call.png";
      salesmanDialog("待联系");
    }
    if (data.status == 2) {
      status = "待提交(已联系)";
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
    if (data.status == 12) {
      status = "已联系";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 13) {
      status = "已提交";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 14) {
      status = "已进件";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }

    if (data.status == 23) {
      status = "已接收";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 40) {
      status = "通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 50) {
      status = "不通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 50) {
      status = "不通过";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 70) {
      status = "放款中";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
      lendingDialog("放款中");
    }
  }

  lendingDialog(String name) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loanFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: 550.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.w)),
                    ),
                    child: Stack(
                      //alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: 30.h,
                          right: 30.h,
                          child: GestureDetector(
                            onTap: () {
                              loanController.text = "";
                              selectDate = "";
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/images/btn_close_black.png',
                              width: 40.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          left: 270.w,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(name,
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 100.w, right: 80.w, top: 100.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "未放款金额：",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 32.sp),
                                    ),
                                    Text(
                                      lendingNum.toString(),
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "  万",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 32.sp),
                                    ),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 80.w, right: 80.w, top: 20.h),
                              height: 80.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                      controller: loanController,
                                      focusNode: loanFieldNode,
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w400),
                                      minLines: 7,
                                      maxLines: 7,
                                      cursorColor: Colors.blue,
                                      //cursorRadius: Radius.circular(40.h),
                                      cursorWidth: 3.w,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        suffixText: "万",
                                        suffixStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 40.sp),
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 40.w,
                                            right: 40.w,
                                            top: 20.h,
                                            bottom: 0),
                                        hintText: "本次放款金额",
                                        hintStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 32.sp),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.h)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.h)),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.h),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.h)),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.h),
                                        ),
                                      ),
                                      onChanged: (v) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                loanFieldNode.unfocus();
                                BottomPicker.date(
                                        initialDateTime:
                                            DateTime.tryParse(selectDate),
                                        height: 600.h,
                                        buttonTextStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32.sp),
                                        buttonSingleColor: Colors.green,
                                        displayButtonIcon: false,
                                        buttonText: "确定",
                                        title: "选择日期",
                                        titleStyle: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 38.sp,
                                            color: Colors.black),
                                        onChange: (index) {
                                          //print(index);
                                        },
                                        onSubmit: (index) {
                                          // print(index);
                                          state(() {
                                            selectDate =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(index);
                                          });
                                        },
                                        bottomPickerTheme:
                                            BottomPickerTheme.plumPlate)
                                    .show(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 30.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.h),
                                  border: Border.all(
                                      color: Colors.blue, width: 1), //边框
                                ),
                                height: 80.h,
                                child: Container(
                                    padding: EdgeInsets.only(left: 40.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          selectDate == ""
                                              ? "请选择放款时间"
                                              : selectDate,
                                          style: TextStyle(
                                              color: selectDate == ""
                                                  ? Colors.blue
                                                  : Colors.redAccent,
                                              fontSize: selectDate == ""
                                                  ? 32.sp
                                                  : 38.sp),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 40.h, left: 40.w, right: 40.w),
                              child: RaisedButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.h))),
                                color: Colors.lightBlue,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("提交",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 36.sp)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  salesmanDialog(String name) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loanFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: 550.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.w)),
                    ),
                    child: Stack(
                      //alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: 30.h,
                          right: 30.h,
                          child: GestureDetector(
                            onTap: () {
                              loanController.text = "";
                              selectDate = "";
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/images/btn_close_black.png',
                              width: 40.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          left: 270.w,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(name,
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await showPickerArray(
                                    context,
                                    [
                                      ["已联系", "联系中", "客户放弃", "资质不符"]
                                    ],
                                    [],
                                    "gender",
                                    detail!,
                                    "",
                                    true, (a, b) {
                                  selectDate = b;
                                  state(() {});
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 130.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.h),
                                  border: Border.all(
                                      color: Colors.blue, width: 1), //边框
                                ),
                                height: 80.h,
                                child: Container(
                                    padding: EdgeInsets.only(left: 40.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          selectDate == ""
                                              ? "请选择类型"
                                              : selectDate,
                                          style: TextStyle(
                                              color: selectDate == ""
                                                  ? Colors.blue
                                                  : Colors.redAccent,
                                              fontSize: selectDate == ""
                                                  ? 32.sp
                                                  : 38.sp),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 60.h, left: 40.w, right: 40.w),
                              child: RaisedButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.h))),
                                color: Colors.lightBlue,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("提交",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 36.sp)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
