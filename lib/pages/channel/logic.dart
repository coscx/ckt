import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/common/entities/loan/loan.dart';
import 'package:flutter_ckt/pages/channel/view.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../../common/routers/names.dart';
import '../../../../common/widgets/empty_page.dart';
import '../../../common/entities/loan/channel.dart';
import '../../../common/services/storage.dart';

import 'state.dart';

class ChannelLogic extends GetxController {
  final ChannelState state = ChannelState();
  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  final ScrollController scrollControl = ScrollController();
  TextEditingController appointController = TextEditingController();
  FocusNode remarkFieldNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;
  bool show = false;
  double heights = 80.h;
  double closeHeights = 80.h;
  Color cc = Colors.transparent;
  double opacity = 1.0;
  int groupValue = -1;
  String title = "请选择当前状态";
  var dm = <MyItem>[];
  var dm1 = <MyItem>[];
  String myName = "";
  bool myValue = false;
  List<ChannelDataData> loanData = <ChannelDataData>[];
  int page =1;
  @override
  void onInit() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible){
        remarkFieldNode.unfocus();
      }
    });
    _init();
    super.onInit();
  }
  _init() async {
    Channels? d = await _getChannels({"pageNum":page});
    if (d!=null && d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
    }
    update();
  }
  Future<Channels?> _getChannels( Map<String,dynamic> data) async {
    String  roleKey = StorageService.to.getString("roleKey");
    if(roleKey =="super"){
      var d = await CommonAPI.getSuperChannel(data);
      return d;
    }
    if(roleKey =="salesman"){
      var d = await CommonAPI.getSaleManChannel(data);
      return d;
    }
    if(roleKey =="director"){
      var d = await CommonAPI.getManageChannel(data);
      return d;
    }
    return null;
  }


  // 下拉刷新
  void getData(int status) async {
    page =1;
    Channels? d = await _getChannels({"pageNum":page});
    if ( d!=null &&d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
      refreshController.resetNoData();
    }
    update();
  }
// 下拉刷新
  void onRefresh() async {
    // var result = await IssuesApi.getErpUser();
    // dm = dm1.reversed.toList();
    page =1;
    Channels? d = await _getChannels({"pageNum":page});
    if (d!=null && d.data != null && d.data?.data != null) {
      loanData = d.data!.data!;
      refreshController.resetNoData();
    }
    refreshController.refreshCompleted();
    update();
  }

// 上拉加载
  void onLoading() async {
    //var result = await IssuesApi.getErpUser();

    page=page+1;
    Channels? d = await _getChannels({"pageNum":page});
    if (d!=null && d.data != null && d.data?.data != null) {
      if (page > d.data!.lastPage){
        refreshController.loadNoData();
        return;
      }
      loanData.addAll(d.data!.data!);
      if (d.data!.data!.isEmpty){
        refreshController.loadNoData();
        return;
      }

    }
    refreshController.loadComplete();
    update();
  }
  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }
}
class MyItem {
  final String icon;
  final String name;
  final String money;
  final String count;
  final String status;
  final String time;
  final Color color;

  const MyItem(
      {required this.icon,
        required this.name,
        required this.money,
        required this.count,
        required this.status,
        required this.time,
        required this.color});
}