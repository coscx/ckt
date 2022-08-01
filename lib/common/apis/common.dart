import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_ckt/common/entities/common_result.dart';
import 'package:flutter_ckt/common/entities/detail/calllog.dart';
import 'package:flutter_ckt/common/entities/detail/claim_customer.dart';
import 'package:flutter_ckt/common/entities/detail/connect.dart';
import 'package:flutter_ckt/common/entities/detail/user.dart';
import 'package:flutter_ckt/common/entities/detail/free_vip.dart';
import 'package:flutter_ckt/common/entities/detail/store_vip.dart';
import 'package:flutter_ckt/common/entities/detail/user_detail.dart';
import 'package:flutter_ckt/common/entities/detail/viewcall.dart';
import 'package:flutter_ckt/common/entities/flow/wx_article.dart';
import 'package:flutter_ckt/common/entities/home/erp_user.dart';
import 'package:flutter_ckt/common/entities/home/tree_store.dart';
import 'package:flutter_ckt/common/entities/im/group.dart';
import 'package:flutter_ckt/common/entities/loan/channel.dart';
import 'package:flutter_ckt/common/entities/loan/loan_detail.dart';
import 'package:flutter_ckt/common/entities/loan/quota_list.dart';
import 'package:flutter_ckt/common/entities/loan/saleman.dart';
import 'package:flutter_ckt/common/entities/loan/saleman_detail.dart';
import 'package:flutter_ckt/common/entities/loan/saleman_grid.dart';
import 'package:flutter_ckt/common/entities/loan/super_director.dart';
import 'package:flutter_ckt/common/entities/login/login_model.dart';
import 'package:http_parser/http_parser.dart';
import '../entities/app_version.dart';
import '../entities/detail/action.dart';
import '../entities/detail/appoint.dart';
import '../entities/home/common.dart';
import '../entities/home/only_store.dart';
import '../entities/home/search_erp.dart';
import '../entities/loan/friend.dart';
import '../entities/loan/loan.dart';
import '../entities/loan/quota.dart';
import '../entities/loan/staff.dart';
import '../entities/loan/step.dart';
import '../entities/mine/mine.dart';
import '../utils/loan_http.dart';
import '../utils/new_common_http.dart';

/// 用户
class CommonAPI {

  static Future<Loan> getLoanList(int page,int status,String userId,int cnId) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetLoanCheckList',
      data: {"user_id":userId,"cn_id":cnId,"currentPage":page,"status":status},
    );
    return Loan.fromJson(response);
  }
  static Future<LoanDetail> getLoanDetail(int id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetLoanDetail',
      data: {"loan_id":id},
    );
    return LoanDetail.fromJson(response);
  }
  static Future<Quota> GetAppQuotaCalculation(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAppQuotaCalculation',
      data: data,
    );
    return Quota.fromJson(response);
  }
  static Future<QuotaList> GetCalcucationList(int page,int user_id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetCalcucationList',
      data: {"page":page,"user_id":user_id},
    );
    return QuotaList.fromJson(response);
  }
  static Future<CommonResult> uploadAppFile( int type, String path) async {
    MultipartFile multipartFile = MultipartFile.fromFileSync(
      path,
      // 文件名
      filename: 'some-file-name.jpg',
      // 文件类型
      contentType: MediaType("image", "jpg"),
    );
    FormData formData = FormData.fromMap({
      // 后端接口的参数名称
      "resource": multipartFile
    });
    Map<String, dynamic> params = Map();
    params['type'] = type;

    var response = await NewLoanHttpUtil().post(
      '/api/UploadAppFile' ,
      data: formData, queryParameters: params,
    );
    return CommonResult.fromJson(response);
  }
  static Future<SaleManGrid> getSaleManGrid() async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManGrid',
      data: {},
    );
    return SaleManGrid.fromJson(response);
  }

  static Future<SaleMan> getSaleManMyUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManMyUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }
  static Future<SaleMan> getManageMyUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageMyUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }
  static Future<SaleMan> getAdministrativeMyUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeMyUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }

  static Future<SaleMan> getSuperMyUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperMyUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }
  static Future<SaleMan> getSuperAllUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperAllUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }
  static Future<SaleMan> getManageAllUserList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageAllUserList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }


  static Future<Channels> getSaleManChannel(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManChannel',
      data: data,
    );
    return Channels.fromJson(response);
  }
  static Future<Channels> getManageChannel(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageChannel',
      data: data,
    );
    return Channels.fromJson(response);
  }
  static Future<Channels> getAdministrativeChannel(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeChannel',
      data: data,
    );
    return Channels.fromJson(response);
  }
  static Future<Channels> getSuperChannel(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperChannel',
      data: data,
    );
    return Channels.fromJson(response);
  }


  static Future<SuperDirector> getSuperDirector(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperDirector',
      data: data,
    );
    return SuperDirector.fromJson(response);
  }

  static Future<SuperDirector> getManageSubordinate(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageSubordinate',
      data: data,
    );
    return SuperDirector.fromJson(response);
  }


  static Future<Step> getSaleManStep(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManStep',
      data: data,
    );
    return Step.fromJson(response);
  }
  static Future<Step> getManageStep(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageStep',
      data: data,
    );
    return Step.fromJson(response);
  }
  static Future<Step> getAdministrativeStep(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeStep',
      data: data,
    );
    return Step.fromJson(response);
  }
  static Future<Step> getSuperStep(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperStep',
      data: data,
    );
    return Step.fromJson(response);
  }


  static Future<Staff> getSaleManStaff(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManStaff',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> getManageStaff(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageStaff',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> geAdministrativeStaff(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeStaff',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> getSuperStaff(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperStaff',
      data: data,
    );
    return Staff.fromJson(response);
  }


  static Future<Staff> getManageEmployees(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageEmployees',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> geAdministrativeEmployees(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeEmployees',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> getSuperEmployees(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSuperEmployees',
      data: data,
    );
    return Staff.fromJson(response);
  }

  static Future<Staff> changeSaleManStepStatus(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/ChangeSaleManStepStatus',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<Staff> changeSaleBaseInfo(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/ChangeSaleBaseInfo',
      data: data,
    );
    return Staff.fromJson(response);
  }
  static Future<SaleManDetail> getSaleManDetail(int id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetSaleManDetail',
      data: {"id":id},
    );
    return SaleManDetail.fromJson(response);
  }
  static Future<SaleManDetail> getAdministrativeAuditList(int id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetAdministrativeAuditList',
      data: {"id":id},
    );
    return SaleManDetail.fromJson(response);
  }
  static Future<SaleMan> getManageAbandonList(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetManageAbandonList',
      data: data,
    );
    return SaleMan.fromJson(response);
  }
  static Future<CommonResult> superDivide(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/SuperDivide',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> manageDivide(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/ManageDivide',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> manageAbandonDivide(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/ManageAbandonDivide',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> manageAddUser(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/ManageAddUser',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> createManageChannel(Map<String,dynamic> data) async {
    var response = await NewLoanHttpUtil().post(
      '/api/CreateManageChannel',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<AppVersionEntity> getVersion() async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/auth/version',
      data: {},
    );
    return AppVersionEntity.fromJson(response);
  }
  static Future<LoginEntity> login(String username, String password) async {
    var data = {'username': username, 'password': password};
    var response = await NewLoanHttpUtil().post(
      '/api/CktAppLogin',
      data: data,
    );
    return LoginEntity.fromJson(response);
  }
  static Future<AppVersionEntity> getWxLogin() async {
    var data = {};
    var response = await NewERPHttpUtil().post(
      '/api/GetWxStatus',
      data: data,
    );
    return AppVersionEntity.fromJson(response);
  }

  static Future<LoginEntity> wxLogin(String code) async {
    var data = {'code': code};
    var response = await NewERPHttpUtil().post(
      '/api/ErpAppLogin',
      data: data,
    );
    return LoginEntity.fromJson(response);
  }
  static Future<CommonResult> bindAppWeChat(String code) async {
    var response = await NewERPHttpUtil().post(
      '/api/bindAppWeChat',
      data: {"code":code},
    );
    return CommonResult.fromJson(response);
  }
  static Future<Stores> getOnlyStoreList() async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/store/select',
      queryParameters: {},
    );
    return Stores.fromJson(response);
  }
  static Future<ErpUserResult> getErpUsers(String storeId) async {
    var response = await NewERPHttpUtil().post(
      '/api/GetErpUserByStoreId',
      queryParameters: {'store_id': storeId},
    );
    return ErpUserResult.fromJson(response);
  }
  static Future<TreeStoreResult> getTreeStoreList() async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/system/user/getTreeStoreOnline',
      data: {},
    );
    return TreeStoreResult.fromJson(response);
  }
  static Future<UserDetailResult> getUserDetail(String uuid) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/detail/'+uuid,
      queryParameters: {},
    );
    return UserDetailResult.fromJson(response);
  }
  static Future<ConnectDataResult> getConnectList(String uuid, int page) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/connectList',
      queryParameters: {'customer_uuid': uuid, 'currentPage': page, "pageSize": 20},
    );
    return ConnectDataResult.fromJson(response);
  }
  static Future<ConnectDataResult> getConnectListCheck(String uuid, int page) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/GetConnectListCheck',
      queryParameters: {'customer_uuid': uuid, 'currentPage': page, "pageSize": 20},
    );
    return ConnectDataResult.fromJson(response);
  }
  static Future<AppointDataResult> getAppointmentList(String uuid, int page) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/appointmentList',
      queryParameters: {'customer_uuid': uuid, 'currentPage': page, "pageSize": 20},
    );
    return AppointDataResult.fromJson(response);
  }

  static Future<UserActionDataResult> getActionList(String uuid, int page) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/actionList',
      queryParameters: {'customer_uuid': uuid, 'currentPage': page, "pageSize": 20},
    );
    return UserActionDataResult.fromJson(response);
  }
  static Future<CallLogDataResult> getCallList(String uuid, int page) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/callLogs',
      queryParameters: {'customer_uuid': uuid, 'currentPage': page, "pageSize": 20},
    );
    return CallLogDataResult.fromJson(response);
  }
  static Future<ViewCallResult> viewCall(String uuid) async {
    var response = await NewERPHttpUtil().get(
      '/api/v1/auth/getCustomerMobile/' + uuid,
      queryParameters: {'customer_uuid': uuid},
    );
    return ViewCallResult.fromJson(response);
  }

  static Future<ClaimCustomerResult> claimCustomer(String uuid) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/public/claimCustomer',
      queryParameters: {'customer_uuids[0]': uuid},
    );
    return ClaimCustomerResult.fromJson(response);
  }
  static Future<StoreVipDataResult> getStoreVips() async {
    var response = await NewERPHttpUtil().post(
      '/api/GetStoreVips',
      data: {},
    );
    return StoreVipDataResult.fromJson(response);
  }
  static Future<FreeVipDataResult> addMealFree( Map<String, dynamic> data) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/store/addMealFree',
      data: data,
    );

    return FreeVipDataResult.fromJson(response);
  }
  static Future<CommonResult> buyVip( Map<String, dynamic> data) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/buyVip',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<UserDataResult> getErpUser() async {
    var response = await NewERPHttpUtil().post(
      '/api/UserList',
      data: {},
    );
    return UserDataResult.fromJson(response);
  }

  static Future<CommonResult> distribute(String uuid, int type, int userUuid) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/system/distribute',
      data: {'customer_uuid': uuid, 'type': type, 'user_id': userUuid},
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> editCustomerOnceString(String uuid, String type, String answer) async {
    Map<String, dynamic> searchParam = {};
    searchParam[type] = answer;
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/editCustomer/' + uuid,
      data: searchParam,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> editCustomerOnceStringResource(String uuid, String type, String url) async {
    var data = {
      'resources': json.encode([
        {'type': type, 'file_url': url}
      ])
    };
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/editCustomer/' + uuid,
      data: data,
    );
    return CommonResult.fromJson(response);
  }

  static Future<CommonResult> editCustomerAddress(String uuid, Map<String, dynamic> searchParam) async {

    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/editCustomer/' + uuid,
      data: searchParam,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> editCustomerDemndAddress(String uuid, Map<String, dynamic> searchParam) async {

    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/editCustomerDemand/' + uuid,
      data: searchParam,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> editCustomerDemandOnce(String uuid, String type, String answer) async {
    Map<String, dynamic> searchParam = {};
    searchParam[type] = answer;
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/editCustomerDemand/' + uuid,
      data: searchParam,
    );
    return CommonResult.fromJson(response);
  }

  static Future<DashBordDataResult> getDashBord() async {
    var response = await NewERPHttpUtil().post(
      '/api/DashBord',
      data: {},
    );
    return DashBordDataResult.fromJson(response);
  }


  static Future<CommonResult> delPhoto( int imgId,) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/deleteResources' ,
      data: {'id': imgId},
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> uploadPhotoFile( int type, String path) async {
    MultipartFile multipartFile = MultipartFile.fromFileSync(
      path,
      // 文件名
      filename: 'some-file-name.jpg',
      // 文件类型
      contentType: MediaType("image", "jpg"),
    );
    FormData formData = FormData.fromMap({
      // 后端接口的参数名称
      "resource": multipartFile
    });
    Map<String, dynamic> params = Map();
    params['type'] = type;

    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/uploadPic' ,
        data: formData, queryParameters: params,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> addCustomer(String mobile,
      String name,
      int gender,
      String birthday,
      int marriage,
      int channel,) async {
    Map<String, dynamic> data = {};
    data['mobile'] = mobile;
    data['name'] = name;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['marriage'] = marriage;
    data['channel'] = channel;
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/personal/addCustomer',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<HomeEntity> searchCustomer(   String page,
      String keyWord,) async {
    Map<String, dynamic> data = {};
    data['app'] = keyWord;
    data['currentPage'] = page;
    data['pageSize'] = 20;
    var response = await NewERPHttpUtil().get(
      '/api/v1/customer/system/index',
      queryParameters: data,
    );
    return HomeEntity.fromJson(response);
  }
  static Future<CommonResult> addAppoint(  String uuid, Map<String, dynamic> data) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/addAppointment',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> addConnect(  String uuid, Map<String, dynamic> data) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/addConnect',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> addConnectCheck(  String uuid, Map<String, dynamic> data) async {
    var response = await NewERPHttpUtil().post(
      '/api/v1/customer/addConnectCheck',
      data: data,
    );
    return CommonResult.fromJson(response);
  }
  static Future<CommonResult> getUserStatus() async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetUserStatus',
      queryParameters: {},
    );
    return CommonResult.fromJson(response);
  }
  static Future<Group> getGroupInfo(String id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetGroupInfo',
      data: {"id":id},
    );
    return Group.fromJson(response);
  }
  static Future<Group> getMemberInfo(String id) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetMemberInfo',
      data: {"id":id},
    );
    return Group.fromJson(response);
  }
  static Future<Friend> getGroupMembers(int page) async {
    var response = await NewLoanHttpUtil().post(
      '/api/GetGroupMembers',
      data: {"currentPage":page},
    );
    return Friend.fromJson(response);
  }





  static Future<WxArticleEntity> wxArticle(  int page, final List<SelectItem> selectItems) async {
    Map<String, dynamic> searchParm = {};
    searchParm['currentPage'] = page;

    selectItems.map((e) {
      if (e.type == 300) {
        searchParm['start_age'] = e.id;
      }
      if (e.type == 301) {
        searchParm['end_age'] = e.id;
      }
      if (e.type == 600) {
        if (e.id != "0") {
          searchParm['store_id'] = e.id;
        }
      }
      if (e.type == 1000) {
        searchParm['gender'] = e.id;
      }
    }).toList();
    Map<String, dynamic> response = await NewERPHttpUtil().post(
      '/api/IPadCommonArticle',
      data: searchParm,
    );
    return WxArticleEntity.fromJson(response);
  }
  /// 登录
  static Future<HomeEntity> searchErpUser(
      String page,
      int sex,
      int mode,
      int serveType,
      final List<SelectItem> selectItems) async {
    Map<String, dynamic> searchParam = {};
    var channel = <String>[];
    var education = <String>[];
    var income = <String>[];
    var house = <String>[];
    var marriage = <String>[];
    var startBirthday = "";
    var endBirthday = "";
    var storeId = "0";
    var userId = "0";
    selectItems.map((e) {
      if (e.type == 100) {
        searchParam['store_id'] = e.id;
      }
      if (e.type == 120) {
        if (e.id == "1") {
          searchParam['status'] = 1;
        }
        if (e.id == "2") {
          searchParam['status'] = 2;
        }
        if (e.id == "30") {
          searchParam['status'] = 30;
        }
        if (e.id == "100") {
          searchParam['status'] = 0;
        }
      }
      if (e.type == 130) {
        searchParam['connect'] = e.id;
      }
      if (e.type == 0) {
        channel.add(e.id!);
      }
      if (e.type == 1) {
        education.add(e.id!);
      }
      if (e.type == 2) {
        income.add(e.id!);
      }
      if (e.type == 3) {
        house.add(e.id!);
      }
      if (e.type == 4) {
        marriage.add(e.id!);
      }

      if (e.type == 5) {
        startBirthday = e.id.toString();
      }
      if (e.type == 6) {
        endBirthday = e.id.toString();
      }
      if (e.type == 7) {
        storeId = e.id!;
      }
      if (e.type == 8) {
        userId = e.id!;
      }
    }).toList();
    if (channel.isNotEmpty) {
      searchParam['channel_multi'] = channel.join(",");
    }

    if (education.isNotEmpty) {
      searchParam['education_multi'] = education.join(",");
    }

    if (income.isNotEmpty) {
      searchParam['income_multi'] = income.join(",");
    }
    if (house.isNotEmpty) {
      searchParam['house_multi'] = house.join(",");
    }

    if (marriage.isNotEmpty) {
      searchParam['marriage_multi'] = marriage.join(",");
    }
    if (startBirthday != "" && endBirthday != "") {
      searchParam['startBirthday'] = startBirthday;
      searchParam['endBirthday'] = endBirthday;
    }
    // if (storeId !=""){
    //
    //   searchParm['store_id'] = storeId;
    //
    // }
    if (userId != "") {
      searchParam['user_id'] = userId;
    }

    searchParam['gender'] = sex;

    searchParam['pageSize'] = 20;
    searchParam['currentPage'] = page;
    String url = "/api/v1/customer/system/index";
    if (mode == 10) {
      //全部
      url = "/api/v1/customer/system/index";
    }
    if (mode == 1) {
      //良缘
      url = "/api/v1/customer/passive/index";
    }
    if (mode == 2) {
      //我的
      url = "/api/v1/customer/personal/index";
      searchParam['type'] = serveType;
    }
    if (mode == 3) {
      //我的
      url = "/api/v1/customer/public/index";
    }
    var response = await NewERPHttpUtil().get(
      url,
      queryParameters: searchParam,
    );
    return HomeEntity.fromJson(response);
  }
  static Future<HomeEntity> searchErpUserCheck(
      String page,
      int sex,
      int mode,
      int serveType,
      final List<SelectItem> selectItems) async {
    Map<String, dynamic> searchParam = {};
    var channel = <String>[];
    var education = <String>[];
    var income = <String>[];
    var house = <String>[];
    var marriage = <String>[];
    var startBirthday = "";
    var endBirthday = "";
    var storeId = "0";
    var userId = "0";
    selectItems.map((e) {
      if (e.type == 100) {
        searchParam['store_id'] = e.id;
      }
      if (e.type == 120) {
        if (e.id == "1") {
          searchParam['status'] = 1;
        }
        if (e.id == "2") {
          searchParam['status'] = 2;
        }
        if (e.id == "30") {
          searchParam['status'] = 30;
        }
        if (e.id == "100") {
          searchParam['status'] = 0;
        }
      }
      if (e.type == 130) {
        searchParam['connect'] = e.id;
      }
      if (e.type == 0) {
        channel.add(e.id!);
      }
      if (e.type == 1) {
        education.add(e.id!);
      }
      if (e.type == 2) {
        income.add(e.id!);
      }
      if (e.type == 3) {
        house.add(e.id!);
      }
      if (e.type == 4) {
        marriage.add(e.id!);
      }

      if (e.type == 5) {
        startBirthday = e.id.toString();
      }
      if (e.type == 6) {
        endBirthday = e.id.toString();
      }
      if (e.type == 7) {
        storeId = e.id!;
      }
      if (e.type == 8) {
        userId = e.id!;
      }
    }).toList();
    if (channel.isNotEmpty) {
      searchParam['channel_multi'] = channel.join(",");
    }

    if (education.isNotEmpty) {
      searchParam['education_multi'] = education.join(",");
    }

    if (income.isNotEmpty) {
      searchParam['income_multi'] = income.join(",");
    }
    if (house.isNotEmpty) {
      searchParam['house_multi'] = house.join(",");
    }

    if (marriage.isNotEmpty) {
      searchParam['marriage_multi'] = marriage.join(",");
    }
    if (startBirthday != "" && endBirthday != "") {
      searchParam['startBirthday'] = startBirthday;
      searchParam['endBirthday'] = endBirthday;
    }
    // if (storeId !=""){
    //
    //   searchParm['store_id'] = storeId;
    //
    // }
    if (userId != "") {
      searchParam['user_id'] = userId;
    }

    searchParam['gender'] = sex;

    searchParam['pageSize'] = 20;
    searchParam['currentPage'] = page;
    String url = "/api/v1/customer/system/SystemIndexCheck";
    if (mode == 10) {
      //全部
      url = "/api/v1/customer/system/SystemIndexCheck";
    }
    if (mode == 1) {
      //良缘
      url = "/api/v1/customer/passive/index";
    }
    if (mode == 2) {
      //我的
      url = "/api/v1/customer/personal/index";
      searchParam['type'] = serveType;
    }
    if (mode == 3) {
      //我的
      url = "/api/v1/customer/public/index";
    }
    var response = await NewERPHttpUtil().get(
      url,
      queryParameters: searchParam,
    );
    return HomeEntity.fromJson(response);
  }

}
