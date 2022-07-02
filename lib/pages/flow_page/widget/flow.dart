import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/entities/flow/wx_article.dart';
import '../../../common/routers/names.dart';
import '../../../common/widgets/extend_image.dart';

const String defaultImg =
    'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
final _random = Random();

int next(int min, int max) => min + _random.nextInt(max - min);

class MyFlow extends StatelessWidget {
  final RxList<Datas> liveData;

  MyFlow({required this.liveData});

  // 跳转直播间
  void _goToDetail(context, Datas item) {
    Get.toNamed(AppRoutes.Detail, arguments: item.uuid);
  }

  Future<void> _goToWebView(context, Datas item) async {
    Get.toNamed(AppRoutes.Webview,
        arguments: {"title": item.customerName, "url": item.url});
   // var t = await canLaunch(item.url);
   //  if ( t) {
   //   launch(item.url);
   //  }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        //_listTableHeader(),
        _listTableInfo(context, liveData),
      ]),
    );
  }

  String getExt(String name) {
    var m = "";
    var d = name.split(".");
    for (int i = 0; i < d.length; i++) {
      m = d[i];
    }
    return m;
  }

  // 直播列表详情
  Widget _listTableInfo(context, RxList<Datas> liveData) {
    final liveList = <Widget>[];


    var boxMargin = 10.w;

    liveData.asMap().keys.forEach((index) {
      Datas item = liveData[index];
      liveList.add(
        Padding(
          key: ObjectKey(item.id),
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, bottom: boxMargin * 2),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    _goToWebView(context, item);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.w),
                    ),
                    child: Container(
                      width: 330.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                //color: Colors.green,
                                //width: 350.h,
                                height: 200.h,
                                child: getCacheImage(item.img != ""
                                    ? (getExt(item.img) != "mp4"
                                        ? item.img
                                        : defaultImg)
                                    : defaultImg),
                              ),
                              Positioned(
                                child: Container(

                                  child:
                                      Container(
                                        width: 330.h,
                                        height: 70.h,
                                        padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                        ),
                                        decoration: const BoxDecoration(
                                            color: Color(0x20000000)
                                          // color: Colors.red

                                        ),
                                        child: Text(item.title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                color: Colors.white)),
                                      ),

                                ),
                                bottom: 0,
                                right: 0,
                                left: 0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {
                    _goToDetail(context, item);
                  },
                  child: Container(
                    width: ScreenUtil().screenWidth / 2 - 50.w,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                          child: Row(children: [
                            Container(
                              width: 80.w,
                              padding: EdgeInsets.only(left: 0.w, right: 0.w),
                              //width: 200.w,
                              child: Text(
                                item.customerName,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 23.sp,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 0.w, right: 5.w),
                              //width: 200.w,
                              child: Text(
                                item.gender == 1 ? "男" : "女",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 23.sp,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 0.w, right: 5.w),
                              //width: 200.w,
                              child: Text(
                                item.age.toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 0.w, right: 0.w),
                              //width: 200.w,
                              child: Text(
                                "来源:" + item.store,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 23.sp,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });

    return Wrap(
      children: liveList,
    );
  }
}
