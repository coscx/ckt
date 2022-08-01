import 'package:flutter_ckt/common/entities/loan/saleman_grid.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:get/get.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
import '../../common/apis/common.dart';
import '../user_detail/widget/common_dialog.dart';
import 'state.dart';

class MineLogic extends GetxController {
  final MineState state = MineState();
  var name ="MSTAR";
  String bind="微信绑定";
  var memberId="0";
  var userHead =
      'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
  String lost="0";
  String join="0";
  String connect="0";
  int index =0;
  SaleManGridDataData gridData = SaleManGridDataData(pendingcontact: 0, pendingsubmission: 0, pendingsupplement: 0);
  @override
  void onInit() {
    init();
    super.onInit();
  }
 void init()async{
   memberId = StorageService.to.getString("memberId");
   userHead = StorageService.to.getString("avatar");
   name = StorageService.to.getString("name");
   fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) async {
     if (res is fluwx.WeChatAuthResponse) {
       if(res.state =="wechat_sdk_demo_bind") {
         var result = await CommonAPI.bindAppWeChat(res.code!);
         if (result.code == 200) {
            //StorageService.to.setString("openid",result.data!.imToken);
             bind="已绑定微信";
             showToast(Get.context!, "绑定成功", false);
             update();
         } else {
            showToastRed(Get.context!, result.message!, false);
         }
       }
     }
   });
   Future.delayed(const Duration(milliseconds: 1)).then((e) async {
     name =   StorageService.to.getString("name");
     var openid=  StorageService.to.getString("openid");
     memberId = StorageService.to.getString("memberId");
     userHead = StorageService.to.getString("avatar");
     if(openid == ""){

     }else{
         bind="已绑定微信";
     }
     // var result = await CommonAPI.getDashBord();
     // if (result.code == 200) {
     //   var d = result.data.top;
     //
     //     lost = d.yesterdayLost.toString();
     //     join = d.yesterdayCreate.toString();
     //     connect = d.yesterdayConnect.toString();
     //
     //
     // } else {
     //
     // }
    update();
   });

   String  roleKey = StorageService.to.getString("roleKey");
   if(roleKey =="super"){
    index =0;
   }
   if(roleKey =="salesman"){
     index =1;
     var d = await CommonAPI.getSaleManGrid();
     if (d.data != null && d.data?.data != null) {
       gridData = d.data!.data!;
     }

   }
   if(roleKey =="director"){
     index =2;
   }

  }
  void bindWxOnTap(){
    fluwx
        .sendWeChatAuth(
        scope: "snsapi_userinfo", state: "wechat_sdk_demo_bind")
        .then((data) {});
  }

}
