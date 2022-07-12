import 'package:flutter/cupertino.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/common/entities/detail/store_vip.dart';
import 'package:get/get.dart';

import '../../common/entities/home/common.dart';
import '../user_detail/widget/common_dialog.dart';
import 'state.dart';

class AddVipLogic extends GetxController {
  final AddVipState state = AddVipState();
  var startBirthDay = DateTime.now().obs;
  var startBirthDayTitle = DateTime.now().toString().substring(0, 19).obs;
  var startBirthDayValue = DateTime.now().toString().substring(0, 19).obs;
  String store = "";
  var storeName = "选择会员套餐".obs;
  String price = "";
  String month = "";
  String count = "";
  String tag = "";
  int type = 0;
  int vipId = 0;
  int minValue= 18;
  int maxValue=80;
  int sexSelect = 0;
  Map<String,dynamic> args = <String,dynamic>{};
  List<String> pickerStoreData = [];
  List<StoreItem> pickerStoreItem = [];
  bool isButton1Disabled = false;
  final vipPriceController = TextEditingController(text: '');
  final vipMonthController = TextEditingController(text: '');
  final vipCountController = TextEditingController(text: '');
  final tagController = TextEditingController(text: '');
  FocusNode remarkFieldNode = FocusNode();

  @override
  void onInit() {
    args =Get.arguments;
    minValue = 18;
    maxValue = 80;
    Future.delayed(const Duration(milliseconds: 1)).then((e) async {
      var result = await CommonAPI.getStoreVips();
      if (result.code == 200) {
        var y = result.data;
        List<StoreVip> da = y.data ;

        StoreItem ff = StoreItem();
        ff.id = 0;
        ff.type = 600;
        ff.name = "请选择";
        ff.index = 0;
        ff.isSelect = false;
        pickerStoreItem.add(ff);
        pickerStoreData.add(ff.name!);
        for (var value in da) {
          StoreItem ff = StoreItem();
          ff.id = value.id;
          ff.type = 600;
          ff.name = value.name;
          ff.price = value.favorable;
          ff.month = value.time.toString();
          ff.count = value.meet.toString();
          ff.tag = value.description;
          ff.index = 0;
          ff.isSelect = false;
          pickerStoreItem.add(ff);
          pickerStoreData.add(value.name);
        }
        StoreItem ff1 = StoreItem();
        ff1.id = 9999;
        ff1.type = 9999;
        ff1.name = "自定义套餐";
        ff1.index = 0;
        ff1.price = "";
        ff1.month = "";
        ff1.count = "";
        ff1.tag ="";
        ff1.isSelect = false;
        pickerStoreItem.add(ff1);
        pickerStoreData.add(ff1.name!);
      } else {}
    });

    super.onInit();
  }

  Future<void> submit() async {
    var data = <String, dynamic>{};
    if (type == 9999) {
      tag = tagController.text;
      price = vipPriceController.text;
      month = vipMonthController.text;
      count = vipCountController.text;
    }
    if (vipId == 0) {
      showToastRed(Get.context!, "请选择套餐", true);
      return;
    }
    if (price == "") {
      showToastRed(Get.context!, "请输入套餐价格", true);
      return;
    }
    if (month == "") {
      showToastRed(Get.context!, "请输入套餐时长", true);
      return;
    }
    if (count == "") {
      showToastRed(Get.context!, "请输入套餐次数", true);
      return;
    }
    if (startBirthDayValue.value == "") {
      showToastRed(Get.context!, "请选择支付时间", true);
      return;
    }
    if (tag == "") {
      showToastRed(Get.context!, "请输入支付备注", true);
      return;
    }

    data['favorable'] = price;
    data['store_id'] = args['store_id'];
    data['time'] = month;
    data['meet'] = count;
    data['pay_time'] = startBirthDayValue.value;
    data['description'] = tag;
    data['name'] = "自定义套餐";
    data['original'] = price;
    data['services[0]'] = "";
    var results =
        await CommonAPI.addMealFree( data);
    if (results.code == 200) {
      var id = results.data.id;
      var data1 = <String, dynamic>{};
      data1['pay_price'] = price;
      data1['customer_uuid'] = args['uuid'];
      data1['pay_time'] = startBirthDayValue.value;
      data1['remark'] = tag;
      data1['vip_id'] = vipId;
      if (type == 9999) {
        data1['vip_id'] = id.id;
        data1['free'] = 1;
      }
      data['services[0]'] = "";
      var result = await CommonAPI.buyVip( data1);
      if (result.code== 200) {
        //print(result['data'] );
        showToast(Get.context!, "购买成功", true);

      } else {
        showToastRed(Get.context!, result.message!, true);
      }
    } else {
      showToastRed(Get.context!, results.message!, true);
    }
  }

}
