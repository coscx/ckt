import 'package:get/get.dart';

import '../../common/entities/login/account.dart';
import '../../common/routers/names.dart';
import '../../common/services/storage.dart';
import '../../common/store/user.dart';
import 'state.dart';

class ChangeJumpLogic extends GetxController {
  final ChangeJumpState state = ChangeJumpState();
  @override
  void onInit() {

    Future.delayed(const Duration(milliseconds: 1), () async {
      Account result = Get.arguments;
      await StorageService.to.setString("im_sender", result.imSender);
      await StorageService.to.setString("name", result.name);
      await StorageService.to.setString("uuid", result.uuid);
      await StorageService.to.setString("openid", result.openid);
      await StorageService.to.setString("user_token", result.userToken);
      await StorageService.to.setString("fresh_token", result.freshToken);
      await StorageService.to.setString("memberId", result.memberid);
      await StorageService.to.setString("im_token", result.imToken);
      await StorageService.to.setString("avatar", result.avatar);
      await StorageService.to.setString("roleId", result.roleid);
      await StorageService.to.setString("mobile", result.mobile);
      await StorageService.to.setString("roleId", result.roleId.toString());
      await StorageService.to.setString("roleName", result.roleName.toString());
      await StorageService.to.setString("roleKey", result.roleKey.toString());
      await UserStore.to.setToken(result.userToken);
      await UserStore.to.saveAccountProfile(result);
      Get.toNamed(AppRoutes.Application);

    });

    super.onInit();
  }
}
