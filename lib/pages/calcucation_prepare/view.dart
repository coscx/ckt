import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/input_formater.dart';
import 'logic.dart';

class CalcucationPreparePage extends StatelessWidget {
  final logic = Get.find<CalcucationPrepareLogic>();
  final state = Get.find<CalcucationPrepareLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme.of(context).copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light, // Status bar
              ),
            ),
          ),
          child: SafeArea(
              child: Scaffold(
                  backgroundColor: Color(0xffefefef),
                  appBar: AppBar(
                    titleSpacing: 220.w,
                    leadingWidth: 100.w,
                    elevation: 0,
                    title: Text("初步估算",
                        style: TextStyle(fontSize: 36.sp, color: Colors.black)),
                  ),
                  body: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          logic.setFocus();
                        },
                        child: Container(
                          child: ScrollConfiguration(
                              behavior: DyBehaviorNull(),
                              child: SingleChildScrollView(
                                 controller: logic.scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Container(
                                    padding: EdgeInsets.only(top: 30.h),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.w),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 30.w, right: 30.w),
                                            //height: 1100.h,
                                            child: Column(
                                              children: [
                                                buildCommonInput(
                                                    true,
                                                    "申请金额",
                                                    "请输入申请金额",
                                                    "万元",
                                                    logic.applyMoneyFieldNode,
                                                    logic.applyMoneyController, [
                                                  FilteringTextInputFormatter(RegExp("^100|[1-9]\\d{0,1}(?:\\.\\d{1,2})?\$"), allow: true),
                                                ]),
                                                Obx(() {
                                                  return _buildRadio(true,"申请年数");
                                                }),
                                                buildCommonInput(
                                                    true,
                                                    "房屋市场金额",
                                                    "请输入房屋市场金额",
                                                    "万元",
                                                    logic.houseValueFieldNode,
                                                    logic.houseValueController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),

                                                buildCommonInput(
                                                    false,
                                                    "工资收入",
                                                    "请输入工资收入",
                                                    "元",
                                                    logic.incomeFieldNode,
                                                    logic.incomeController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                buildCommonInput(
                                                    false,
                                                    "按揭贷款余额",
                                                    "请输入按揭贷款余额",
                                                    "元",
                                                    logic.loanRemainFieldNode,
                                                    logic.loanRemainController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                buildCommonInput(
                                                    false,
                                                    "房贷月还款额",
                                                    "请输入房贷月还款额",
                                                    "元",
                                                    logic.houseLoanFieldNode,
                                                    logic.houseLoanController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                buildCommonInput(
                                                    false,
                                                    "车贷月还款额",
                                                    "请输入房屋市场金额",
                                                    "元",
                                                    logic.carLoanFieldNode,
                                                    logic.carLoanController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                buildCommonInput(
                                                    false,
                                                    "大额专项分期每月还款之和",
                                                    "请输入大额专项分期每月还款之和",
                                                    "元",
                                                    logic.bigSpecialFieldNode,
                                                    logic.bigSpecialController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                Container(
                                                  height: 20.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 30.w, top: 20.h),
                                              child: Text("到期一次性还本贷款",
                                                  style: TextStyle(
                                                      fontSize: 32.sp,
                                                      color: Colors.black))),
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 30.w,
                                                  top: 10.h,
                                                  right: 20.w,
                                                  bottom: 20.h),
                                              child: Text(
                                                  "当前名下有正在偿还的贷款，请在下方金额和期数内填写该笔贷款未还金额和剩余期数，若没有贷款则不用填写。",
                                                  style: TextStyle(
                                                      fontSize: 22.sp,
                                                      color:
                                                          Colors.redAccent))),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15.w),
                                            ),
                                            margin: EdgeInsets.only(
                                                left: 30.w, right: 30.w),
                                            //height: 1100.h,
                                            child: Column(
                                              children: [
                                                buildCommonInput(
                                                    false,
                                                    "金额1",
                                                    "请输入金额1",
                                                    "元",
                                                    logic
                                                        .onetimeGiveMoneyFieldNode,
                                                    logic
                                                        .onetimeGiveMoneyController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                buildCommonInput(
                                                    false,
                                                    "期数1",
                                                    "请输入期数1",
                                                    "期",
                                                    logic
                                                        .onetimeGiveDateFieldNode,
                                                    logic
                                                        .onetimeGiveDateController, [
                                                  FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                                                  MyNumberTextInputFormatter(digit: 2)
                                                ]),
                                                Container(
                                                  height: 20.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 40.h,
                                                left: 40.w,
                                                right: 40.w,
                                                bottom: 80.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.w),
                                            ),
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xffDE2821),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          70.w),
                                                ),
                                                side: BorderSide(
                                                    width: 0,
                                                    color: Color(0xffcccccc)),
                                              ),
                                              child: Container(
                                                child: Text(
                                                  "提交测算",
                                                  style: TextStyle(
                                                      fontSize: 28.sp,
                                                      color: Colors.white),
                                                ),
                                                padding: EdgeInsets.only(
                                                    top: 25.h,
                                                    left: 55.w,
                                                    bottom: 25.h,
                                                    right: 55.w),
                                              ),
                                              onPressed: () {
                                                logic.getResult();
                                              },
                                            ),
                                          ),
                                        ]),
                                  ))),
                        ),
                      ),
                    ],
                  )))),
    );
  }

  Widget _buildRadio(bool isRequire,String title){
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 30.w, bottom: 5.h),
            child: Row(
              children: [
                isRequire
                    ? Text("*",
                    style: TextStyle(
                        fontSize: 30.sp, color: Colors.redAccent))
                    : Container(),
                Text(title,
                    style: TextStyle(fontSize: 30.sp, color: Colors.black)),
              ],
            )),

        Container(
          margin: EdgeInsets.only(
              left: 20.w, right: 20.w),
          child: RadioGroup<
              String>.builder(
            groupValue: logic
                .verticalGroupValue
                .value,
            onChanged: (value) {
              logic.verticalGroupValue
                  .value = value!;
            },
            items: logic.status,
            direction: Axis.horizontal,
            activeColor: Colors.redAccent,
            textStyle: TextStyle(fontSize: 30.sp, color: Colors.black),
            itemBuilder: (item) =>
                RadioButtonBuilder(
                  item,
                ),
          ),
        ),
      ],
    );
  }
  Widget buildCommonInput(bool isRequire, String title, String hintText,
      String endTitle, FocusNode focusNode, TextEditingController controller ,List<TextInputFormatter> formatter) {
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.w, bottom: 5.h),
              child: Row(
                children: [
                  isRequire
                      ? Text("*",
                          style: TextStyle(
                              fontSize: 30.sp, color: Colors.redAccent))
                      : Container(),
                  Text(title,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black)),
                ],
              )),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF7F9FB),
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 0.w),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.transparent,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters:formatter,
                          style: TextStyle(
                            fontSize: 35.sp,
                            color: Colors.black,
                          ),
                          focusNode: focusNode,
                          controller: controller,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: InputBorder.none,
                            hintText: hintText,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 30.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                  width: 70.w,
                  padding: EdgeInsets.only(left: 5.w, bottom: 0.h),
                  child: Row(
                    children: [
                      Text(endTitle,
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.black)),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
