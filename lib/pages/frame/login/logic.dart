import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ckt/pages/user_detail/widget/common_dialog.dart';
import 'package:get/get.dart';

import '../../../common/apis/common.dart';
import '../../../common/routers/names.dart';
import '../../../common/services/storage.dart';
import '../../../common/store/user.dart';
import '../../../common/widgets/common_webview.dart';
import '../../../common/widgets/log_utils.dart';
import '../../../common/widgets/navigator_utils.dart';
import 'state.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final usernameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  FocusNode textFieldNode = FocusNode();
  //注册协议的手势
  var registProtocolRecognizer = TapGestureRecognizer();
  //隐私协议的手势
  var privacyProtocolRecognizer = TapGestureRecognizer();
  bool showPwd = false;
  var showWx =false.obs;
  String result = "无";
  bool autoLogin =true;
  bool privacy =false;
  @override
  void dispose() {
    registProtocolRecognizer.dispose();
    privacyProtocolRecognizer.dispose();
    super.dispose();
  }
  @override
  void onInit() {
    //wxInit();
    super.onInit();
  }
  //查看用户协议
  void openUserProtocol(BuildContext context) {
    LogUtils.e("查看用户协议");
    NavigatorUtils.pushPage(
      context: context,
      targPage: CommonWebViewPage(
        pageTitle: "用户协议",
        htmlUrl: "http://link.queqiaochina.com/agree.html",
      ),
    );
  }

  //查看隐私协议
  void openPrivateProtocol(BuildContext context) {
    LogUtils.e("查看隐私协议");
    NavigatorUtils.pushPage(
      context: context,
      targPage: CommonWebViewPage(
        pageTitle: "隐私协议",
        htmlUrl: "http://link.queqiaochina.com/privacy.html",
      ),
    );
  }
  Future<void> wxInit() async {
    fluwx.weChatResponseEventHandler
        .distinct((a, b) => a == b)
        .listen((res) async {
      if (res is fluwx.WeChatAuthResponse) {
        if (res.state == "wechat_sdk_demo_login") {
           wxToLogin( res.code!);
        }
      }
    });
    bool wx = await getWxLogin();
    if (wx){
      showWx.value =true;
    }

  }

  void wxLogin(){
    fluwx
        .sendWeChatAuth(
        scope: "snsapi_userinfo", state: "wechat_sdk_demo_login")
        .then((data) {});
  }

  Future<bool> getWxLogin() async {

    var result = await CommonAPI.getWxLogin();
    if (result.code == 200) {

    }
    return false;
  }
  Future<bool> login(String username, String password) async {
    EasyLoading.show(maskType:EasyLoadingMaskType.none );
    var result = await CommonAPI.login(username, password);
    if (result.code == 200) {
      await StorageService.to.setString("im_sender", result.data!.user!.id.toString());
      await StorageService.to.setString("name", result.data!.user!.relname);
      await StorageService.to.setString("uuid", result.data!.user!.uuid);
      await StorageService.to.setString("openid", result.data!.user!.openid);
      await StorageService.to.setString("user_token", result.data!.token!.accessToken);
      await StorageService.to.setString("fresh_token", result.data!.token!.refreshToken);
      await StorageService.to.setString("memberId", result.data!.user!.id.toString());
      await StorageService.to.setString("im_token", result.data!.imToken);
      await StorageService.to.setString("avatar", result.data!.user!.avatar);
      await StorageService.to.setString("roleId", result.data!.user!.roleId.toString());
      await StorageService.to.setString("roleName", result.data!.user!.roleName.toString());
      await StorageService.to.setString("roleKey", result.data!.user!.roleKey.toString());
      await StorageService.to.setString("mobile", result.data!.user!.mobile);
      await StorageService.to.setString("server_url","https://finance.queqiaochina.com");
      await StorageService.to.setString("url_tag","/prod-api");
      await UserStore.to.saveProfile(result);
      await UserStore.to.saveAccount(result);
      await UserStore.to.setToken(result.data!.token!.accessToken);
      EasyLoading.dismiss();

      if (result.data!.user!.messageCount == 1) {
        Get.offAndToNamed(AppRoutes.OAApplication);
      }else{
        Get.offAndToNamed(AppRoutes.Application);
      }
      return true;
    }else{
      showToastRed(Get.context!, result.msg, false);
    }
    EasyLoading.dismiss();
    //debugPrint(result.toJson().toString());
    return false;
  }

  Future<bool> wxToLogin(String code) async {
    EasyLoading.show();
    var result = await CommonAPI.wxLogin(code);
    if (result.code == 200) {
      await StorageService.to.setString("im_sender", result.data!.user!.id.toString());
      await StorageService.to.setString("name", result.data!.user!.relname);
      await StorageService.to.setString("uuid", result.data!.user!.uuid);
      await StorageService.to.setString("openid", result.data!.user!.openid);
      await StorageService.to.setString("user_token", result.data!.token!.accessToken);
      await StorageService.to.setString("fresh_token", result.data!.token!.refreshToken);
      await StorageService.to.setString("memberId", result.data!.user!.id.toString());
      await StorageService.to.setString("im_token", result.data!.imToken);
      await StorageService.to.setString("avatar", result.data!.user!.avatar);
      await StorageService.to.setString("roleId", result.data!.user!.roleId.toString());
      await StorageService.to.setString("roleName", result.data!.user!.roleName.toString());
      await StorageService.to.setString("roleKey", result.data!.user!.roleKey.toString());
      await StorageService.to.setString("mobile", result.data!.user!.mobile);
      await UserStore.to.saveProfile(result);
      await UserStore.to.saveAccount(result);
      await UserStore.to.setToken(result.data!.token!.accessToken);
      EasyLoading.dismiss();
      if (result.data!.user!.messageCount == 1) {
        Get.offAndToNamed(AppRoutes.OAApplication);
      }else{
        Get.offAndToNamed(AppRoutes.Application);
      }
      return true;
    }

    //debugPrint(result.toJson().toString());
    return false;
  }
}
