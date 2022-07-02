
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/routers/pages.dart';
import 'package:flutter_ckt/pages/user_detail/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/entities/home/search_erp.dart';
import '../../../common/routers/names.dart';
import '../../../common/utils/common.dart';
import '../../../common/values/cons.dart';
import '../../../common/widgets/circle_text.dart';
import '../../../common/widgets/extend_image.dart';

class PhotoSearchWidgetListItemAppoint extends StatelessWidget {
  final Data photo;
  final int isAppoint;
  PhotoSearchWidgetListItemAppoint({
    required this.photo, required this.isAppoint,
  });

  final List<int> colors = Cons.tabColors;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                decoration:  BoxDecoration(
//背景
                  color: const Color.fromRGBO(255, 255, 255, 100),
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(20.h)),
                  //设置四周边框
                  //border:  Border.all(width: 1, color: Colors.red),
                ),
                child: Container(
                    padding: EdgeInsets.only(
                        top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                    decoration:  BoxDecoration(
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
                              Navigator.pop(context,photo.uuid+"#"+photo.name);
                          },
                          child: buildContent(context),
                        ),
                        //buildMiddle(context),
                      ],
                    ))),
            // _buildCollectTag(Theme.of(context).primaryColor, showBadge)
          ])),
    );
  }

  Widget buildContent(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0),
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(0.h)),
        ),
        height: 170.h,
        padding: EdgeInsets.only(top: 20.h, left: 0, right: 10.w, bottom: 0.h),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                buildLeading(),
                Expanded(
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
          ],
        ),
      );

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
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 0.w, bottom: 0.h, top: 0.h, right: 0.w),
                    child: CircleAvatar(
                      foregroundColor: Colors.white10,
                      radius: (70.sp),
                      child: ClipOval(
                        child: photo.headImg==""
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
        ),
      );

  Color get invColor {
    return Colors.lightBlue;
  }

  Widget _titleTop() {
    String level = getLevel(photo.status);
    return Padding(
      padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 0.h),
      child: Container(
        child: Text(
            photo.name +
                " " +
                (photo.gender== 1 ? "男" : "女") +
                " " +
                photo.age.toString()+
                "岁 " +
                "" +
                ((photo.height== 0 )
                    ? ""
                    : photo.height.toString() + "cm") +
                " " +
                level,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(color: Colors.white, offset: Offset(.3, .3))
                ])),
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Container(
        child: Text(
          //尾部摘要
          (hasHouseLevel[photo.hasHouse]) +
              " " +
              (hasCarLevel[photo.hasCar]) +
              " " +
              (marriageLevel[photo.marriage]) +
              " 生日:" +
              (photo.birthday == ""
                  ? "-"
                  : (photo.birthday.length > 10
                      ? photo.birthday.toString().substring(0, 10)
                      : "")) +
              " 收入:" +
              photo.income.toString() +
              "w",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black, fontSize: 23.sp, shadows: const [
            Shadow(color: Colors.white, offset: Offset(.5, .5))
          ]),
        ),
      ),
    );
  }

  Widget _buildMiddles() {
    bool isVip = false;
    bool expire = false;
    String vipName = "";
    String vipName1 = "";
    var vipExpireTime = photo.vipExpireTime;
    if (vipExpireTime == null) {
      isVip = false;
    } else {
      if (photo.status== 2) {
        if (photo.vipId> 0 &&
            DateTime.parse(photo.vipExpireTime).millisecondsSinceEpoch >
                DateTime.now().millisecondsSinceEpoch) {
          isVip = true;
          vipName = photo.vipName;
          vipName1 = "(" + photo.vipExpireTime + ")";
        } else {
          expire = true;
          vipName1 = "(会员已过期)";
        }
      } else {}
    }
    return Padding(
      padding: EdgeInsets.only(left: 1.w, bottom: 0.h, top: 5.h),
      child: Container(
        child: isVip
            ? (Text(
                //尾部摘要
                (vipName + vipName1), maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 23.sp,
                    shadows: [
                      const Shadow(
                          color: Colors.white, offset: const Offset(.5, .5))
                    ]),
              ))
            : (expire
                ? Text(
                    //尾部摘要
                    (vipName1), maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 23.sp,
                        shadows: [
                          const Shadow(
                              color: Colors.white, offset: const Offset(.5, .5))
                        ]),
                  )
                : Text(
                    //尾部摘要
                    ( "红娘: " + photo.saleName) +
                        " 沟通" +
                        photo.connectCount.toString() +
                        "次 " +
                        (photo.connectStatus== 0
                            ? ""
                            : (photo.connectStatus == null
                                ? ""
                                : getConnectLevel(photo.connectStatus)
                                    .toString())),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.sp,
                        shadows: const [
                          Shadow(
                              color: Colors.white, offset: Offset(.5, .5))
                        ]),
                  )),
      ),
    );
  }
}
