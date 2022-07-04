import 'package:flutter_ckt/common/entities/login/account.dart';
import 'package:get/get.dart';

import '../../common/routers/names.dart';
import '../../common/services/storage.dart';
import '../../common/store/user.dart';
import 'state.dart';

class ChangeAccountLogic extends GetxController {
  final ChangeAccountState state = ChangeAccountState();

  var manage =true.obs;
  List<Account> account = <Account>[];
 @override
  void onInit() {
   var data  = UserStore.to.getAccount();
    print(data);
    account.addAll(data!.account!);
    super.onInit();
  }

  removeAccount( Account account1) async {
     account.removeWhere((element) => element.memberid == account1.memberid);
     UserStore.to.removeAccount(account1.memberid);
     update();
  }
  changeAccount(Account result) async {
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
    Get.offAndToNamed(AppRoutes.ChangeJump);
  }
}
