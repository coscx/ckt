import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/home/widget/gzx_filter_goods_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:multiselect_scope/multiselect_scope.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/apis/common.dart';
import '../../common/entities/home/common.dart';
import 'state.dart';
import '../../common/entities/home/search_erp.dart';
class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  List<Data> loanData = <Data>[];
  final List<SelectItem> selectItems = <SelectItem>[];
  final Map<String ,bool> items = Map();
  var scaffoldKey =  GlobalKey<ScaffoldState>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  String serveType = "1";
  String totalCount = "";
  String title = "客户管理";
  int curPage = 1;
  int pageSize = 20;
  int total = 20;
  int roleId = 0;
  int currentPhotoMode =0;
  int sex =1;
  double topDistance =0;
  bool ff =true;
  bool allSelect =false;
  @override
  void onInit() {
    _loadData();
    super.onInit();
  }
  // 下拉刷新
  void _loadData() async {
    var d = await CommonAPI.getLoanList(page,groupValue,userId,cnId);
    if (d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
      totalCount =d.data!.total.toString();
      refreshController.refreshCompleted();
    }
    update();
    //debugPrint(result.toJson().toString());
  }

  // 下拉刷新
  void onRefresh() async {
    curPage=1;
    var d = await CommonAPI.getLoanList(page,groupValue,userId,cnId);
    if (d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
      totalCount =d.data!.total.toString();
      refreshController.refreshCompleted();
    }

    update();
  }
  // 下拉刷新
  void onSexChange() async {
    // curPage=1;
    // var result =
    // await CommonAPI.searchErpUser(curPage.toString(), sex, roleId, 1, selectItems);
    // state.homeUser.clear();
    // state.homeUser .addAll(result.data.data) ;
    // getListItemString(state.homeUser);
    // totalCount =result.data.total.toString();
    // //debugPrint(result.toString());
    // refreshController.loadComplete();
    // update();
  }

  // 上拉加载
  void onLoading() async {
    curPage++;
    var d = await CommonAPI.getLoanList(page,groupValue,userId,cnId);
    if (d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
      totalCount =d.data!.total.toString();
      refreshController.loadComplete();
    }
    update();
  }
  getListItemString(List<Data> users){
   
  }
  setSelectCheckbox(bool d ,int index,int position){
    if (position== 1){
      if (items.containsKey(state.homeUser.elementAt(index).id.toString())){
        items[state.homeUser.elementAt(index).id.toString()] = !items[state.homeUser.elementAt(index).id.toString()]!;
      }else{
        items[state.homeUser.elementAt(index).id.toString()] = true;
      }
      update();
      return;
    }
    items[state.homeUser.elementAt(index).id.toString()] = d;
    update();
  }
 bool  getSelectCheckbox(int index){
    bool data =false;
    if (items.containsKey(state.homeUser.elementAt(index).id.toString())){
      data = items[state.homeUser.elementAt(index).id.toString()]!;
    }
    return data;
  }
  setDistance(double d){
    topDistance+=d;
    print(topDistance);
  }
  setAllSelect(bool d ){
    allSelect =d;
    update();
  }


  ss(){
    showJustBottomSheet(
      context: Get.context!,
      dragZoneConfiguration: JustBottomSheetDragZoneConfiguration(
        dragZonePosition: DragZonePosition.inside,

        child: Container(
          color:Colors.white,
          //borderRadius: BorderRadius.circular(6.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 4,
              width: 30,
              color: Theme.of(Get.context!).brightness == Brightness.light
                  ? Colors.grey[300]
                  : Colors.white,
            ),
          ),
        ),
      ),
      configuration: JustBottomSheetPageConfiguration(
          height: ScreenUtil().screenHeight/1.2,
          builder: (context) {
            // return SingleChildScrollView(
            //     physics: const BouncingScrollPhysics(),
            //     child: Column(children: <Widget>[
            //
            //       Wrap(
            //         spacing: 40.w,
            //         runSpacing: 0.w,
            //         children: <Widget>[
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //           buildButton("...",
            //               "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
            //         ],
            //       ),
            //       // SizedBox(
            //       //   height: 100.h,
            //       // ),
            //     ]));

            return GZXFilterGoodsPage(
              selectItems: selectItems,
            );
          },
          scrollController: scrollController,
          closeOnScroll: true,
          cornerRadius: 60.w,
          backgroundColor: Colors.white,
          backgroundImageFilter: null
      ),
    );
  }
}
