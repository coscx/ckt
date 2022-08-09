import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/utils/common.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/apis/common.dart';
import '../../../../common/entities/loan/saleman_detail.dart';
import '../../../../common/widgets/city_pickers/modal/result.dart';
import '../../../../common/widgets/city_pickers/src/city_picker.dart';
import '../../../oa/user_detail/widget/common_dialog.dart';

TextEditingController editController = TextEditingController();
FocusNode editFieldNode = FocusNode();
Map<String, dynamic> globalData = Map<String, dynamic>();

editBaseInfo(
  BuildContext context,
  SaleManDetailDataData info,
  Map<String, dynamic> data,
  void Function(SaleManDetailDataData tag, bool value,bool isEdit) callSetState,
) async {
  getSubmitData(info, data);
  if (data.containsKey("csName")) {
    info.csname = data['csName'];
  }
  if (data.containsKey("csAge")) {
    info.csage = data['csAge'];
  }
  if (data.containsKey("loanAmount")) {
    info.loanamount = int.tryParse(data['loanAmount'])!;
  }
  if (data.containsKey("loanCycle")) {
    info.loancycle = data['loanCycle'];
  }
  if (data.containsKey("loanRate")) {
    info.loanrate = data['loanRate'];
  }
  if (data.containsKey("district")) {
    info.district = data['district'];
  }
  if (data.containsKey("payType")) {
    info.paytype = data['payType'];
  }
  if (data.containsKey("houseArea")) {
    info.housearea = int.tryParse(data['houseArea'])!;
  }
  if (data.containsKey("houseAddress")) {
    info.houseaddress = data['houseAddress'];
  }

  callSetState(info, false,true);
}

submitBaseInfo(
  BuildContext context,
  SaleManDetailDataData info,
  void Function(SaleManDetailDataData detailData, bool value,bool isEdit) callSetState,
) async {
  var d = await CommonAPI.changeSaleBaseInfo(globalData);
  if (d.code == 200) {

    showToast(context, "修改成功", false);
    callSetState(info, true,false);
  } else {
    showToastRed(context, d.msg, false);
  }
}

Map<String, dynamic> getSubmitData(
    SaleManDetailDataData info, Map<String, dynamic> inData) {
  globalData.addAll(info.toJson());
  globalData.addAll(inData);
  return globalData;
}

String getBankName(int type) {
  String name = "-";
  if (type == 1) {
    name = "中国银行";
  }
  if (type == 2) {
    name = "农业银行";
  }
  return name;
}

Widget buildBase(
    BuildContext context,
    SaleManDetailDataData info,
    int canEdit,
    bool showControl,
    void Function(SaleManDetailDataData detailData, bool value,bool isEdit) callSetState,
    String name,bool isEdit) {
  return Container(
    child: Container(
      margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h,top: 0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //CustomsExpansionPanelList()
                //_item(context),
                Container(
                  width: ScreenUtil().screenWidth * 0.95,
                  // height: 300,
                  child: Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 0,
                      runSpacing: 0,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(context, "请输入姓名",
                              //     "", info.csname.toString(), "name", 1, info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }

                              await editDialog(context, "请输入姓名", "", () async {
                                editBaseInfo(context, info,
                                    {"csName": editController.text}, callSetState);
                              }, null, TextInputType.text);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "客户姓名",
                                info.csname.toString(),
                                true)),
                        GestureDetector(
                            onTap: () async {},
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "客户电话",
                                info.csphone.toString(),
                                false)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(context, "请输入年龄",
                              //     "", checkNull(info.csage)? "":info.csage.toString(), "name", 1, info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }

                              await editDialog(context, "请输入年龄", "岁", () {
                                editBaseInfo(context, info,
                                    {"csAge": editController.text}, callSetState);
                              }, NumberInputLimit(digit: 0, max: 99),
                                  TextInputType.number);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "客户年龄",
                                checkNull(info.csage)
                                    ? "-"
                                    : info.csage.toString() + "岁",
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(
                              //     context,
                              //     "请输入申请金额",
                              //     "",
                              //     checkNull(info.loanamount)
                              //         ? "-"
                              //         : info.loanamount.toString(),
                              //     "name",
                              //     1,
                              //     info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }

                              await editDialog(context, "请输入申请金额", "万", () {
                                editBaseInfo(
                                    context,
                                    info,
                                    {"loanAmount": editController.text},
                                    callSetState);
                              },
                                  NumberInputLimit(
                                    digit: 0,
                                  ),
                                  TextInputType.number);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "申请金额",
                                checkNull(info.loanamount)
                                    ? "-"
                                    : info.loanamount.toString() + "万",
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(
                              //     context,
                              //     "请输入申请期数",
                              //     "",
                              //     checkNull(info.loancycle)
                              //         ? "-"
                              //         : info.loancycle.toString(),
                              //     "name",
                              //     1,
                              //     info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }
                              await editDialog(context, "请输入申请期数", "期", () {
                                editBaseInfo(context, info,
                                    {"loanCycle": editController.text}, callSetState);
                              },
                                  NumberInputLimit(
                                    digit: 0,
                                  ),
                                  TextInputType.number);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "申请期数",
                                checkNull(info.loancycle)
                                    ? "-"
                                    : info.loancycle.toString() + "期",
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(
                              //     context,
                              //     "请输入申请费率",
                              //     "",
                              //     checkNull(info.loanrate)
                              //         ? "-"
                              //         : info.loanrate.toString(),
                              //     "name",
                              //     1,
                              //     info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }

                              await editDialog(context, "请输入申请费率", "%", () {
                                editBaseInfo(context, info,
                                    {"loanRate": editController.text}, callSetState);
                              },
                                  NumberInputLimit(
                                    digit: 0,
                                  ),
                                  TextInputType.number);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "申请费率",
                                checkNull(info.loanrate)
                                    ? "-"
                                    : info.loanrate.toString() + "%",
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(
                              //     context,
                              //     "请输入房屋面积",
                              //     "",
                              //     checkNull(info.housearea)
                              //         ? "-"
                              //         : info.housearea.toString(),
                              //     "name",
                              //     1,
                              //     info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }
                              await editDialog(context, "请输入房屋面积", "m²", () {
                                editBaseInfo(context, info,
                                    {"houseArea": editController.text}, callSetState);
                              },
                                  NumberInputLimit(
                                    digit: 0,
                                  ),
                                  TextInputType.number);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "房屋面积",
                                checkNull(info.housearea)
                                    ? "-"
                                    : info.housearea.toString() + "m²",
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              await showPickerArray(
                                  context,
                                  [
                                    ["全款", "贷款", "其他"]
                                  ],
                                  info.paytype == null
                                      ? [1]
                                      : [int.parse(info.paytype.toString())-1],
                                  "gender",
                                  info,
                                  "",
                                  true, (a, b) {
                                editBaseInfo(
                                    context, info, {"payType": a+1}, callSetState);
                              });
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.rice_bowl_outlined,
                                "房屋状态",
                                checkNull(info.paytype)
                                    ? "-"
                                    : int.parse(info.paytype.toString()) == 1
                                        ? "全款"
                                        : (int.parse(info.paytype.toString()) == 2
                                            ? "贷款"
                                            : "其他"),
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              Result? result = await CityPickers.showCityPicker(
                                  borderRadius: 20.w,
                                  context: context,
                                  locationCode: info.district == null
                                      ? "320508"
                                      : info.district.toString(),
                                  cancelWidget: Container(
                                    padding: EdgeInsets.only(top: 20.h, left: 20.w),
                                    child: Text(
                                      "取消",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40.sp,
                                      ),
                                    ),
                                  ),
                                  confirmWidget: Container(
                                    padding: EdgeInsets.only(top: 20.h, right: 20.w),
                                    child: Text(
                                      "确定",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 40.sp,
                                      ),
                                    ),
                                  ));
                              if (result != null) {
                                editBaseInfo(
                                    context,
                                    info,
                                    {
                                      "locationCode": [result.cityId, result.areaId],
                                      "city": result.cityId,
                                      "district": result.areaId
                                    },
                                    callSetState);
                              }
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.local_activity_outlined,
                                "房屋区域",
                                (checkNull(info.district)
                                    ? "-"
                                    : info.district.toString()),
                                true)),
                        GestureDetector(
                            onTap: () async {
                              if (canEdit == 0) {
                                showToastRed(context, "暂无权限修改", false);
                                return;
                              }
                              // var result = await showEditDialog(
                              //     context,
                              //     "请输入房屋面积",
                              //     "",
                              //     checkNull(info.houseaddress)
                              //         ? "-"
                              //         : info.houseaddress.toString(),
                              //     "name",
                              //     1,
                              //     info);
                              // if (result != null) {
                              //   callSetState("base", true);
                              // }
                              await editDialog(context, "请输入房屋地址", "", () {
                                editBaseInfo(
                                    context,
                                    info,
                                    {"houseAddress": editController.text},
                                    callSetState);
                              }, null, TextInputType.text);
                            },
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "房屋地址",
                                checkNull(info.houseaddress)
                                    ? "-"
                                    : info.houseaddress.toString(),
                                true)),
                        GestureDetector(
                            onTap: () async {},
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "来源渠道",
                                checkNull(info.channel!.cnname)
                                    ? "-"
                                    : info.channel!.cnname.toString(),
                                false)),
                        GestureDetector(
                            onTap: () async {},
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "当前员工",
                                checkNull(info.staff) ? "-" : info.staff,
                                false)),
                        GestureDetector(
                            onTap: () async {},
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "申请银行",
                                checkNull(info.realamount)
                                    ? "-"
                                    : (info.bankid == 0
                                        ? "-"
                                        : getBankName(info.bankid) + ""),
                                false)),
                        GestureDetector(
                            onTap: () async {},
                            child: _item_detail(
                                context,
                                Colors.black,
                                Icons.drive_file_rename_outline,
                                "实际贷款金额",
                                checkNull(info.realamount)
                                    ? "-"
                                    : (info.realamount == 0
                                        ? "-"
                                        : info.realamount.toString() + "万"),
                                false)),
                        isEdit
                            ? Container(
                                width: ScreenUtil().screenWidth,
                                height: 90.h,
                                margin: EdgeInsets.only(
                                    top: 30.h, left: 50.w, right: 40.w),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(StadiumBorder(
                                        side: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.transparent,
                                    ))), //圆
                                    shadowColor:
                                        MaterialStateProperty.all(Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green.withOpacity(0.9)), //背景颜色
                                    foregroundColor: MaterialStateProperty.all(
                                        Colors.white), //字体颜色
                                  ),
                                  onPressed: () {
                                    submitBaseInfo(context, info, callSetState);
                                  },
                                  child: Text("保存",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )
                            : Container(height: 0,),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _item_detail(BuildContext context, Color color, IconData icon,
    String name, String answer, bool show) {
  bool isDark = false;

  return Container(
    padding: EdgeInsets.only(top: 10.h, bottom: 0),
    width: double.infinity,
    //height: 80.h,
    child: Material(
        color: Colors.transparent,
        child: Container(
          margin:
              EdgeInsets.only(left: 10.w, right: 20.w, top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                // Icon(
                //   icon,
                //   size: 32.sp,
                //   color: Colors.black54,
                // ),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  child: Text(
                    name + " :",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(50.w),
                ),
                Visibility(
                    visible: true,
                    child: Container(
                      width: ScreenUtil().screenWidth * 0.50,
                      child: Text(
                        answer,
                        maxLines: 20,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ]),
              //Visibility是控制子组件隐藏/可见的组件
              Visibility(
                visible: show,
                child: Row(children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: ScreenUtil().setWidth(10.w),
                      ),
                      Visibility(
                          visible: false,
                          child: Text(
                            "2021-01-12 15:35:30",
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.grey),
                          )),
                      const Visibility(
                          visible: false,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("rightImageUri"),
                          ))
                    ]),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 30.sp,
                    color: Colors.black54,
                  )
                ]),
              )
            ],
          ),
        )),
  );
}

showEditDialog(BuildContext context, String title, String hintText, String text,
    String type, int maxLine, SaleManDetailDataData info) {
  TextEditingController _controller =
      TextEditingController.fromValue(TextEditingValue(
    text: text, //判断keyword是否为空
  ));
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Column(
            children: <Widget>[
              //Text(text),
              TextField(
                minLines: maxLine,
                maxLines: maxLine,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: hintText,

                  //filled: true,
                  //fillColor: Colors.white
                ),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('取消'),
            ),
            CupertinoDialogAction(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      });
}

Future<String> showPickerArray(
    BuildContext context,
    List<List<String>> pickerData,
    List<int> select,
    String type,
    SaleManDetailDataData info,
    String title,
    bool isIndex,
    Function(int a, String b) ff) async {
  String d = "";
  var result = await Picker(
      itemExtent: 40,
      magnification: 1.2,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      adapter: PickerDataAdapter<String>(pickerdata: pickerData, isArray: true),
      hideHeader: true,
      title: Text("请选择" + title),
      cancelText: "取消",
      confirmText: "确定",
      cancelTextStyle: TextStyle(fontSize: 36.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 36.sp, color: Colors.blue),
      selecteds: select,
      // columnPadding: EdgeInsets.only(top: 50.h,bottom: 50.h,left: 50.w,right: 50.w),
      selectedTextStyle: TextStyle(
        fontSize: 48.sp,
        color: Colors.redAccent,
      ),
      textStyle: TextStyle(
        fontSize: 28.sp,
        color: Colors.black,
      ),
      onConfirm: (Picker picker, List value) async {
        //debugPrint(value.toString());
        //debugPrint(picker.getSelectedValues().toString());
        d = picker.getSelectedValues().toString();
        int values;
        if (isIndex) {
          values = value.first;
        } else {
          values = int.parse(picker.getSelectedValues().first);
        }
        ff(value.first, picker.getSelectedValues().first);
      }).showDialog(context);
  if (result != null) {
    return d;
  }
  return "";
}

editDialog(BuildContext context, String title, String suffix, Function callBack,
    TextInputFormatter? inputFormatter, TextInputType textInputType) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (c) {
        return StatefulBuilder(builder: (context, state) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().screenWidth * 0.75,
                    height: 450.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40.w)),
                    ),
                    child: Stack(
                      //alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: 30.h,
                          right: 30.h,
                          child: GestureDetector(
                            onTap: () {
                              editController.text = "";
                              editFieldNode.unfocus();
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              'assets/images/btn_close_black.png',
                              width: 40.w,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 140.w, right: 140.w, top: 30.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(title,
                                      style: TextStyle(
                                          fontSize: 38.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 140.w, right: 140.w, top: 20.h),
                              height: 120.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      inputFormatters: inputFormatter == null
                                          ? []
                                          : [inputFormatter],
                                      keyboardType: textInputType,
                                      autofocus: false,
                                      controller: editController,
                                      focusNode: editFieldNode,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 50.sp),
                                      minLines: 1,
                                      maxLines: 1,
                                      cursorColor: Colors.black12,
                                      cursorWidth: 4.w,
                                      cursorHeight: 60.h,
                                      showCursor: true,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        hintText: "",
                                        hintStyle: TextStyle(
                                            color: Color(0xffeeeeee),
                                            fontSize: 40.sp),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffeeeeee)),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffeeeeee)),
                                        ),
                                      ),
                                      onChanged: (v) {},
                                    ),
                                  ),
                                  Text(suffix,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 36.sp,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 90.h,
                              margin: EdgeInsets.only(
                                  top: 30.h, left: 50.w, right: 40.w),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all(StadiumBorder(
                                          side: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.transparent,
                                  ))), //圆
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.green.withOpacity(0.9)), //背景颜色
                                  foregroundColor: MaterialStateProperty.all(
                                      Colors.white), //字体颜色
                                ),
                                onPressed: () {
                                  callBack();
                                  editController.text = "";
                                  editFieldNode.unfocus();
                                  Navigator.pop(context);
                                },
                                child: Text("保存",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36.sp,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                editController.text = "";
                                editFieldNode.unfocus();
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 20.h,
                                ),
                                child: Text("取消",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 31.sp,
                                        fontWeight: FontWeight.w400)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

/*
 * @Author: zhudaihao
 * @Date: 2022/2/25
 * @Describe: 限制输入数字和小数后位数
 */
class NumberInputLimit extends TextInputFormatter {
  ///输入字符的范围
  String inputScope;

  ///允许的小数位数
  final int? digit;

  ///允许的最大值
  final double? max;

  ///是否支持 false不支持负数(默认不支持)
  final bool isNegative;

  NumberInputLimit({
    this.inputScope = '-.0123456789',
    this.digit,
    this.max,
    this.isNegative = false,
  });

  ///获取value小数点后有几位
  static int getDecimalAfterLength(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return 0;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    //上次文本
    String oldContent = oldValue.text;
    //最新文本
    String newContent = newValue.text;
    //上次文本长度
    int oldLength = oldContent.length;
    //最新文本长度
    int newLength = newContent.length;
    //上次文本光标位置
    int oldBaseOffset = oldValue.selection.baseOffset;
    //最新文本光标位置
    int newBaseOffset = newValue.selection.baseOffset;
    //光标位置
    int offset = newBaseOffset;

    if (newLength > oldLength) {
      //输入的字符
      String inputContent = newContent.substring(oldBaseOffset, newBaseOffset);
      if (!isNegative) {
        inputScope = inputScope.replaceAll("-", "");
      }
      if (inputScope.contains(inputContent)) {
        if (oldLength > 0) {
          if ((max != null && double.parse(newContent) > max!) ||
              (digit != null && getDecimalAfterLength(newContent) > digit!)) {
            newContent = oldContent;
            offset = oldBaseOffset;
          } else if (oldContent.substring(0, 1) == "-") {
            //上次文本首字符是-
            if ((oldContent.contains(".") && inputContent == ".") ||
                inputContent == "-" ||
                (oldContent.contains(".") &&
                    newLength > 2 &&
                    newContent.substring(2, 3) != "." &&
                    newContent.substring(1, 2) == "0") ||
                (newLength > 2 && newContent.substring(0, 3) == "-00") ||
                (newLength > 2 &&
                    !newContent.contains(".") &&
                    newContent.substring(1, 2) == "0") ||
                (oldContent.substring(0, 1) == "-" &&
                    newContent.substring(0, 1) != "-")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          } else if (oldContent.substring(0, 1) == "0") {
            //上次文本首字符是0
            if (newLength > 1 && newContent.substring(0, 2) == "00" ||
                (newContent.contains("-") &&
                    newContent.substring(0, 1) != "-") ||
                (oldContent.contains(".") && inputContent == ".") ||
                (newContent.substring(0, 1) == "0" &&
                    newLength > 1 &&
                    newContent.substring(1, 2) != ".")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          } else if (newContent.contains(".")) {
            //上次文本首字符是.
            if ((oldLength > 1 &&
                    oldContent.substring(0, 2) == "0." &&
                    inputContent == ".") ||
                (newContent.substring(0, 1) != "-" &&
                    newContent.contains("-")) ||
                (oldContent.contains(".") && inputContent == ".") ||
                (oldContent.contains(".") &&
                    oldContent.substring(0, 1) != "." &&
                    newContent.substring(0, 1) == "0")) {
              newContent = oldContent;
              offset = oldBaseOffset;
            }
          }
        }
      } else {
        //输入限制范围外字符
        newContent = oldContent;
        offset = oldBaseOffset;
      }
    }

    return TextEditingValue(
      text: newContent,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
