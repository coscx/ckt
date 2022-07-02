import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ckt/common/entities/detail/action.dart';
import 'package:flutter_ckt/common/entities/detail/appoint.dart';
import 'package:flutter_ckt/common/entities/detail/calllog.dart';
import 'package:flutter_ckt/common/entities/detail/connect.dart';
import 'package:flutter_ckt/common/entities/detail/user_detail.dart';
import 'package:flutter_ckt/common/routers/names.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:flutter_ckt/pages/user_detail/widget/common_dialog.dart';
import 'package:flutter_ckt/pages/user_detail/widget/share.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../common/apis/common.dart';
import '../../common/widgets/copy_custom_pop_up_menu.dart';
import 'state.dart';

class UserDetailLogic extends GetxController {
  var popCtrl = CustomPopupMenuController();
  final UserDetailState state = UserDetailState();
  String memberId = "80";
  int connectStatus = 4;
  int canEdit = 0;
  String call = "";
  String uuid = Get.arguments;
  int status = 10;
  var showBaseControl = false.obs;
  var showEduControl = false.obs;
  var showMarriageControl = false.obs;
  var showSimilarControl = false.obs;
  var showSelectControl = false.obs;
  var showPhotoControl = false.obs;
  var showAppointControl = false.obs;
  var showConnectControl = false.obs;
  var showActionControl = false.obs;
  var showCallControl = false.obs;
  Data? userDetail;

  RxInt load = 0.obs;
  RxList<Connect> connectList = <Connect>[].obs;
  RxList<Appoint> appointList = <Appoint>[].obs;
  RxList<UserAction> actionList = <UserAction>[].obs;
  RxList<CallLog> callList = <CallLog>[].obs;
  final List<ShareOpt> list = [
    ShareOpt(
        title: '微信',
        img: 'assets/packages/images/login_wechat.svg',
        shareType: ShareType.SESSION,
        doAction: (shareType, shareInfo) async {
          if (shareInfo == null) return;

          /// 分享到好友
          var model = fluwx.WeChatShareWebPageModel(
            shareInfo.url,
            title: shareInfo.title,
            thumbnail: fluwx.WeChatImage.network(shareInfo.img),
            scene: fluwx.WeChatScene.SESSION,
          );
          fluwx.shareToWeChat(model);
        }),
  ];
  final GlobalKey addKey = GlobalKey();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() {
    _loadData();
  }

  void _loadData() async {
    var result = await CommonAPI.getUserDetail(uuid);
    userDetail = result.data;
    load.value = 1;

    Future.delayed(const Duration(seconds: 2), () {
      _loadOtherData();
    });
    //debugPrint(result.toJson().toString());
  }

  void _loadOtherData() async {
    var connect = await CommonAPI.getConnectList(uuid, 1);
    connectList.clear();
    connectList.addAll(connect.data.data);

    var appoint = await CommonAPI.getAppointmentList(uuid, 1);
    appointList.clear();
    appointList.addAll(appoint.data.data);

    var action = await CommonAPI.getActionList(uuid, 1);
    actionList.clear();
    actionList.addAll(action.data.data);

    var call = await CommonAPI.getCallList(uuid, 1);
    callList.clear();
    callList.addAll(call.data.data);

    //debugPrint(result.toJson().toString());
  }

  // 下拉刷新
  void onRefresh() async {
    var result = await CommonAPI.getUserDetail(uuid);
    userDetail = result.data;
    update(["user_detail"]);
    _loadOtherData();
    refreshController.refreshCompleted();
  }

  // 上拉加载
  void onLoading() async {
    refreshController.loadComplete();
  }

  void callSetState(String tag, bool value) {
    if (tag == "base") {
      showBaseControl.value = value;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "education") {
      showBaseControl.value = false;
      showEduControl.value = value;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "marriage") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = value;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "similar") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = value;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "select") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = value;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "photo") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = value;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
      update(["user_detail"]);
    }
    if (tag == "connect") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = value;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = false;
    }
    if (tag == "appoint") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = value;
      showActionControl.value = false;
      showCallControl.value = false;
    }
    if (tag == "action") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = value;
      showCallControl.value = false;
    }
    if (tag == "call") {
      showBaseControl.value = false;
      showEduControl.value = false;
      showMarriageControl.value = false;
      showSimilarControl.value = false;
      showSelectControl.value = false;
      showPhotoControl.value = false;
      showConnectControl.value = false;
      showAppointControl.value = false;
      showActionControl.value = false;
      showCallControl.value = value;
    }
  }

  void buildAppointButton() {
    showBaseControl.value = false;
    showEduControl.value = false;
    showMarriageControl.value = false;
    showSimilarControl.value = false;
    showSelectControl.value = false;
    showPhotoControl.value = false;
    showConnectControl.value = false;
    showAppointControl.value = true;
    showActionControl.value = false;
    showCallControl.value = false;
  }

  void buildConnectButton() {
    showBaseControl.value = false;
    showEduControl.value = false;
    showMarriageControl.value = false;
    showSimilarControl.value = false;
    showSelectControl.value = false;
    showPhotoControl.value = false;
    showConnectControl.value = true;
    showAppointControl.value = false;
    showActionControl.value = false;
    showCallControl.value = false;
  }

  Future<void> editUserOnce(String uuid, String type, String text) async {
    var result = await CommonAPI.editCustomerOnceString(uuid, type, text);
    if (result.code == 200) {
      userDetail = setObjectKeyValue(userDetail!, type, text);
      update(["user_detail"]);
      showToast(Get.context!, "编辑成功", false);
    } else {
      showToastRed(Get.context!, result.message!, false);
    }
  }

  Future<void> editCustomerAddress(String uuid, int type, Result result) async {
    Map<String, dynamic> searchParam = {};
    if (type == 1) {
      searchParam['np_province_code'] = result.provinceId;
      searchParam['np_province_name'] = result.provinceName;
      searchParam['np_city_code'] = result.cityId;
      searchParam['np_city_name'] = result.cityName;
      searchParam['np_area_code'] = result.areaId;
      searchParam['np_area_name'] = result.areaName;
      searchParam['native_place'] =
          result.provinceName! + result.cityName! + result.areaName!;
    } else {
      searchParam['lp_province_code'] = result.provinceId;
      searchParam['lp_province_name'] = result.provinceName;
      searchParam['lp_city_code'] = result.cityId;
      searchParam['lp_city_name'] = result.cityName;
      searchParam['lp_area_code'] = result.areaId;
      searchParam['lp_area_name'] = result.areaName;
      searchParam['location_place'] =
          result.provinceName! + result.cityName! + result.areaName!;
    }
    var returnResult = await CommonAPI.editCustomerAddress(uuid, searchParam);
    if (returnResult.code == 200) {
      userDetail = setObjectKeyValueMulti(userDetail!, searchParam);
      update(["user_detail"]);
      showToast(Get.context!, "编辑成功", false);
    } else {
      showToastRed(Get.context!, returnResult.message!, false);
    }
  }

  Future<void> editCustomerDemandAddress(String uuid, Result result) async {
    Map<String, dynamic> searchParam = {};

    searchParam['wish_lp_province_code'] = result.provinceId;
    searchParam['wish_lp_province_name'] = result.provinceName;
    searchParam['wish_lp_city_code'] = result.cityId;
    searchParam['wish_lp_city_name'] = result.cityName;
    searchParam['wish_lp_area_code'] = result.areaId;
    searchParam['wish_lp_area_name'] = result.areaName;
    searchParam['wish_location_place'] =
        result.provinceName! + result.cityName! + result.areaName!;

    var returnResult =
        await CommonAPI.editCustomerDemndAddress(uuid, searchParam);
    if (returnResult.code == 200) {
      userDetail = setObjectDemandKeyValueMulti(userDetail!, searchParam);
      update(["user_detail"]);
      showToast(Get.context!, "编辑成功", false);
    } else {
      showToastRed(Get.context!, returnResult.message!, false);
    }
  }

  Future<void> delPhoto(
    int imgId,
  ) async {
    var returnResult = await CommonAPI.delPhoto(imgId);
    if (returnResult.code == 200) {
      userDetail = setObjectPhotoKeyValue(userDetail!, imgId);
      update(["user_detail"]);
      showToast(Get.context!, "编辑成功", false);
    } else {
      showToastRed(Get.context!, returnResult.message!, false);
    }
  }

  Future<void> uploadPhoto(String path) async {
    EasyLoading.show();
    try {
      var resultConnectList = await CommonAPI.uploadPhotoFile(1, path);
      var url = "https://queqiaoerp.oss-cn-shanghai.aliyuncs.com/" +
          resultConnectList.data!;
      var result =
          await CommonAPI.editCustomerOnceStringResource(uuid, "1", url);
      if (result.code == 200) {
        Map<String, dynamic> json = {};
        json['id'] = 0;
        json['customer_id'] = userDetail?.info.id;
        json['type'] = 1;
        json['file_url'] = url;
        json['sort'] = 1;
        json['is_approved'] = 1;
        var f = Pics.fromJson(json);
        userDetail?.pics.add(f);
        update(["user_detail"]);
        showToast(Get.context!, "上传成功", false);
      } else {
        showToastRed(Get.context!, result.message!, false);
      }
      EasyLoading.dismiss();
      //
      // var result = await IssuesApi.editCustomer(
      //     userdetail['info']['uuid'], "1", resultConnectList['data']);
      // if (result['code'] == 200) {
      //   EasyLoading.dismiss();
      //   showToast(context, "上传成功", false);
      //   BlocProvider.of<DetailBloc>(context).add(UploadImgSuccessEvent(
      //       userdetail, resultConnectList['data'], result['data']));
      //
      //   callSetState("photo", true);
      // } else {
      //   EasyLoading.dismiss();
      //   showToast(context, result['message'], false);
      // }
    } on Error catch (e) {
       EasyLoading.dismiss();
      //var dd = e.response.data;
      // EasyLoading.showSuccess(dd['message']);
      //showToast(context,dd['message'],false);
    }
  }

  Data setObjectKeyValue(Data detail, String key, String value) {
    var d = detail.info.toJson();
    d[key] = value;
    detail.info = Info.fromJson(d);
    return detail;
  }

  Data setObjectKeyValueMulti(Data detail, Map<String, dynamic> value) {
    var d = detail.info.toJson();
    d.addAll(value);
    detail.info = Info.fromJson(d);
    return detail;
  }

  Future<void> editUserDemandOnce(String uuid, String type, String text) async {
    var result = await CommonAPI.editCustomerDemandOnce(uuid, type, text);
    if (result.code == 200) {
      userDetail = setObjectDemandKeyValue(userDetail!, type, text);
      update(["user_detail"]);
      showToast(Get.context!, "编辑成功", false);
    } else {
      showToast(Get.context!, "result", false);
    }
  }

  Data setObjectDemandKeyValue(Data detail, String key, String value) {
    var d = detail.demand.toJson();
    d[key] = value;
    detail.demand = Demand.fromJson(d);
    return detail;
  }

  Data setObjectDemandKeyValueMulti(Data detail, Map<String, dynamic> value) {
    var d = detail.demand.toJson();
    d.addAll(value);
    detail.demand = Demand.fromJson(d);
    return detail;
  }

  Data setObjectPhotoKeyValue(Data detail, int id) {
    detail.pics.removeWhere((e) => e.id == id);
    return detail;
  }

  Future<void> getUser() async {
    var result = await CommonAPI.claimCustomer(uuid);
    if (result.code == 200) {
      showToast(Get.context!, '认领成功', true);
    } else {
      showToastRed(Get.context!, result.message!, true);
    }
  }

  void changeUser() {
    int? status = userDetail?.info.status;
    if (userDetail?.info.roleId == 0) {
      showToastRed(Get.context!, "暂无权限", true);
    }
    if (status! < 0) {
      showToastRed(Get.context!, "当前用户状态需认领后再划分", true);

      return;
    }
    if (status == 5) {
      if (userDetail?.info.roleId != 1) {
        showToastRed(Get.context!, "暂无划分权限", true);

        return;
      }
    }

    if (status > 3) {
      showToastRed(Get.context!, "暂无权限", true);

      return;
    }
    Get.toNamed(AppRoutes.Distribute, arguments: uuid);
  }

  void addVip() {
    if (status != 0 && status != 1 && status != 30) {
      showToastRed(Get.context!, "当前用户状态不可购买会员套餐", true);
      return;
    }
    debugPrint("addVip");
    Map<String, dynamic> args = <String, dynamic>{};
    args['uuid'] = uuid;
    args['store_id'] = userDetail?.info.storeId;
    Get.toNamed(AppRoutes.BuyVip, arguments: args);
  }

  Future<void> addAppoint(String uuid, Map<String, dynamic> data) async {
    data['username'] = StorageService.to.getString("name");
    var result = await CommonAPI.addAppoint(uuid, data);
    if (result.code == 200) {
      data['id'] = 0;
      data['score1'] = "";
      data['feedback1'] = "";
      data['created_at'] = "";
      data['system'] = 0;
      data['mark'] = 0;
      data['type'] = 0;
      data['is_pay'] = 0;
      data['can_write'] = 0;
      data['message'] = "";
      var f = Appoint.fromJson(data);
      appointList.insert(0, f);
      showToast(Get.context!, '添加成功', true);
    } else {
      showToastRed(Get.context!, result.message!, true);
    }
  }

  Future<void> addConnect(String uuid, Map<String, dynamic> data) async {
    data['username'] = StorageService.to.getString("name");
    data['customer_uuid'] = uuid;
    var result = await CommonAPI.addConnect(uuid, data);
    if (result.code == 200) {
      data['id'] = 0;
      var f = Connect.fromJson(data);
      connectList.insert(0, f);
      showToast(Get.context!, '添加成功', true);
    } else {
      showToastRed(Get.context!, result.message!, true);
    }
  }
}
