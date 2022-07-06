import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../common/apis/common.dart';
import '../../common/entities/loan/quota.dart';
import '../../common/routers/names.dart';
import 'state.dart';

class CalcucationExactLogic extends GetxController {
  final CalcucationExactState state = CalcucationExactState();
  var v2 =false.obs;
  var v3 =false.obs;
  int i=1;

  ScrollController scrollController = ScrollController();

  final applyMoneyController = TextEditingController(text: '');
  FocusNode applyMoneyFieldNode = FocusNode();

  final incomeController = TextEditingController(text: '');
  FocusNode incomeFieldNode= FocusNode();

  final operateController = TextEditingController(text: '');
  FocusNode operateFieldNode= FocusNode();

  final companyDueController = TextEditingController(text: '');
  FocusNode companyDueFieldNode= FocusNode();

  final houseRentController = TextEditingController(text: '');
  FocusNode houseRentFieldNode= FocusNode();

  final runCarController = TextEditingController(text: '');
  FocusNode runCarFieldNode= FocusNode();

  final day12Controller = TextEditingController(text: '');
  FocusNode day12FieldNode= FocusNode();

  final hourDotController = TextEditingController(text: '');
  FocusNode hourDotFieldNode= FocusNode();

  final houseValueController = TextEditingController(text: '');
  FocusNode houseValueFieldNode= FocusNode();

  final loanController = TextEditingController(text: '');
  FocusNode loanFieldNode= FocusNode();

  final totalPersonController = TextEditingController(text: '');
  FocusNode totalPersonFieldNode= FocusNode();

  final otherIncomeController = TextEditingController(text: '');
  FocusNode otherIncomeFieldNode= FocusNode();

  final houseLoanController = TextEditingController(text: '');
  FocusNode houseLoanFieldNode= FocusNode();

  final allLoanController = TextEditingController(text: '');
  FocusNode allLoanFieldNode= FocusNode();

  final bigSpecialController = TextEditingController(text: '');
  FocusNode bigSpecialFieldNode= FocusNode();

  final credit6UseController = TextEditingController(text: '');
  FocusNode credit6UseFieldNode= FocusNode();

  final credit6NoUseController = TextEditingController(text: '');
  FocusNode credit6NoUseFieldNode= FocusNode();

  final onetimeGiveMoney1Controller = TextEditingController(text: '');
  FocusNode onetimeGiveMoney1FieldNode= FocusNode();

  final onetimeGiveDate1Controller = TextEditingController(text: '');
  FocusNode onetimeGiveDate1FieldNode= FocusNode();

  final onetimeGiveMoney2Controller = TextEditingController(text: '');
  FocusNode onetimeGiveMoney2FieldNode= FocusNode();

  final onetimeGiveDate2Controller = TextEditingController(text: '');
  FocusNode onetimeGiveDate2FieldNode= FocusNode();

  final onetimeGiveMoney3Controller = TextEditingController(text: '');
  FocusNode onetimeGiveMoney3FieldNode= FocusNode();

  final onetimeGiveDate3Controller = TextEditingController(text: '');
  FocusNode onetimeGiveDate3FieldNode= FocusNode();

  final repayController = TextEditingController(text: '');
  FocusNode repayFieldNode= FocusNode();

  final guaranteeController = TextEditingController(text: '');
  FocusNode guaranteeFieldNode= FocusNode();

  var verticalGroupValue = "8年".obs;

  List<String> status = ["8年", "5年", "3年"];
  setFocus(){
     applyMoneyFieldNode.unfocus();
     incomeFieldNode.unfocus();
     operateFieldNode.unfocus();
     companyDueFieldNode.unfocus();
     houseRentFieldNode.unfocus();
     runCarFieldNode.unfocus();
     day12FieldNode.unfocus();
     hourDotFieldNode.unfocus();
     houseValueFieldNode.unfocus();
     loanFieldNode.unfocus();
     totalPersonFieldNode.unfocus();
     otherIncomeFieldNode.unfocus();
     houseLoanFieldNode.unfocus();
     allLoanFieldNode.unfocus();
     bigSpecialFieldNode.unfocus();
     credit6UseFieldNode.unfocus();
     credit6NoUseFieldNode.unfocus();
     onetimeGiveMoney1FieldNode.unfocus();
     onetimeGiveDate1FieldNode.unfocus();
     onetimeGiveMoney2FieldNode.unfocus();
     onetimeGiveDate2FieldNode.unfocus();
     onetimeGiveMoney3FieldNode.unfocus();
     onetimeGiveDate3FieldNode.unfocus();
     repayFieldNode.unfocus();
     guaranteeFieldNode.unfocus();

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
  showAdd(){
    i++;
    if (i==2){
      v2.value = true;
      v3.value = false;
    }
    if (i==3){
      v2.value = true;
      v3.value = true;
    }
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
    if (totalPersonController.text==""){
      Fluttertoast.showToast(
          msg: "请填写共有人数" ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black.withAlpha(100),
          textColor: Colors.white,
          fontSize: 14.0);
      scrollController.jumpTo(0);
      totalPersonFieldNode.requestFocus();
      return;
    }
    var r = Get.arguments;
    Map<String,dynamic> data ={
      "type":1,
      "user_id":182,
      "name":r["name"],
      "mobile":r["mobile"],
      "apply_month":getGroup(verticalGroupValue.value),
      "apply_money":applyMoneyController.text,
      "house_market_value":houseValueController.text,
      "income":incomeController.text,
      "house_total_person":totalPersonController.text,
      "personal_business_income":operateController.text,
      "company_dividends":companyDueController.text,
      "rental_income":houseRentController.text,
      "business_vehicle_income":runCarController.text,
      "finance_past12_balance":day12Controller.text,
      "finance_point_balance":hourDotController.text,
      "house_mortgage_loan_balance":loanController.text,
      "other_income_money":otherIncomeController.text,
      "mortgage_monthly_repayment":houseLoanController.text,
      "debt_monthly_repayments":allLoanController.text,
      "large_special_scale_monthly":bigSpecialController.text,
      "credit_recent6_usage_amount":credit6UseController.text,
      "credit_recent6_noused_amount":credit6NoUseController.text,
      "onetime_repayment_money1":onetimeGiveMoney1Controller.text,
      "onetime_repayment_amount1":onetimeGiveDate1Controller.text,
      "onetime_repayment_money2":onetimeGiveMoney2Controller.text,
      "onetime_repayment_amount2":onetimeGiveDate2Controller.text,
      "onetime_repayment_money3":onetimeGiveMoney3Controller.text,
      "onetime_repayment_amount3":onetimeGiveDate3Controller.text,
      "oneoff_deductible_monthly_debt":repayController.text,
      "abnormal_guarantee_balance":guaranteeController.text
    };
    Quota result =  await CommonAPI.GetAppQuotaCalculation(data);
    if (result.code !=200){
      Fluttertoast.showToast(
          msg: result.msg ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black.withAlpha(100),
          textColor: Colors.white,
          fontSize: 14.0);
          scrollController.jumpTo(ScreenUtil().screenHeight*1.2);

      return;
    }
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
