import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/entities/loan/saleman_detail.dart';
import '../../../oa/user_detail/widget/common_dialog.dart';
import '../../../oa/user_detail/widget/widget_node_panel.dart';

Widget buildBase(BuildContext context, SaleManDetailDataData info, int canEdit, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {


  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
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
                          var result = await showEditDialog(context, "请输入姓名",
                              "", info.csname.toString(), "name", 1, info);
                          if (result != null) {
                            callSetState("base", true);
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.drive_file_rename_outline,
                            "姓名",
                            info.csname.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [
                                ["全款", "贷款", "其他"]
                              ],
                              info.paytype == null ? [1] : [int.parse(info.paytype.toString())],
                              "gender",
                              info,
                              "",
                              true);
                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.rice_bowl_outlined,
                            "服务状态",
                            info.paytype==null? "" : int.parse(info.paytype.toString()) == 0 ? "全款" :(int.parse(info.paytype.toString()) == 1? "贷款":"其他"),
                            true)),

                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          Result? result = await CityPickers.showCityPicker(
                              context: context,
                              locationCode: info.district==null?  "320508":info.city.toString(),
                              cancelWidget: Text(
                                "取消",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.sp,
                                ),
                              ),
                              confirmWidget: Text(
                                "确定",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 40.sp,
                                ),
                              ));
                          debugPrint(result.toString());
                          if (result != null) {

                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.local_activity_outlined,
                            "籍贯",
                            (info.houseaddress == ""
                                ? "-"
                                : info.houseaddress.toString()),
                            true)),

                  ]),
            ),
      ],
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
          margin: EdgeInsets.only(
              left: 10.w, right: 20.w, top: 10.h, bottom: 10.h),
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
                    name,
                    style: TextStyle(fontSize: 32.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(50.w),
                ),
                Visibility(
                    visible: true,
                    child: Container(
                      width: ScreenUtil().screenWidth * 0.60,
                      child: Text(
                        answer,
                        maxLines: 20,
                        style: TextStyle(fontSize: 32.sp, color: color),
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
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.grey),
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
Future<bool> showPickerArray(
    BuildContext context,
    List<List<String>> pickerData,
    List<int> select,
    String type,
    SaleManDetailDataData info,
    String title,
    bool isIndex) async {
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
      cancelTextStyle: TextStyle(fontSize: 40.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 40.sp, color: Colors.blue),
      selecteds: select,
      // columnPadding: EdgeInsets.only(top: 50.h,bottom: 50.h,left: 50.w,right: 50.w),
      selectedTextStyle: TextStyle(
        fontSize: 34.sp,
        color: Colors.redAccent,
      ),
      textStyle: TextStyle(
        fontSize: 28.sp,
        color: Colors.black,
      ),
      onConfirm: (Picker picker, List value) async {
        debugPrint(value.toString());
        debugPrint(picker.getSelectedValues().toString());
        int values;
        if (isIndex) {
          values = value.first;
        } else {
          values = int.parse(picker.getSelectedValues().first);
        }

      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}