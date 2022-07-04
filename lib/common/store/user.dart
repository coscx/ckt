import 'dart:convert';

import 'package:flutter_ckt/common/apis/apis.dart';
import 'package:flutter_ckt/common/entities/login/account.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:flutter_ckt/common/values/values.dart';
import 'package:get/get.dart';

import '../entities/login/login_model.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  // 令牌 token
  String token = '';

  // 用户 profile
  final _profile = Account(
      imSender: "",
      name: "",
      uuid: "",
      openid:"",
      userToken: "",
      freshToken:"",
      memberid: "",
      imToken: "",
      avatar: "",
      roleid: "",
      messageCount: 0
  ).obs;

  bool get isLogin => _isLogin.value;

  Account get profile => _profile.value;

  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(Account.fromJson(jsonDecode(profileOffline)));
      _isLogin.value = true;
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // 保存 profile
  Future<void> saveProfile(LoginEntity result) async {
    _isLogin.value = true;
    var account =Account(
        imSender: result.data!.user.id.toString(),
        name: result.data!.user.relname,
        uuid: result.data!.user.uuid,
        openid: result.data!.user.openid,
        userToken: result.data!.token.accessToken,
        freshToken: result.data!.token.refreshToken,
        memberid: result.data!.user.id.toString(),
        imToken: result.data!.imToken,
        avatar: result.data!.user.avatar,
        roleid: result.data!.user.idcardVerified.toString(),
        messageCount: result.data!.user.messageCount,
    );
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(account));
  }
  Future<void> saveAccountProfile(Account result) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(result));
  }
  Future<void> saveAccount(LoginEntity result) async {
    var profileOffline = StorageService.to.getString(STORAGE_USER_ACCOUNT_KEY);
    if (profileOffline.isNotEmpty) {
      var data = AccountData.fromJson(jsonDecode(profileOffline));
      data.account?.removeWhere((element) => element.memberid == result.data!.user.id.toString());
      data.account?.add(Account(
          imSender: result.data!.user.id.toString(),
          name: result.data!.user.relname,
          uuid: result.data!.user.uuid,
          openid: result.data!.user.openid,
          userToken: result.data!.token.accessToken,
          freshToken: result.data!.token.refreshToken,
          memberid: result.data!.user.id.toString(),
          imToken: result.data!.imToken,
          avatar: result.data!.user.avatar,
          roleid: result.data!.user.idcardVerified.toString(),
          messageCount: result.data!.user.messageCount,));
      StorageService.to.setString(STORAGE_USER_ACCOUNT_KEY, jsonEncode(data));
    }else{
      var data = <Account>[];
      data.add(Account(
          imSender: result.data!.user.id.toString(),
          name: result.data!.user.relname,
          uuid: result.data!.user.uuid,
          openid: result.data!.user.openid,
          userToken: result.data!.token.accessToken,
          freshToken: result.data!.token.refreshToken,
          memberid: result.data!.user.id.toString(),
          imToken: result.data!.imToken,
          avatar: result.data!.user.avatar,
          roleid: result.data!.user.idcardVerified.toString(),
          messageCount: result.data!.user.messageCount
      ));
      var b=  AccountData(account: data);
      StorageService.to.setString(STORAGE_USER_ACCOUNT_KEY, jsonEncode(b));
    }
  }

  AccountData? getAccount() {
    var profileOffline = StorageService.to.getString(STORAGE_USER_ACCOUNT_KEY);
    if (profileOffline.isNotEmpty) {
      return AccountData.fromJson(jsonDecode(profileOffline));
    }
    return null;
  }

  bool removeAccount(String id) {
    var profileOffline = StorageService.to.getString(STORAGE_USER_ACCOUNT_KEY);
    if (profileOffline.isNotEmpty) {
      var data = AccountData.fromJson(jsonDecode(profileOffline));
      data.account?.removeWhere((element) => element.memberid == id.toString());
      StorageService.to.setString(STORAGE_USER_ACCOUNT_KEY, jsonEncode(data));
      return true;
    }
    return false;
  }

  // 注销
  Future<void> onLogout() async {
    if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    _isLogin.value = false;
    token = '';
  }
}
