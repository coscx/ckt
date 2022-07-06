import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../common/apis/common.dart';
import '../../common/entities/loan/quota.dart';
import '../../common/routers/names.dart';
import 'state.dart';

class CalcucationPrepareLogic extends GetxController {
  final CalcucationPrepareState state = CalcucationPrepareState();
  ScrollController scrollController = ScrollController();

  final applyMoneyController = TextEditingController(text: '');
  FocusNode applyMoneyFieldNode = FocusNode();

  final houseValueController = TextEditingController(text: '');
  FocusNode houseValueFieldNode= FocusNode();

  final incomeController = TextEditingController(text: '');
  FocusNode incomeFieldNode= FocusNode();

  final loanRemainController = TextEditingController(text: '');
  FocusNode loanRemainFieldNode= FocusNode();

  final houseLoanController = TextEditingController(text: '');
  FocusNode houseLoanFieldNode= FocusNode();

  final carLoanController = TextEditingController(text: '');
  FocusNode carLoanFieldNode= FocusNode();

  final bigSpecialController = TextEditingController(text: '');
  FocusNode bigSpecialFieldNode= FocusNode();

  final onetimeGiveMoneyController = TextEditingController(text: '');
  FocusNode onetimeGiveMoneyFieldNode= FocusNode();

  final onetimeGiveDateController = TextEditingController(text: '');
  FocusNode onetimeGiveDateFieldNode= FocusNode();
  var verticalGroupValue = "8年".obs;

  List<String> status = ["8年", "5年", "3年"];
  setFocus(){
    applyMoneyFieldNode.unfocus();
    houseValueFieldNode.unfocus();
    incomeFieldNode.unfocus();
    loanRemainFieldNode.unfocus();
    houseLoanFieldNode.unfocus();
    carLoanFieldNode.unfocus();
    bigSpecialFieldNode.unfocus();
    onetimeGiveMoneyFieldNode.unfocus();
    onetimeGiveDateFieldNode.unfocus();
  }
  int getGroup(String g){
    if(g=="8年"){
      return 8;
    }
    if(g=="5年"){
      return 5;
    }
    if(g=="3年"){
      return 3;
    }
    return 0;
  }


   getResult() async {

     if (applyMoneyController.text==""){
       Fluttertoast.showToast(
           msg: "请填写申请金额" ,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 2,
           backgroundColor: Colors.black.withAlpha(100),
           textColor: Colors.white,
           fontSize: 14.0);
       scrollController.jumpTo(0);
       applyMoneyFieldNode.requestFocus();
       return;
     }
     if (houseValueController.text==""){
       Fluttertoast.showToast(
           msg: "请填写房产市场金额" ,
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 2,
           backgroundColor: Colors.black.withAlpha(100),
           textColor: Colors.white,
           fontSize: 14.0);
       scrollController.jumpTo(0);
       houseValueFieldNode.requestFocus();
       return;
     }

     var r = Get.arguments;
     Map<String,dynamic> data ={
       "user_id":182,
       "name":r["name"],
       "mobile":r["mobile"],
       "apply_month":getGroup(verticalGroupValue.value),
       "apply_money":applyMoneyController.text,
       "house_market_value":houseValueController.text,
       "income":incomeController.text,

       "mortgage_monthly_repayment":houseLoanController.text,
       "car_mortgage_monthly_repayment":carLoanController.text,
       "house_mortgage_loan_balance":loanRemainController.text,
       "large_special_scale_monthly":bigSpecialController.text,

       "onetime_repayment_money1":onetimeGiveMoneyController.text,
       "onetime_repayment_amount1":onetimeGiveDateController.text,

     };
     Quota result =  await CommonAPI.GetAppQuotaCalculation(data);
     setFocus();
     int? d = int.tryParse(result.data!.result);
     if (d==null){
       result.data?.result = "";
     }else{
       if (d <= 0){
         result.data?.result = "";
       }
     }
     Get.toNamed(AppRoutes.CalcucationResult,arguments: result.data?.result.toString());
   }
}
