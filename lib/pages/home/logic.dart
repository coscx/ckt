import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect_scope/multiselect_scope.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/apis/common.dart';
import '../../common/entities/home/common.dart';
import 'state.dart';
import '../../common/entities/home/search_erp.dart';
class HomeLogic extends GetxController {
  final HomeState state = HomeState();
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
    var result =
    await CommonAPI.searchErpUser(curPage.toString(), sex, roleId, 1, selectItems);
    state.homeUser.addAll(result.data.data) ;
    getListItemString(state.homeUser);
    totalCount =result.data.total.toString();
    update();
    //debugPrint(result.toJson().toString());
  }

  // 下拉刷新
  void onRefresh() async {
    curPage=1;
    var result =
    await CommonAPI.searchErpUser(curPage.toString(), sex, roleId, 1, selectItems);
    state.homeUser.clear();
    state.homeUser .addAll(result.data.data) ;
    getListItemString(state.homeUser);
    totalCount =result.data.total.toString();
    //debugPrint(result.toString());
    refreshController.refreshCompleted();
    update();
  }
  // 下拉刷新
  void onSexChange() async {
    curPage=1;
    var result =
    await CommonAPI.searchErpUser(curPage.toString(), sex, roleId, 1, selectItems);
    state.homeUser.clear();
    state.homeUser .addAll(result.data.data) ;
    getListItemString(state.homeUser);
    totalCount =result.data.total.toString();
    //debugPrint(result.toString());
    refreshController.loadComplete();
    update();
  }

  // 上拉加载
  void onLoading() async {
    curPage++;
    var result =
    await CommonAPI.searchErpUser(curPage.toString(),sex, roleId, 1, selectItems);
    state.homeUser.addAll(result.data.data) ;
    getListItemString(state.homeUser);
    totalCount =result.data.total.toString();
    refreshController.loadComplete();
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
}
