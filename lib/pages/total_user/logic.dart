import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../common/apis/common.dart';
import '../../common/entities/home/common.dart';
import '../../common/services/storage.dart';
import '../friend/view.dart';
import '../home/view.dart';
import '../my_user/logic.dart';
import '../my_user/view.dart';
import '../oa/user_detail/widget/common_dialog.dart';
import '../select_result/widget/select_result_page.dart';
import 'state.dart';

class TotalUserLogic extends GetxController with SingleGetTickerProviderMixin {
  final TotalUserState state = TotalUserState();
  GlobalKey g = GlobalKey();
  bool selected = false;
  late TabController tabController;
  PageController pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  var pageList = [];
  String title = "选择";
  bool allSelect = false;
  var subPage = [];
  List<SelectItem> selectItems = <SelectItem>[];
  late OverlayEntry _overlayEntry;
  int myCurrentIndex =0;
  GlobalKey myCurrentKey = GlobalKey();
  @override
  void onInit() {

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
        HomePage(),
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
    tabController =
        TabController(initialIndex: 0, vsync: this, length: pageList.length);
  }

  showMyMenu() {
    Overlay.of(Get.context!)?.insert(this._overlayEntry);

  }

  hideMyMenu() {
    this._overlayEntry.remove();

  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = Get.context!.findRenderObject() as RenderBox;
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
                        key: g,
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
              top: offset.dy + size.height-100.h,
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
                      GestureDetector(
                        onTap: (){
                          onSelect();
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  onPageChange(int index) async {
    myCurrentKey.currentState?.setState(() {
      myCurrentIndex= index;
    });
    tabController.animateTo(index);
  }
  onSelect(){
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      showSuperBottom();
    }
    if (roleKey == "director") {
      showDirectorBottom();
    }
    bool gg = Get.isRegistered<MyUserLogic>();
    if (gg) {
      var homeLogic = Get.find<MyUserLogic>();
      homeLogic.setAllSelect(false);
    }
    hideMyMenu();
  }
  showSuperBottom(){
      showCupertinoModalBottomSheet(
        expand: false,
        bounce: false,
        context: Get.context!,
        duration: const Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        builder: (context) => SelectPage(
          type: 4,
          onResendClick: (data) async {
            print(data);
            bool gg = Get.isRegistered<MyUserLogic>();
            if (gg) {
              var homeLogic = Get.find<MyUserLogic>();
              var d = await CommonAPI.superDivide({"user_id":homeLogic.getSelectItemString(),"directorId":data["id"]});
              if (d.code ==200){
                homeLogic.onRefresh();
              }
            }

            update();
          },
        ),
      );
    }
  showDirectorBottom(){
    showCupertinoModalBottomSheet(
      expand: false,
      bounce: false,
      context: Get.context!,
      duration: const Duration(milliseconds: 200),
      backgroundColor: Colors.white,
      builder: (context) => SelectPage(
        type: 4,
        onResendClick: (data) async {
          print(data);
          bool gg = Get.isRegistered<MyUserLogic>();
          if (gg) {
            var homeLogic = Get.find<MyUserLogic>();
            var d = await CommonAPI.manageDivide({"user_id":homeLogic.getSelectItemString(),"userId":data["id"]});
            if (d.code ==200){
              homeLogic.onRefresh();
            }
            bool gg = Get.isRegistered<MyUserLogic>();
            if (gg) {
              var homeLogic = Get.find<MyUserLogic>();
              homeLogic.setAllSelectAll(false);
            }
            showToast(Get.context!, "划分成功", true);
          }
          update();
        },
      ),
    );
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
