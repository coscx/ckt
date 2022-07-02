import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/entities/home/search_erp.dart';
import '../../../../common/routers/names.dart';
import '../../../../common/utils/common.dart';
import '../../../../common/values/cons.dart';
import '../../../../common/widgets/circle_text.dart';
import '../../../../common/widgets/extend_image.dart';

class PhotoWidgetListItem extends StatelessWidget {
  final Data photo;

  PhotoWidgetListItem({
    Key? key,
    required this.photo,
  }) : super(key: key);

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        //height: 60,
        //color: Colors.blue,
        alignment: Alignment.center,

        child: Container(
            // color: Colors.blue,
            margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            child: Stack(children: <Widget>[
              Container(
                  //color: Theme.of(context).primaryColor.withAlpha(33),
                  //shape: true ? TechnoShapeBorder(color: Theme.of(context).primaryColor.withAlpha(100)) : null,
                  decoration: BoxDecoration(
//背景
                    color: const Color.fromRGBO(255, 255, 255, 100),
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.all(Radius.circular(20.h)),
                    //设置四周边框
                    //border:  Border.all(width: 1, color: Colors.red),
                  ),
                  child: Container(
                      padding: EdgeInsets.only(
                          top: 10.h, bottom: 0.h, left: 10.w, right: 10.w),
                      decoration: BoxDecoration(
//背景
                        color: const Color.fromRGBO(255, 255, 255, 100),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(20.h)),
                        //设置四周边框
                        //border:  Border.all(width: 1, color: Colors.red),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // BlocProvider.of<DetailBloc>(context)
                              //     .add(FetchWidgetDetail(photo));
                              // Navigator.pushNamed(
                              //     context, UnitRouter.widget_detail);
                               Get.toNamed(AppRoutes.OADetail,arguments: photo.uuid);
                            },
                            child: buildContent(context),
                          ),
                          //buildMiddle(context),
                        ],
                      ))),
              // _buildCollectTag(Theme.of(context).primaryColor, showBadge)
            ])),
      ),
    );
  }

  Widget buildContent(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(0.h)),
        ),
        height: 150.h,
        padding: EdgeInsets.only(top: 10.h, left: 0, right: 10.w, bottom: 0.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    buildLeading(),
                    Container(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 0.h, left: 15.h, right: 0.w, bottom: 0.h),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // _buildTitle(),
                            _titleTop(),
                            _buildMiddles(),
                            _buildSummary(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //     _makePhoneCall(photo.code);
                //   },
                //   child: Container(
                //     width: 60.h,
                //     height: 60.h,
                //     margin: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0.h),
                //     child: Lottie.asset(
                //         'assets/packages/lottie_flutter/phone-call.json'),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Widget buildLeading() => Padding(
        padding: EdgeInsets.only(top: 0.h),
        child: Container(
          //tag: "hero_widget_image_${photo['uuid'].toString()}",
          child: (photo.headImg == "")
              ? Container(
                  // width: 100.w,
                  // height: 100.h,h
                  color: Colors.transparent,
                  child: CircleText(
                    text: photo.name,
                    size: 140.w,
                    fontSize: 50.sp,
                    color: invColor,
                    //shadowColor: Colors.transparent,
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(
                      left: 0.w, bottom: 0.h, top: 0.h, right: 0.w),
                  child: CircleAvatar(
                    foregroundColor: Colors.white10,
                    radius: (70.sp),
                    child: ClipOval(
                      child: photo.headImg == ""
                          ? Container()
                          : getCacheImage(
                              photo.channel == 0
                                  ? photo.headImg
                                  : (photo.esAge != ""
                                      ? photo.esAge
                                      : photo.headImg),
                            ),
                    ),
                  ),
                ),
        ),
      );

  Color get invColor {
    return Colors.lightBlue;
  }

  Widget _titleTop() {
    String level = getLevel(photo.status);
    return Padding(
      padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 0.h),
      child: Text(photo.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(color: Colors.white, offset: Offset(.3, .3))
              ])),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Text(
        (photo.connectStatus > -1 ? getConnectStatus(photo) + " | " : "") +
            photo.createdAt.toString(),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontSize: 26.sp,
            shadows: const [
              Shadow(color: Colors.white, offset: Offset(.5, .5))
            ]),
      ),
    );
  }

  String getConnectStatus(Data photo) {
    String statusName = "";
    if (photo.connectStatus == 0) {
      statusName = "AI初访";
    }
    if (photo.connectStatus == 1) {
      statusName = "新分未联系";
    }
    if (photo.connectStatus == 2) {
      statusName = "号码无效";
    }
    if (photo.connectStatus == 3) {
      statusName = "号码未接通";
    }
    if (photo.connectStatus == 4) {
      statusName = "可继续沟通";
    }
    if (photo.connectStatus == 5) {
      statusName = "有意向面谈";
    }
    if (photo.connectStatus == 6) {
      statusName = "已到店";
    }
    if (photo.connectStatus == 7) {
      statusName = "已成交";
    }
    if (photo.connectStatus == 12) {
      statusName = "公海";
    }
    return statusName;
  }

  Widget _buildMiddles() {
    bool isVip = false;
    bool expire = false;
    String statusName = "";
    if (photo.status == 0) {
      statusName = "C级";
    } else if (photo.status == 1) {
      statusName = "B级";
    } else if (photo.status == 2) {
      statusName = "A级";
    } else if (photo.status == -1) {
      statusName = "公海";
    } else {
      statusName = "C级";
    }
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
          child: Container(
              padding:
                  EdgeInsets.only(top: 3.h, bottom: 3.h, left: 8.w, right: 8.w),
              decoration: BoxDecoration(
                //背景
                color: Colors.lightBlueAccent.withOpacity(0.1),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(2.h)),
                //设置四周边框
                //border: new Border.all(width: 1, color: Colors.red),
              ),
              child: (Text(
                //尾部摘要
                (statusName), maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 23.sp,
                    shadows: const [
                      Shadow(color: Colors.white, offset: Offset(.5, .5))
                    ]),
              ))),
        ),
        SizedBox(
          width: 10.w,
        ),
        Padding(
          padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
          child: Container(
              padding:
                  EdgeInsets.only(top: 3.h, bottom: 3.h, left: 8.w, right: 8.w),
              decoration: BoxDecoration(
                //背景
                color: Colors.lightBlueAccent.withOpacity(0.1),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(2.h)),
                //设置四周边框
                //border: new Border.all(width: 1, color: Colors.red),
              ),
              child: (Text(
                //尾部摘要
                "沟通"+(photo.connectCount.toString())+"次", maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 23.sp,
                    shadows: const [
                      Shadow(color: Colors.white, offset: Offset(.5, .5))
                    ]),
              ))),
        ),
      ],
    );
  }
}
