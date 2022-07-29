import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/total_user/widget/discovery_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/dy_behavior_null.dart';
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
                                    width: tp.width + 10.w, child: Text(str)),
                              );
                            }),
                            controller: logic.tabController,
                            indicatorWeight: 3,
                            indicatorPadding:
                            EdgeInsets.only(left: 20.w, right: 20.w),
                            labelPadding: EdgeInsets.symmetric(
                                horizontal: 16.w),
                            labelStyle: TextStyle(
                              fontSize: 32.sp,
                              color: Color(0xffFF7E98),
                              fontWeight: FontWeight.w800,
                            ),
                            unselectedLabelColor: Color(0xff999999),
                            unselectedLabelStyle:
                            TextStyle(
                                fontSize: 32.sp, color: Color(0xff999999)),
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
                              logic.selected = true;
                              //selected ? title = "取消" : title = "选择";
                              logic.title = "选择";
                              bool gg = Get.isRegistered<MyUserLogic>();
                              if (gg) {
                                var peerChatLogic = Get.find<MyUserLogic>();
                                peerChatLogic.setAllSelect(logic.selected);
                              }
                              logic.showMyMenu();
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