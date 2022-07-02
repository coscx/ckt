import 'package:flutter/cupertino.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/entities/home/common.dart';
import 'state.dart';

class FlowPageLogic extends GetxController {
  final FlowPageState state = FlowPageState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /// 成员变量
  String categoryCode = '';
  int curPage = 1;
  int pageSize = 20;
  int total = 20;
  List<SelectItem> selectItems = <SelectItem>[];
  @override
  void onInit() {
    _loadData();

    super.onInit();
  }

  // 下拉刷新
  void _loadData() async {
    var result =
        await CommonAPI.wxArticle(curPage, selectItems);
    state.wxUser.addAll(result.data.data) ;
    //debugPrint(result.toJson().toString());
  }

  // 下拉刷新
  void onRefresh() async {

    curPage=1;
    var result =
    await CommonAPI.wxArticle(curPage,  selectItems);
    state.wxUser.clear();
    state.wxUser.addAll(result.data.data) ;
    //debugPrint(result.toString());
    refreshController.refreshCompleted();
  }

  // 上拉加载
  void onLoading() async {
    curPage++;
    var result =
    await CommonAPI.wxArticle(curPage,selectItems);
    state.wxUser.addAll(result.data.data) ;
    refreshController.loadComplete();
  }
}
