import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/apis/common.dart';
import '../../common/entities/loan/quota.dart';
import '../../common/routers/names.dart';
import 'state.dart';

class CalcucationPrepareLogic extends GetxController {
  final CalcucationPrepareState state = CalcucationPrepareState();


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
   getResult() async {
     var r = Get.arguments;
     Map<String,dynamic> data ={
       "user_id":182,
       "name":r["name"],
       "mobile":r["mobile"],
       "apply_month":8,
       "apply_money":applyMoneyController.text,
       "house_market_value":houseValueController.text,

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
