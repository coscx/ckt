import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/total_user/widget/discovery_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../common/widgets/dy_behavior_null.dart';
import '../lost_user/logic.dart';
import '../my_user/logic.dart';
import 'logic.dart';

class TotalUserPage extends StatelessWidget {
  final logic = Get.find<TotalUserLogic>();
  final state = Get
      .find<TotalUserLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: DarkAppBar(),
        body: GetBuilder<TotalUserLogic>(builder: (logic) {
          return ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          color: Colors.white,
                          child: TabBar(
                            indicator: MaterialIndicator(
                              color:  Colors.blue,
                              strokeWidth: 0.w,
                              height: 10.h,
                              topLeftRadius: 8.w,
                              topRightRadius: 8.w,
                              bottomLeftRadius: 8.w,
                              bottomRightRadius: 8.w,
                              horizontalPadding: 10.h,
                              tabPosition: TabPosition.bottom,
                            ),
                            labelColor: Color(0xFF0a0f1e),
                            indicatorColor: Color(0xffFF7E98),
                            isScrollable: true,
                            tabs: List.generate(logic.subPage.length, (index) {
                              var str = logic.subPage[index];

                              var tp = TextPainter(
                                  textDirection: TextDirection.ltr,
                                  text: TextSpan(
                                      text: str,
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w800,
                                      )))
                                ..layout();
                              return Tab(
                                // text和child 2选一这里要控制条目尺寸选着使用child
                                // tab下的文字style 默认会使用DefultTextStyle包裹 所有这里面的Text可以不用再声明style 切换也会自带文字缩放
                                // text: str,
                                child: Container(
                                    width: tp.width + 48.w, child: Text(str)),
                              );
                            }),
                            controller: logic.tabController,
                            indicatorWeight: 0,
                            indicatorPadding: EdgeInsets.only(left: 25.w, right: 25.w,top: 0,bottom: 3.h),
                            labelPadding: EdgeInsets.only(
                                left: 2.w,bottom: 2.h,top: 5.h),
                            labelStyle: TextStyle(
                              fontSize: 38.sp,
                              color: Color(0xffFF7E98),
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelColor: Color(0xff888888),
                            unselectedLabelStyle:
                            TextStyle(
                                fontSize: 36.sp,fontWeight: FontWeight.w600,),
                            indicatorSize: TabBarIndicatorSize.label,
                            onTap: (index) {
                              logic.pageController.jumpToPage(index);
                            },
                          ),
                        )),
                    StatefulBuilder(
                        key: logic.myCurrentKey,
                        builder: (context1, setBottomSheetState) {
                          return logic.myCurrentIndex > 0 ? GestureDetector(
                            onTap: () {
                              if (logic.myCurrentIndex ==1){
                                logic.selected = true;
                                //selected ? title = "取消" : title = "选择";
                                logic.title = "选择";
                                bool gg = Get.isRegistered<MyUserLogic>();
                                if (gg) {
                                  var peerChatLogic = Get.find<MyUserLogic>();
                                  peerChatLogic.setAllSelect(logic.selected);
                                }
                                logic.showMyMenu();
                              }
                              if (logic.myCurrentIndex ==2){
                                logic.selected = true;
                                //selected ? title = "取消" : title = "选择";
                                logic.title = "选择";
                                bool gg = Get.isRegistered<LostLogic>();
                                if (gg) {
                                  var peerChatLogic = Get.find<LostLogic>();
                                  peerChatLogic.setAllSelect(logic.selected);
                                }
                                logic.showMyMenu();
                              }

                            },
                            child: Container(
                                padding: EdgeInsets.only(right: 60.w),
                                child: Text(
                                  logic.title,
                                  style: TextStyle(fontSize: 38.sp),
                                )),
                          ) : Container();
                        })

                    // GestureDetector(
                    //   onTap: (){
                    //
                    //     // showModalBottomSheet(
                    //     //     context: context,
                    //     //     builder: (builder) {
                    //     //       return PhotoShareBottomSheet();
                    //     //     });
                    //     // showModalBottomSheet(
                    //     //   context: context,
                    //     //   builder: (context) {
                    //     //     return StatefulBuilder(
                    //     //       builder: (context, setStateBottomSheet) {
                    //     //         return GestureDetector(
                    //     //           onTap: () {
                    //     //             return null;
                    //     //           },
                    //     //           child: Container(     //
                    //     //             decoration: BoxDecoration(
                    //     //                 borderRadius: BorderRadius.only(
                    //     //                   topLeft: Radius.circular(8),
                    //     //                   topRight: Radius.circular(8),
                    //     //                 ),
                    //     //                 color: Colors.white),
                    //     //             height: ScreenUtil().screenHeight,
                    //     //             padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    //     //             child: PhotoShareBottomSheet(),
                    //     //           ),
                    //     //         );
                    //     //       },
                    //     //     );
                    //     //   },
                    //     //   backgroundColor: Color.fromARGB(0, 255, 255, 0),
                    //     // );
                    //     // showCupertinoModalBottomSheet(
                    //     //   expand: false,
                    //     //   bounce: false,
                    //     //   context: context,
                    //     //   duration: const Duration(milliseconds: 200),
                    //     //   backgroundColor: Colors.white,
                    //     //   builder: (context) => PhotoShareBottomSheet(),
                    //     // );
                    //     bool gg = Get.isRegistered<HomeLogic>();
                    //     if (gg) {
                    //       var peerChatLogic = Get.find<HomeLogic>();
                    //       peerChatLogic.ss();
                    //     }
                    //    },
                    //   child: Container(
                    //       padding: EdgeInsets.only(right: 60.w),
                    //       child: Text(
                    //         "筛选",
                    //         style: TextStyle(fontSize: 38.sp),
                    //       )),
                    // )
                  ]),
                  Expanded(
                    child: PageView.builder(
                        key: const Key('pageView'),
                        itemCount: logic.pageList.length,
                        onPageChanged: logic.onPageChange,
                        controller: logic.pageController,
                        itemBuilder: (_, index) => logic.pageList[index]),
                  )
                ],
              ));
        }));
  }

  Widget buildButton(String name, String url, String bg) {
    return Stack(
      children: [
        Container(
            color: Colors.white,
            height: 160.h,
            width: 130.w,
            child: Column(children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Image.asset(bg),
              SizedBox(
                height: 8.h,
              ),
              Text(name,
                  style: TextStyle(
                      color: Colors.black.withAlpha(88),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.h,
              )
            ])),
        Container(
            color: Colors.white,
            height: 160.h,
            width: 130.w,
            child: Column(children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Image.asset(url),
              SizedBox(
                height: 8.h,
              ),
              Text(name,
                  style: TextStyle(
                      color: Colors.black.withAlpha(88),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.h,
              )
            ])),
      ],
    );
  }
}

class DarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0.0);
}