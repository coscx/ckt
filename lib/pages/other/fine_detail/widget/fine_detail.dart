import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/apis/common.dart';
import '../../../../common/entities/loan/saleman_detail.dart';
import '../../../../common/services/storage.dart';
import '../../../../common/widgets/chat_picture_preview.dart';
import '../../../../common/widgets/dy_behavior_null.dart';
import '../../../../common/widgets/im_util.dart';
import '../../../../common/widgets/timeline/timeline.dart';
import '../../../../common/widgets/timeline/timeline_model.dart';
import 'doodle.dart';

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
  int pageIx = 0;
  List<Circulations> circulations = <Circulations>[];

  List<Doodle> doodleList = <Doodle>[];
  String roleKey = "super";

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

    return status;
  }

  _getData() async {
    roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var d = await CommonAPI.getSuperDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!;
      }
    } else if (roleKey == "director") {
      var d = await CommonAPI.getManageDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!;
      }
    } else if (roleKey == "administration") {
      var d = await CommonAPI.getAdministrativeDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!;
      }
    } else if (roleKey == "salesman") {
      var d = await CommonAPI.getSaleManDetail(widget.loanId);
      if (d.data != null && d.data?.data != null) {
        circulations = d.data!.data!.circulations!;
      }
    } else {}
    doodleList = circulations.map((e) {
      List<Pic> p = <Pic>[];
      if (e.identificationurl != "" && e.identificationurl != null) {
        p.add(Pic(
            circulationId: e.circulationid,
            picType: e.status,
            picUrl: "http://192.168.1.200:85" + e.identificationurl.toString()));
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
          opUser: e.remark==null?"":e.remark.toString() ,
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
      timelineModel(TimelinePosition.Center),
      timelineModel(TimelinePosition.Right)
    ];

    return Scaffold(
      appBar: AppBar(title: Text('流程图')),
      body: ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child: PageView(
              onPageChanged: (i) => setState(() => pageIx = i),
              controller: pageController,
              children: pages)),
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
                  child: Column(
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
                      doodle.opUser != "" ? SizedBox(height: 8.h) : Container(),
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
}
