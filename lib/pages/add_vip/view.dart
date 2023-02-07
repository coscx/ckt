import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_picker_null_safety/flutter_my_picker.dart';

import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/dy_behavior_null.dart';
import 'package:another_xlider/another_xlider.dart';
import 'logic.dart';

class AddVipPage extends StatelessWidget {
  final logic = Get.find<AddVipLogic>();
  final state = Get
      .find<AddVipLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light, // Status bar
            ),
          ),
        ),
        child: Obx(() {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                //去掉Appbar底部阴影
                leadingWidth: 150.w,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Container(
                    padding: EdgeInsets.only(left: 0.w, top: 0.w, bottom: 0),
                    child: Text("购买会员套餐",
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          fontSize: 45.sp,
                          decoration: TextDecoration.none,
                          color: Colors.black,
                        ))),
                actions: <Widget>[],
              ),
              body: WillPopScope(
                  onWillPop: () async {
                    return true;
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      // 触摸收起键盘
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Container(
                      color: Colors.white,
                      child: ScrollConfiguration(
                          behavior: DyBehaviorNull(),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: <Widget>[
                              buildStore("套餐选择:"),
                              buildVipPrice(),
                              buildVipMonth(),
                              buildVipCount(),
                              buildBirthday("支付时间"),
                              buildTag(),
                              buildSubmit()
                            ],
                          )),
                    ),
                  )));
        }));
  }

  Widget buildSubmit() {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, bottom: 0.h, left: 30.h, right: 30.h),
      child: Container(
        width: ScreenUtil().screenWidth * 0.7,
        height: 70.h,
        child: ElevatedButton(
          onPressed: () async {
            logic.submit();
            Navigator.of(Get.context!).pop();
          },
          child: Text("提交",
              style: TextStyle(color: Colors.white, fontSize: 40.sp)),
        ),
      ),
    );
  }

  Widget buildVipPrice() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.h, bottom: 0.h, left: 30.h, right: 0.h),
              child: Text("套餐价格:",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
            Container(
              width: ScreenUtil().screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Container(),
                  ),
                  Container(),
                  Expanded(
                    child: TextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      enabled: logic.isButton1Disabled,
                      controller: logic.vipPriceController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入套餐价格...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (str) {

                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(top: 0.h, bottom: 0.h, left: 0.h, right: 0.h),
              child: Text("元",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
          ],
        )
      ],
    );
  }

  Widget buildVipMonth() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.h, bottom: 0.h, left: 30.h, right: 0.h),
              child: Text("服务时长:",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
            Container(
              width: ScreenUtil().screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Container(),
                  ),
                  Container(),
                  Expanded(
                    child: TextField(
                      enabled: logic.isButton1Disabled,
                      controller: logic.vipMonthController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入服务时长...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (str) {

                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(top: 0.h, bottom: 0.h, left: 0.h, right: 0.h),
              child: Text("个月",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
          ],
        )
      ],
    );
  }

  Widget buildVipCount() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 0.h, bottom: 0.h, left: 30.h, right: 0.h),
              child: Text("排约次数:",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
            Container(
              width: ScreenUtil().screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Container(),
                  ),
                  Container(),
                  Expanded(
                    child: TextField(
                      enabled: logic.isButton1Disabled,
                      controller: logic.vipCountController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入排约次数...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: (str) {

                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding:
              EdgeInsets.only(top: 0.h, bottom: 0.h, left: 0.h, right: 0.h),
              child: Text("次",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp)),
            ),
          ],
        )
      ],
    );
  }

  Widget buildTag() {
    return Column(
      children: [
        Container(
          padding:
          EdgeInsets.only(top: 0.h, bottom: 0.h, left: 0.h, right: 0.h),
          child: Text("支付备注",
              style: TextStyle(color: Colors.black, fontSize: 30.sp)),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: 20.h, bottom: 0.h, left: 0.h, right: 0.h),
              width: ScreenUtil().screenWidth * 0.9,
              child: TextField(
                controller: logic.tagController,
                focusNode: logic.remarkFieldNode,
                style: const TextStyle(color: Colors.black),
                minLines: 7,
                maxLines: 7,
                cursorColor: Colors.green,
                cursorRadius: Radius.circular(3.w),
                cursorWidth: 5.w,
                showCursor: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.w),
                  hintText: "请输入...",
                  border: const OutlineInputBorder(),
                ),
                onChanged: (v) {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBirthday(String title) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 0.h, right: 0.w, bottom: 0.h),
      child: Column(
        children: [
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10.w, top: 0.h, right: 0.w, bottom: 0.h),
                  alignment: Alignment.centerLeft,
                  child: Text(title,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black)),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 30.w, top: 0.h, right: 0.w, bottom: 0.h),
                  child: ElevatedButton(
                    onPressed: () {
                      MyPicker.showPicker(
                          squeeze: 1.45,
                          magnification: 1.2,
                          offAxisFraction: 0.2,
                          context: Get.context!,
                          current: logic.startBirthDay.value,
                          mode: MyPickerMode.dateTime,
                          onConfirm: (v) {
                            //_change('yyyy-MM-dd HH:mm'),
                            print(v);

                            logic.startBirthDay.value = v;
                            logic.startBirthDayTitle.value =
                                v.toString().substring(0, 19);

                            logic.startBirthDayValue.value =
                                logic.startBirthDayTitle.value;
                          });
                    },
                    child: Text(
                      logic.startBirthDayTitle.value == ""
                          ? " "
                          : logic.startBirthDayTitle.value,
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: logic.startBirthDayValue.value == ""
                              ? Colors.black
                              : Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: logic.startBirthDayValue.value == ""
                            ? Colors.grey.withAlpha(33)
                            : Colors.blue,
                        shadowColor: Colors.black12,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.w, vertical: 10.h)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStore(String title) {
    int storeId = 0;

    return Container(
      padding: EdgeInsets.only(left: 0.w, top: 20.h, right: 0.w, bottom: 0.h),
      child: Column(
        children: [
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 30.w, top: 0.h, right: 0.w, bottom: 0.h),
                  alignment: Alignment.center,
                  child: Text(title,
                      style: TextStyle(fontSize: 30.sp, color: Colors.black)),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 30.w, top: 0.h, right: 0.w, bottom: 0.h),
                  child: ElevatedButton(
                    onPressed: () {
                      Picker(
                          squeeze: 1.45,
                          magnification: 1.2,
                          height: 400.h,
                          selecteds: [storeId],
                          itemExtent: 40,
                          selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                            background: Colors.transparent,
                          ),
                          cancelText: "取消",
                          confirmText: "确定",
                          selectedTextStyle: TextStyle(
                              fontSize: 40.sp, color: Colors.redAccent),
                          textStyle: TextStyle(
                              fontSize: 25.sp, color: Colors.black),
                          adapter: PickerDataAdapter<String>(
                              pickerData: logic.pickerStoreData),
                          changeToFirst: true,
                          hideHeader: false,
                          onConfirm: (Picker picker, List value) {
                            print(value.toString());
                            print(picker.adapter.text);

                            logic.storeName.value =
                            logic.pickerStoreData[value[0]];
                            logic.price =
                            logic.pickerStoreItem[value[0]].price!;
                            logic.month =
                            logic.pickerStoreItem[value[0]].month!;
                            logic.count =
                            logic.pickerStoreItem[value[0]].count!;
                            logic.tag =
                            logic.pickerStoreItem[value[0]].tag!;
                            logic.tagController.text = logic.tag;
                            logic.vipPriceController.text = logic.price;
                            logic.vipMonthController.text = logic.month;
                            logic.vipCountController.text = logic.count;
                            logic.isButton1Disabled = false;
                            logic.type =
                            logic.pickerStoreItem[value[0]].type!;
                            logic.vipId =
                            logic.pickerStoreItem[value[0]].id!;
                            if (logic.pickerStoreItem[value[0]].type ==
                                9999) {
                              logic.tagController.clear();
                              logic.vipPriceController.clear();
                              logic.vipMonthController.clear();
                              logic.vipCountController.clear();
                              logic.isButton1Disabled = true;
                            }

                          })
                          .showModal(
                          Get.context!); //_scaffoldKey.currentState);
                    },
                    child: Text(
                      logic.storeName.value == "" ? " " : logic.storeName.value,
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: logic.storeName.value == "选择会员套餐"
                              ? Colors.black
                              : Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: logic.storeName.value == "选择会员套餐"
                            ? Colors.grey.withAlpha(33)
                            : Colors.blue,
                        shadowColor: Colors.black12,
                        shape: const StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 35.w, vertical: 10.h)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRangerSlider(String title) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 0.h, right: 0.w, bottom: 0.h),
      child: Column(
        children: [
          Container(
            padding:
            EdgeInsets.only(left: 20.w, top: 0.h, right: 0.w, bottom: 0.h),
            alignment: Alignment.centerLeft,
            child: Text(title,
                style:
                TextStyle(fontSize: 26.sp, color: const Color(0xFF6a6a6a))),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 20.w, top: 0.h, right: 0.w, bottom: 0.h),
                child: Text(logic.minValue.toString() + "岁",
                    style: TextStyle(
                        fontSize: 26.sp, color: const Color(0xFF6a6a6a))),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 0.w, top: 0.h, right: 0.w, bottom: 0.h),
                width: ScreenUtil().screenWidth * 0.75,
                child: FlutterSlider(
                  values: [
                    logic.minValue.toDouble(),
                    logic.maxValue.toDouble()
                  ],
                  min: 18.0,
                  max: 80.0,
                  handlerAnimation: const FlutterSliderHandlerAnimation(
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.bounceIn,
                      duration: Duration(milliseconds: 500),
                      scale: 1.5
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    logic.minValue = lowerValue.round();
                    logic.maxValue = upperValue.round();
                  },

                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 0.w, top: 0.h, right: 0.w, bottom: 0.h),
                child: Text(logic.maxValue.toString() + "岁",
                    style: TextStyle(
                        fontSize: 26.sp, color: const Color(0xFF6a6a6a))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildChild(String name, bool selected) {
    return ChoiceChip(
      backgroundColor: Colors.grey.withAlpha(33),
      selectedColor: Theme
          .of(Get.context!)
          .primaryColor,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      labelPadding: EdgeInsets.only(left: 0.w, right: 0.w),
      selectedShadowColor: Colors.black,
      shadowColor: Colors.transparent,
      pressElevation: 5,
      elevation: 3,
      label: Text(
        name,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      ),
      selected: selected,
      onSelected: (bool value) {
        selected = value;
      },
    );
  }
}
