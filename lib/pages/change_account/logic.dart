import 'package:flt_im_plugin/flt_im_plugin.dart';
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
    account.addAll(data!.account!);
    super.onInit();
  }

  removeAccount( Account account1) async {
     account.removeWhere((element) => element.memberid == account1.memberid);
     UserStore.to.removeAccount(account1.memberid);
     update();
  }
  changeAccount(Account result) async {
    FltImPlugin im = FltImPlugin();
    im.logout();
    Future.delayed(const Duration(milliseconds: 1)).then((e) async {
      await StorageService.to.remove("im_token");
      await StorageService.to.remove("memberId");
      await StorageService.to.remove("token");
      await StorageService.to.remove("user_token");
      await StorageService.to.remove("user_profile");
      Get.offAllNamed(AppRoutes.ChangeJump,arguments: result);
    });
  }
}
