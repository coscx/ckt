import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../common/apis/common.dart';
import '../../../common/entities/home/common.dart';
import 'state.dart';

class HomeMessageLogic extends GetxController {
  final HomeMessageState state = HomeMessageState();
  final List<SelectItem> selectItems = <SelectItem>[].obs;
  var scaffoldKey =  GlobalKey<ScaffoldState>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  String serveType = "1";
  String totalCount = "";
  String title = "客户";
  int curPage = 1;
  int pageSize = 20;
  int total = 20;
  int roleId = 0;
  RxInt currentPhotoMode =0.obs;
  RxInt sex =1.obs;
  @override
  void onInit() {
    _loadData();
    super.onInit();
  }
  // 下拉刷新
  void _loadData() async {
    var result =
    await CommonAPI.searchErpUserCheck(curPage.toString(), sex.value, roleId, 1, selectItems);
    state.homeUser.addAll(result.data.data) ;
    totalCount =result.data.total.toString();
    //debugPrint(result.toJson().toString());
  }

  // 下拉刷新
  void onRefresh() async {
    curPage=1;
    var result =
    await CommonAPI.searchErpUserCheck(curPage.toString(), sex.value, roleId, 1, selectItems);
    state.homeUser.clear();
    state.homeUser .addAll(result.data.data) ;
    totalCount =result.data.total.toString();
    //debugPrint(result.toString());
    refreshController.refreshCompleted();
  }
  // 下拉刷新
  void onSexChange() async {
    curPage=1;
    var result =
    await CommonAPI.searchErpUserCheck(curPage.toString(), sex.value, roleId, 1, selectItems);
    state.homeUser.clear();
    state.homeUser .addAll(result.data.data) ;
    totalCount =result.data.total.toString();
    //debugPrint(result.toString());
    refreshController.loadComplete();
  }



  // 上拉加载
  void onLoading() async {
    curPage++;
    var result =
    await CommonAPI.searchErpUserCheck(curPage.toString(),sex.value, roleId, 1, selectItems);
    state.homeUser.addAll(result.data.data) ;
    totalCount =result.data.total.toString();
    refreshController.loadComplete();
  }
}
