import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;
import '../../../common/apis/common.dart';
import '../../../common/services/storage.dart';
import '../../user_detail/widget/common_dialog.dart';
import 'state.dart';

class PersonLogic extends GetxController {
  final PersonState state = PersonState();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  var popString = ['清空记录', '删除好友', '加入黑名单'];
  int offset = 0;
  var memberId="0";
  int limit = 10; //一次加载10条数据,不建议加载太多。
  var name ="MSTAR";
  String bind="微信绑定";
  String lost="0";
  String join="0";
  String connect="0";
  var userHead =
      'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
  void onRefresh() async {

    offset = 0;
    refreshController.refreshCompleted();
  }


  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init()async{

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
      var result = await CommonAPI.getDashBord();
      if (result.code == 200) {
        var d = result.data.top;

        lost = d.yesterdayLost.toString();
        join = d.yesterdayCreate.toString();
        connect = d.yesterdayConnect.toString();


      } else {

      }
      update();
    });
  }

  void bindWxOnTap(){
    fluwx
        .sendWeChatAuth(
        scope: "snsapi_userinfo", state: "wechat_sdk_demo_bind")
        .then((data) {});
  }
}
