import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';
import 'package:flutter_ckt/pages/oa/user_detail/widget/common_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../common/apis/common.dart';
import '../../../../common/entities/loan/saleman_detail.dart';
import '../../../../common/services/storage.dart';
import '../../../../common/utils/common.dart';
import '../../../../common/values/server.dart';
import '../../../../common/widgets/bottom_picker/bottom_picker.dart';
import '../../../../common/widgets/bottom_picker/resources/arrays.dart';
import '../../../../common/widgets/chat_picture_preview.dart';
import '../../../../common/widgets/checkbox/src/msh_checkbox.dart';
import '../../../../common/widgets/checkbox/src/msh_checkbox_style.dart';
import '../../../../common/widgets/dy_behavior_null.dart';
import '../../../../common/widgets/extend_image.dart';
import '../../../../common/widgets/im_util.dart';
import '../../../../common/widgets/tabbar/buttons_tabbar.dart';
import '../../../../common/widgets/timeline/timeline.dart';
import '../../../../common/widgets/timeline/timeline_model.dart';
import '../../../home/logic.dart';
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

  TextEditingController remarkController = TextEditingController();
  FocusNode remarkFieldNode = FocusNode();

  TextEditingController bankController = TextEditingController();
  FocusNode bankFieldNode = FocusNode();

  TextEditingController managerController = TextEditingController();
  FocusNode managerFieldNode = FocusNode();

  TextEditingController actualController = TextEditingController();
  FocusNode actualFieldNode = FocusNode();

  TextEditingController thisController = TextEditingController();
  FocusNode thisFieldNode = FocusNode();

  TextEditingController loaningController = TextEditingController();
  FocusNode loaningFieldNode = FocusNode();

  GlobalKey status4Key = GlobalKey();
  int pageIx = 0;
  List<Circulations> circulations = <Circulations>[];
  SaleManDetailDataData? detail;
  List<Doodle> doodleList = <Doodle>[];
  String roleKey = "super";
  String selectDate = "";
  int lendingNum = 0;
  bool showRemark = false;
  bool isChecked = false;
  String creditPath = "";
  String housePath = "";
  bool showAuditCheck = false;
  String showAuditCheckResult = "";
  bool showLoaning = false;
  String loaningDate = "";

  @override
  void initState() {
    _getData();
    super.initState();
  }

  String getTitle(Circulations data) {
    String status = "";
    if (data.status == 1) {
      status = "待联系";
    }
    if (data.status == 2) {
      status = "待提交(已联系)";
    }
    if (data.status == 3) {
      status = "待进件";
    }
    if (data.status == 4) {
      status = "待审批";
    }
    if (data.status == 5) {
      status = "待补件";
    }
    if (data.status == 6) {
      status = "待风控";
    }
    if (data.status == 7) {
      status = "待放款";
    }
    if (data.status == 8) {
      status = "已放款";
    }
    if (data.status == 9) {
      status = "放款失败";
    }
    if (data.status == 10) {
      status = "客户放弃";
    }
    if (data.status == 11) {
      status = "资质不符";
    }
    if (data.status == 12) {
      status = "已联系";
    }
    if (data.status == 13) {
      status = "已提交";
    }
    if (data.status == 14) {
      status = "已进件";
    }
    if (data.status == 23) {
      status = "已接收";
    }
    if (data.status == 40) {
      status = "通过";
    }
    if (data.status == 50) {
      status = "不通过";
    }
    if (data.status == 50) {
      status = "不通过";
    }
    if (data.status == 60) {
      status = "联系中";
    }
    if (data.status == 70) {
      status = "放款中";
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
            circulationId: checkNull(e.circulationid) ? 0 : e.circulationid,
            picType: 1,
            picUrl: NEW_JAVA_SERVER_API_URL + e.identificationurl.toString()));
      }
      if (e.deedurl != "" && e.deedurl != null) {
        p.add(Pic(
            circulationId: checkNull(e.circulationid) ? 0 : e.circulationid,
            picType: 1,
            picUrl: NEW_JAVA_SERVER_API_URL + e.deedurl.toString()));
      }
      return Doodle(
        current: 0,
        flag: "",
        opacity: 1,
        color: Colors.white,
        name: getTitle(e),
        icon: const Icon(Icons.ac_unit, color: Colors.white),
        iconBackground: Colors.transparent,
        pics: p,
        auditResult: '',
        loanResult: '',
        bankAddress: '',
        bankManager: '',
        auditTime: checkNull(e.credit) ? "" : e.credit!.createtime,
        operateTime: checkNull(e.credit) ? "" : e.credit!.createtime,
        commitTime: checkNull(e.credit) ? "" : e.credit!.createtime,
        receiveTime: checkNull(e.credit) ? "" : e.credit!.createtime,
        thisLoanTime: checkNull(e.credit) ? "" : e.credit!.createtime,
        lendingLoanAmount: '',
        thisLoanAmount: '',
        commitUser: checkNull(e.credit) ? "" : e.credit!.createtime,
        auditUser: checkNull(e.credit) ? "" : e.credit!.createtime,
        operateUser: '',
      );
    }).toList();
    if (mounted) setState(() {});
  }

  changeSalesmanStatus(int loanId, int status, String remark) async {
    var d = await CommonAPI.changeSaleManStepStatus(
        {"loanId": loanId, "status": status, "remark": remark});
    if (d.code == 200) {
      bool gg = Get.isRegistered<HomeLogic>();
      if (gg) {
        var homeLogic = Get.find<HomeLogic>();
        homeLogic.onRefresh();
      }
      _getData();
      Navigator.of(context).pop();
    } else {
      showToastRed(Get.context!, d.msg, true);
    }
  }

  auditAdmin(int loanId, int status, String remark) async {
    var d = await CommonAPI.auditAdministrativeStepStatus(
        {"loanId": loanId, "status": status, "remark": remark});
    if (d.code == 200) {
      bool gg = Get.isRegistered<HomeLogic>();
      if (gg) {
        var homeLogic = Get.find<HomeLogic>();
        homeLogic.onRefresh();
      }
      _getData();
      Navigator.of(context).pop();
    } else {
      showToastRed(Get.context!, d.msg, true);
    }
  }

  changeAdminStatus(int loanId, int status, String remark) async {
    var d = await CommonAPI.changeAdministrativeStepStatus({
      "loanId": loanId,
      "status": status,
      "deedUrl": housePath,
      "identificationUrl": creditPath,
      "accountManager": managerController.text,
      "bankBranch": bankController.text,
    });
    if (d.code == 200) {
      bool gg = Get.isRegistered<HomeLogic>();
      if (gg) {
        var homeLogic = Get.find<HomeLogic>();
        homeLogic.onRefresh();
      }
      _getData();
      creditPath = "";
      housePath = "";
      managerController.text = "";
      bankController.text = "";
      Navigator.of(context).pop();
    } else {
      showToastRed(Get.context!, d.msg, true);
    }
  }

  changeAdminAwaitLoaningStatus(int loanId, int status, String remark) async {
    var d = await CommonAPI.changeAdministrativeStepStatus({
      "loanId": loanId,
      "status": status,
      "realAmount": actualController.text,
      "credit": {"creditAmount": thisController.text, "createTime": loaningDate}
    });
    if (d.code == 200) {
      bool gg = Get.isRegistered<HomeLogic>();
      if (gg) {
        var homeLogic = Get.find<HomeLogic>();
        homeLogic.onRefresh();
      }
      _getData();
      Navigator.of(context).pop();
    } else {
      showToastRed(Get.context!, d.msg, true);
    }
  }

  changeAdminLoaningStatus(int loanId, int status, String remark) async {
    var d = await CommonAPI.changeAdministrativeStepStatus({
      "loanId": loanId,
      "status": status,
      "credit": {
        "creditAmount": loaningController.text,
        "createTime": selectDate
      }
    });
    if (d.code == 200) {
      bool gg = Get.isRegistered<HomeLogic>();
      if (gg) {
        var homeLogic = Get.find<HomeLogic>();
        homeLogic.onRefresh();
      }
      _getData();
      loaningController.text = "";
      selectDate = "";
      Navigator.of(context).pop();
    } else {
      showToastRed(Get.context!, d.msg, true);
    }
  }

  Future<String?> uploadImg() async {
    List<AssetEntity> asset = <AssetEntity>[];
    var assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        textDelegate: const AssetPickerTextDelegate(),
        maxAssets: 1,
        selectedAssets: asset,
        pickerTheme: AssetPicker.themeData(
          Colors.lightBlueAccent,
          light: true,
        ),
      ),
    );
    if (assets != null) {
      var imageFile = assets.first;
      File? file = await imageFile.file;
      if (file?.path != null) {
        var d = await CommonAPI.uploadCktFile(file!.path);
        if (d.data != null&& d.data!.data != null) {
          return d.data!.data!.filename;
        }
      }
    }
    return "";
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
            height: 160.w,
            child: GestureDetector(
                onTap: () {
                  Get.to(() => IMUtil.previewPic(
                      index: i,
                      tag: e.picUrl != ""
                          ? e.picUrl
                          : ("assets/packages/images/ic_user_none_round.png"),
                      picList: picListView));
                },
                child: getCacheImage(e.picUrl))));
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
                      getCard(l, i, circulations[i], detail!),
                      i == 0 ? buildButton(doodle.name,(){
                        showDialogs(detail!);
                      }) : Container()
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

  Widget getCard(
      List<Widget> l, int i, Circulations doodle, SaleManDetailDataData data) {
    var status = doodle.status;

    if (status == 5) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              children: [
                Text(
                  "补件人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xfff4f5f8),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            width: 350.w,
            child: Text(
              checkNull(doodle.remark) ? "暂无" : doodle.remark.toString(),
              style: TextStyle(color: Color(0xff4a4a5a), fontSize: 24.sp),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Row(
              children: [
                Text(
                  "接收时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }

    if (status == 23) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "提交人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby) ? "暂无" : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.updateby) ? "暂无" : doodle.updateby!,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "接收时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (status == 60) {
      String d = "联系中";
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              d,
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
    }
    if (status == 1) {
      String d = "";
      if (doodle.step == 1) {
        d = "获取客户";
      }
      if (doodle.step == 2) {
        d = "待联系";
      }
      String dd = "";
      if (data.origin == 1) {
        dd = "超管划分";
      }
      if (data.origin == 2) {
        dd = "主管划分";
      }
      if (data.origin == 3) {
        dd = data.channel!.cnname;
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              d,
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          doodle.step == 1
              ? Container(
                  child: Row(
                    children: [
                      Text(
                        "来源渠道: ",
                        style: TextStyle(color: Colors.black, fontSize: 24.sp),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        dd,
                        style: TextStyle(color: Colors.black, fontSize: 24.sp),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              : Container(),
          doodle.step == 1
              ? Container(
                  child: Row(
                    children: [
                      Text(
                        "获取时间: ",
                        style: TextStyle(color: Colors.black, fontSize: 24.sp),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                        style: TextStyle(color: Colors.black, fontSize: 24.sp),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      );
    }

    if (status == 2) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
    }

    if (status == 3) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby) ? "暂无" : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (status == 12) {
      String d = "已联系";

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              d,
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "联系时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }
    if (status == 13) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "提交人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.updateby)
                      ? "暂无"
                      : doodle.updateby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xfff4f5f8),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            width: 350.w,
            child: Text(
              checkNull(doodle.remark) ? "暂无" : doodle.remark.toString(),
              style: TextStyle(color: Color(0xff4a4a5a), fontSize: 24.sp),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }
    if (status == 14) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby) ? "暂无" : doodle.createby,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行网点: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.bankbranch) ? "暂无" : data.bankbranch,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行客户经理: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.accountmanager) ? "暂无" : data.accountmanager,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          doodle.identificationurl == null
              ? Container()
              : Row(
                  children: [...l],
                ),
          Container(
            child: Row(
              children: [
                Text(
                  "提交时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }

    if (status == 4) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby) ? "暂无" : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (status == 40 || status == 50) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批结果: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.status)
                      ? "暂无"
                      : (doodle.status == 40 ? "通过" : "不通过"),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xfff4f5f8),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            width: 350.w,
            child: Text(
              checkNull(doodle.remark) ? "暂无" : doodle.remark.toString(),
              style: TextStyle(color: Color(0xff4a4a5a), fontSize: 24.sp),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }

    if (status == 7) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby) ? "暂无" : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "放款状况: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "待放款",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行网点: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.bankbranch) ? "暂无" : data.bankbranch,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行客户经理: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.accountmanager) ? "暂无" : data.accountmanager,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
    if (status == 8) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "累计放款金额： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.credit)
                      ? "暂无"
                      : doodle.credit!.cumulativeamount.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "万元",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "放款状况: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "已放款",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行网点: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.bankbranch) ? "暂无" : data.bankbranch,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行客户经理: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.accountmanager) ? "暂无" : data.accountmanager,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }
    if (status == 10) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),

          Container(
            child: Row(
              children: [
                Text(
                  "提交人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "是否办理: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "客户放弃",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xfff4f5f8),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            width: 320.w,
            child: Text(
              checkNull(doodle.remark) ? "暂无" : doodle.remark.toString(),
              style: TextStyle(color: Color(0xff4a4a5a), fontSize: 24.sp),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }
    if (status == 11) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),

          Container(
            child: Row(
              children: [
                Text(
                  "审批人: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createby)
                      ? "暂无"
                      : doodle.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "审批结果: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "资质不符",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xfff4f5f8),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
            width: 320.w,
            child: Text(
              checkNull(doodle.remark) ? "暂无" : doodle.remark.toString(),
              style: TextStyle(color: Color(0xff4a4a5a), fontSize: 24.sp),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "耗时: ",
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.timeconsuming) ? "暂无" : doodle.timeconsuming,
                  style: TextStyle(color: Colors.green, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )
        ],
      );
    }
    if (status == 70) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              getTitle(doodle),
              style: TextStyle(
                  color: i == 0 ? Colors.blue : Colors.black, fontSize: 34.sp),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "本次放款金额： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.credit)
                      ? "暂无"
                      : doodle.credit!.creditamount.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "万元",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "本次放款时间： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.credit)
                      ? "暂无"
                      : doodle.credit!.createtime.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "累计放款金额： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.credit)
                      ? "暂无"
                      : doodle.credit!.cumulativeamount.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "万元",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作人： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.credit)
                      ? "暂无"
                      : doodle.credit!.createby.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "放款状况： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "放款中",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行网点： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.bankbranch) ? "暂无" : data.bankbranch,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "银行客户经理： ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(data.accountmanager) ? "暂无" : data.accountmanager,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text(
                  "操作时间: ",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
                Text(
                  checkNull(doodle.createtime) ? "暂无" : doodle.createtime,
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildButton(String name ,Function  call) {
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
        call(detail!);
      },
    );
  }

  showDialogs(SaleManDetailDataData data) {
    if (data.status == 1) {
      salesmanStatus160Dialog("待联系", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
    if (data.status == 2) {
      salesmanStatus2Dialog(
          "待提交(已联系)",
          checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
    if (data.status == 3) {
      salesmanStatus4Dialog("待进件", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
    if (data.status == 4) {
      salesmanStatusAuditDialog("待审批", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
    if (data.status == 5) {
      salesmanStatus5Dialog("待补件", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
    if (data.status == 6) {}
    if (data.status == 7) {
      salesmanStatusAwaitLoaningDialog(
          "待放款",
          checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }

    if (data.status == 8) {}
    if (data.status == 9) {}
    if (data.status == 10) {}
    if (data.status == 11) {}
    if (data.status == 12) {}
    if (data.status == 13) {}
    if (data.status == 14) {}

    if (data.status == 23) {}
    if (data.status == 40) {}
    if (data.status == 50) {}
    if (data.status == 50) {}
    if (data.status == 60) {
      salesmanStatus160Dialog("联系中", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }

    if (data.status == 70) {
      lendingDialog("放款中", checkNull(data.loanid) ? 0 : data.loanid,
          checkNull(data.status) ? 0 : data.status);
    }
  }

  lendingDialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loaningFieldNode.unfocus();
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
                              loaningController.text = "";
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
                                      controller: loaningController,
                                      focusNode: loaningFieldNode,
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
                                loaningFieldNode.unfocus();
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
                              child: ElevatedButton(
                                onPressed: () {
                                  status = 70;
                                  changeAdminLoaningStatus(
                                      loanId, status, remarkController.text);
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

  salesmanStatus5Dialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loanFieldNode.unfocus();
                remarkFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: 580.h,
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
                                    left: 100.w, right: 80.w, top: 120.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "审核不通过原因：",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 32.sp),
                                    ),
                                    Text(
                                      detail!.remark.toString(),
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 80.w, right: 80.w, top: 20.h),
                              height: 200.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.text,
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
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 40.w,
                                            right: 40.w,
                                            top: 20.h,
                                            bottom: 0),
                                        hintText: "请输入备注",
                                        hintStyle: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 32.sp),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.h)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.h)),
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.h),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.h)),
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
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 30.h, left: 40.w, right: 40.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  status = 4;
                                  changeSalesmanStatus(
                                      loanId, status, remarkController.text);
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

  salesmanStatus160Dialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loanFieldNode.unfocus();
                remarkFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: showRemark ? 580.h : 380.h,
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
                                  if (a > 1) {
                                    showRemark = true;
                                  } else {
                                    showRemark = false;
                                  }
                                  state(() {});
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 110.h),
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
                            showRemark
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 80.w, right: 80.w, top: 20.h),
                                    height: 200.h,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.text,
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
                                              isCollapsed: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 40.w,
                                                  right: 40.w,
                                                  top: 20.h,
                                                  bottom: 0),
                                              hintText: "请输入备注",
                                              hintStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 32.sp),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                            ),
                                            onChanged: (v) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 30.h, left: 40.w, right: 40.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectDate == "已联系") {
                                    status = 2;
                                  }
                                  if (selectDate == "联系中") {
                                    status = 60;
                                  }
                                  if (selectDate == "客户放弃") {
                                    status = 10;
                                  }
                                  if (selectDate == "资质不符") {
                                    status = 11;
                                  }
                                  changeSalesmanStatus(
                                      loanId, status, remarkController.text);
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

  salesmanStatus2Dialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                loanFieldNode.unfocus();
                remarkFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: showRemark ? 580.h : 380.h,
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
                                  top: 130.h, left: 100.w, right: 40.w),
                              child: Row(
                                children: [
                                  Container(
                                    child: MSHCheckbox(
                                      size: 60.w,
                                      value: isChecked,
                                      checkedColor: Colors.blue,
                                      style: MSHCheckboxStyle.fillScaleColor,
                                      onChanged: (selected) {
                                        state(() {
                                          isChecked = selected;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20.w),
                                    child: Text("客户基础资料已全部收集",
                                        style: TextStyle(
                                            fontSize: 36.sp,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 60.h, left: 40.w, right: 40.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!isChecked) {
                                    showToastRed(
                                        Get.context!, "请勾选后再提交请求", true);
                                    return;
                                  }
                                  status = 3;
                                  changeSalesmanStatus(
                                      loanId, status, remarkController.text);

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

  salesmanStatus4Dialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(
              key: status4Key,
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    managerFieldNode.unfocus();
                    bankFieldNode.unfocus();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().screenWidth * 0.95,
                        height: 800.h,
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
                                      left: 80.w, right: 80.w, top: 120.h),
                                  height: 80.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          autofocus: false,
                                          controller: bankController,
                                          focusNode: bankFieldNode,
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
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.only(
                                                left: 40.w,
                                                right: 40.w,
                                                top: 20.h,
                                                bottom: 0),
                                            hintText: "请输入银行网点",
                                            hintStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 32.sp),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.h),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.h),
                                            ),
                                          ),
                                          onChanged: (v) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 80.w, right: 80.w, top: 20.h),
                                  height: 80.h,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          autofocus: false,
                                          controller: managerController,
                                          focusNode: managerFieldNode,
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
                                            isCollapsed: true,
                                            contentPadding: EdgeInsets.only(
                                                left: 40.w,
                                                right: 40.w,
                                                top: 20.h,
                                                bottom: 0),
                                            hintText: "请输入银行客户经理",
                                            hintStyle: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 32.sp),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.h),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.h)),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2.h),
                                            ),
                                          ),
                                          onChanged: (v) {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? path = await uploadImg();
                                    if (path != null && path !="") {
                                      creditPath = path;
                                      state(() {});
                                    }else{
                                      showToastRed(Get.context!, "上传失败", true);
                                    }

                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 80.w, right: 10.w, top: 40.h),
                                    child: Row(
                                      children: [
                                        Text("上传身份证照片",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 36.sp)),
                                        creditPath == ""
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(left: 50.w),
                                                child: Image.asset(
                                                  "assets/images/add.png",
                                                  width: 100.w,
                                                  height: 100.h,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(left: 50.w),
                                                child: Image.network(
                                                  NEW_JAVA_SERVER_API_URL +
                                                      creditPath,
                                                  width: 100.w,
                                                  height: 100.h,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    String? path = await uploadImg();
                                    if (path != null && path!="") {
                                      housePath = path;
                                    }else{
                                      showToastRed(Get.context!, "上传失败", true);
                                    }
                                    state(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 80.w, right: 10.w, top: 40.h),
                                    child: Row(
                                      children: [
                                        Text("上传房产证照片",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 36.sp)),
                                        housePath == ""
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(left: 50.w),
                                                child: Image.asset(
                                                  "assets/images/add.png",
                                                  width: 100.w,
                                                  height: 100.h,
                                                ),
                                              )
                                            : Container(
                                                padding:
                                                    EdgeInsets.only(left: 50.w),
                                                child: Image.network(
                                                  NEW_JAVA_SERVER_API_URL +
                                                      housePath,
                                                  width: 100.w,
                                                  height: 100.h,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  height: 80.h,
                                  margin: EdgeInsets.only(
                                      top: 70.h, left: 40.w, right: 40.w),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (creditPath == "" && housePath == "") {
                                        showToastRed(
                                            Get.context!, "请上传身份证", true);
                                        return;
                                      }
                                      if (bankController.text == "") {
                                        showToastRed(
                                            Get.context!, "请填写银行网点", true);
                                        return;
                                      }
                                      if (managerController.text == "") {
                                        showToastRed(
                                            Get.context!, "请填写银行客户经理", true);
                                        return;
                                      }
                                      status = 4;
                                      changeAdminStatus(loanId, status,
                                          remarkController.text);
                                    },
                                    child: Text("提交",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36.sp)),
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

  salesmanStatusAuditDialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                remarkFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height:
                        showAuditCheck ? 680.h : (showRemark ? 580.h : 380.h),
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
                              remarkController.text = "";
                              showRemark = false;
                              showAuditCheck = false;
                              showAuditCheckResult = "";
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
                                remarkFieldNode.unfocus();
                                await showPickerArray(
                                    context,
                                    [
                                      ["通过", "不通过", "客户放弃"]
                                    ],
                                    [],
                                    "gender",
                                    detail!,
                                    "",
                                    true, (a, b) {
                                  selectDate = b;
                                  if (a == 0) {
                                    showRemark = false;
                                    showAuditCheck = false;
                                  }
                                  if (a == 1) {
                                    showRemark = true;
                                    showAuditCheck = true;
                                  }
                                  if (a == 2) {
                                    showRemark = true;
                                    showAuditCheck = false;
                                  }

                                  state(() {});
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 110.h),
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
                            showAuditCheck
                                ? GestureDetector(
                                    onTap: () async {
                                      remarkFieldNode.unfocus();
                                      await showPickerArray(
                                          context,
                                          [
                                            ["是", "否"]
                                          ],
                                          [],
                                          "gender",
                                          detail!,
                                          "",
                                          true, (a, b) {
                                        showAuditCheckResult = b;
                                        state(() {});
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 80.w, right: 80.w, top: 30.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(40.h),
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
                                                showAuditCheckResult == ""
                                                    ? "请选择是否需要补件"
                                                    : showAuditCheckResult,
                                                style: TextStyle(
                                                    color:
                                                        showAuditCheckResult ==
                                                                ""
                                                            ? Colors.blue
                                                            : Colors.redAccent,
                                                    fontSize:
                                                        showAuditCheckResult ==
                                                                ""
                                                            ? 32.sp
                                                            : 38.sp),
                                              ),
                                            ],
                                          )),
                                    ),
                                  )
                                : Container(),
                            showRemark
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 80.w, right: 80.w, top: 20.h),
                                    height: 200.h,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.text,
                                            autofocus: false,
                                            controller: remarkController,
                                            focusNode: remarkFieldNode,
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
                                              isCollapsed: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 40.w,
                                                  right: 40.w,
                                                  top: 20.h,
                                                  bottom: 0),
                                              hintText: "请输入备注",
                                              hintStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 32.sp),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                            ),
                                            onChanged: (v) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 30.h, left: 40.w, right: 40.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectDate == "通过") {
                                    status = 7;
                                  }
                                  if (selectDate == "不通过") {
                                    if (showAuditCheckResult == "是") {
                                      status = 5;
                                    }
                                    if (showAuditCheckResult == "否") {
                                      status = 11;
                                    }
                                  }
                                  if (selectDate == "客户放弃") {
                                    status = 10;
                                  }
                                  auditAdmin(
                                      loanId, status, remarkController.text);
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

  salesmanStatusAwaitLoaningDialog(String name, int loanId, int status) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              onTap: () {
                actualFieldNode.unfocus();
                thisFieldNode.unfocus();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.95,
                    height: showLoaning ? 680.h : (showRemark ? 580.h : 380.h),
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
                              actualFieldNode.unfocus();
                              thisFieldNode.unfocus();
                              actualController.text = "";
                              thisController.text = "";
                              selectDate = "";
                              loaningDate = "";
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
                                      ["放款中", "放款失败", "客户放弃"]
                                    ],
                                    [],
                                    "gender",
                                    detail!,
                                    "",
                                    true, (a, b) {
                                  selectDate = b;
                                  if (a == 0) {
                                    showLoaning = true;
                                    showRemark = false;
                                  }
                                  if (a == 1) {
                                    showLoaning = false;
                                    showRemark = true;
                                  }
                                  if (a == 2) {
                                    showLoaning = false;
                                    showRemark = true;
                                  }
                                  state(() {});
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 110.h),
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
                            showRemark
                                ? Container(
                                    margin: EdgeInsets.only(
                                        left: 80.w, right: 80.w, top: 20.h),
                                    height: 200.h,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            keyboardType: TextInputType.text,
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
                                              isCollapsed: true,
                                              contentPadding: EdgeInsets.only(
                                                  left: 40.w,
                                                  right: 40.w,
                                                  top: 20.h,
                                                  bottom: 0),
                                              hintText: "请输入备注",
                                              hintStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 32.sp),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12.h)),
                                                borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.h),
                                              ),
                                            ),
                                            onChanged: (v) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            showLoaning
                                ? Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 80.w, right: 80.w, top: 20.h),
                                        height: 80.h,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                autofocus: false,
                                                controller: actualController,
                                                focusNode: actualFieldNode,
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 40.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 40.w,
                                                          right: 40.w,
                                                          top: 20.h,
                                                          bottom: 0),
                                                  hintText: "本次放款金额",
                                                  hintStyle: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 32.sp),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.h),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.h),
                                                  ),
                                                ),
                                                onChanged: (v) {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 80.w, right: 80.w, top: 20.h),
                                        height: 80.h,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                autofocus: false,
                                                controller: thisController,
                                                focusNode: thisFieldNode,
                                                style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 40.sp,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 40.w,
                                                          right: 40.w,
                                                          top: 20.h,
                                                          bottom: 0),
                                                  hintText: "本次放款金额",
                                                  hintStyle: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 32.sp),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.h),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                40.h)),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 2.h),
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
                                                      DateTime.tryParse(
                                                          selectDate),
                                                  height: 600.h,
                                                  buttonTextStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 32.sp),
                                                  buttonSingleColor:
                                                      Colors.green,
                                                  displayButtonIcon: false,
                                                  buttonText: "确定",
                                                  title: "选择日期",
                                                  titleStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 38.sp,
                                                      color: Colors.black),
                                                  onChange: (index) {
                                                    //print(index);
                                                  },
                                                  onSubmit: (index) {
                                                    // print(index);
                                                    state(() {
                                                      loaningDate = DateFormat(
                                                              "yyyy-MM-dd")
                                                          .format(index);
                                                    });
                                                  },
                                                  bottomPickerTheme:
                                                      BottomPickerTheme
                                                          .plumPlate)
                                              .show(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 80.w,
                                              right: 80.w,
                                              top: 30.h),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(40.h),
                                            border: Border.all(
                                                color: Colors.blue,
                                                width: 1), //边框
                                          ),
                                          height: 80.h,
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 40.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    loaningDate == ""
                                                        ? "请选择放款时间"
                                                        : loaningDate,
                                                    style: TextStyle(
                                                        color: loaningDate == ""
                                                            ? Colors.blue
                                                            : Colors.redAccent,
                                                        fontSize:
                                                            loaningDate == ""
                                                                ? 32.sp
                                                                : 38.sp),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin: EdgeInsets.only(
                                  top: 30.h, left: 40.w, right: 40.w),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectDate == "放款中") {
                                    status = 70;
                                  }
                                  if (selectDate == "放款失败") {
                                    status = 9;
                                  }
                                  if (selectDate == "客户放弃") {
                                    status = 10;
                                  }
                                  changeAdminAwaitLoaningStatus(
                                      loanId, status, remarkController.text);
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
