import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/friend/view.dart';
import 'package:flutter_ckt/pages/home/view.dart';
import 'package:flutter_ckt/pages/my_user/view.dart';
import 'package:flutter_ckt/pages/other/fine/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/entities/home/common.dart';
import '../../../common/services/storage.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../home/logic.dart';
import '../../my_user/logic.dart';
import '../logic.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with
        AutomaticKeepAliveClientMixin<DiscoveryPage>,
        SingleTickerProviderStateMixin {
  bool selected = false;
  late TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  var pageList = [];
  String title = "选择";
  bool allSelect = false;
  var subPage = [];
  List<SelectItem> selectItems = <SelectItem>[];
  late OverlayEntry _overlayEntry;
  late TotalUserLogic logic;
  int myCurrentIndex =0;
  GlobalKey myCurrentKey = GlobalKey();
  @override
  void initState() {
    super.initState();
     logic = Get.find<TotalUserLogic>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      this._overlayEntry = this._createOverlayEntry();
    });

    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      pageList = [
        HomePage(),
        MyUserPage(),
      ];
      subPage = ["全部客户", "我的客户"];
    } else if (roleKey == "salesman") {
      pageList = [
        MyUserPage(),
      ];
      subPage = ["我的客户"];
    } else if (roleKey == "director") {
      pageList = [
        HomePage(),
        MyUserPage(),
        FriendPage(),
      ];
      subPage = ["全部客户", "我的客户", "客户放弃"];
    } else if (roleKey == "administration") {
      pageList = [
        HomePage(),
        MyUserPage(),
      ];
      subPage = ["我的客户", "审批管理"];
    } else {
      pageList = [
        MyUserPage(),
      ];
      subPage = ["我的客户"];
    }
    _tabController =
        TabController(initialIndex: 0, vsync: this, length: pageList.length);
  }

  showMyMenu() {
    Overlay.of(context)?.insert(this._overlayEntry);
    setState((){});
  }

  hideMyMenu() {
    this._overlayEntry.remove();
    setState((){});
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    String title ="请选择";

    return OverlayEntry(
        builder: (context) => Stack(
              children: [
                Positioned(
                  left: offset.dx,
                  top: MediaQuery.of(context).padding.top,
                  width: size.width,
                  child: Material(
                    color: Colors.white,
                    child: Container(
                        color: Colors.lightBlueAccent,
                        padding: EdgeInsets.only(left: 60.w, right: 60.w),
                        height: AppBar().preferredSize.height - 10.h,
                        child: StatefulBuilder(
                            key: logic.g,
                            builder: (context1, setBottomSheetState) {
                              bool gg = Get.isRegistered<MyUserLogic>();
                              if (gg) {
                                var homeLogic = Get.find<MyUserLogic>();
                                if (homeLogic.getSelectCount()==1) {
                                  allSelect=false;
                                  title ="已选择("+homeLogic.getSelectCount().toString()+")";
                                } else if (homeLogic.getSelectCount()>1) {
                                  allSelect=true;
                                  title ="已选择("+homeLogic.getSelectCount().toString()+")";
                                }else{
                                  allSelect=false;
                                  title ="请选择";
                                }

                              }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  hideMyMenu();
                                  selected = false;
                                  var homeLogic = Get.find<MyUserLogic>();
                                  homeLogic.setAllSelect(false);
                                  homeLogic.setAllSelectAll(false);
                                  setState(() {});
                                },
                                child: Container(
                                  child: Text('取消',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 34.sp)),
                                ),
                              ),
                              Container(
                                child: Text(title,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 34.sp)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setBottomSheetState(() {
                                    allSelect = !allSelect;
                                    bool gg = Get.isRegistered<MyUserLogic>();
                                    if (gg) {
                                      var homeLogic = Get.find<MyUserLogic>();
                                      homeLogic.setAllSelectAll(allSelect);
                                       if (homeLogic.getSelectCount()>0) {
                                          title ="已选择("+homeLogic.getSelectCount().toString()+")";
                                       }else{
                                          title ="请选择";
                                       }

                                    }
                                  });
                                },
                                child: Container(
                                  child: Text(!allSelect ? '全选' : "取消全选",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 34.sp)),
                                ),
                              ),
                            ],
                          );
                        })),
                  ),
                ),
                Positioned(
                  left: offset.dx,
                  top: offset.dy + size.height - 30.h,
                  width: size.width,
                  child: Material(
                    color: Colors.white,
                    child: Container(
                      color: Colors.lightBlueAccent,
                      padding: EdgeInsets.only(left: 40.w, right: 40.w),
                      height: 120.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 70.h,
                            child: Column(
                              children: [
                                Container(
                                    child: Image.asset(
                                  "assets/images/vip.webp",
                                  width: 40.w,
                                )),
                                Container(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: Text('划分',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26.sp))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  _onPageChange(int index) async {
    myCurrentKey.currentState?.setState(() {
      myCurrentIndex= index;
    });
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: DarkAppBar(),
        body: ScrollConfiguration(
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
                      isScrollable:true,
                      tabs: List.generate(subPage.length, (index) {
                        var str = subPage[index];

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
                      controller: _tabController,
                      indicatorWeight: 3,
                      indicatorPadding:
                          EdgeInsets.only(left: 20.w, right: 20.w),
                      labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      labelStyle: TextStyle(
                        fontSize: 32.sp,
                        color: Color(0xffFF7E98),
                        fontWeight: FontWeight.w800,
                      ),
                      unselectedLabelColor: Color(0xff999999),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 32.sp, color: Color(0xff999999)),
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: (index) {
                        _pageController.jumpToPage(index);
                      },
                    ),
                  )),
                  StatefulBuilder(
                      key: myCurrentKey,
                      builder: (context1, setBottomSheetState) {
                    return myCurrentIndex > 0 ?GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = true;
                          //selected ? title = "取消" : title = "选择";
                          title = "选择";
                          bool gg = Get.isRegistered<MyUserLogic>();
                          if (gg) {
                            var peerChatLogic = Get.find<MyUserLogic>();
                            peerChatLogic.setAllSelect(selected);
                          }
                          showMyMenu();
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.only(right: 60.w),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 38.sp),
                          )),
                    ):Container();
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
                      itemCount: pageList.length,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, index) => pageList[index]),
                )
              ],
            )));
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
