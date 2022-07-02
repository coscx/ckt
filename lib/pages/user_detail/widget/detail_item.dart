import 'dart:async';
import 'dart:io';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/detail/user_detail.dart';
import 'package:flutter_ckt/pages/user_detail/logic.dart';
import 'package:flutter_ckt/pages/user_detail/widget/tag.dart';
import 'package:flutter_ckt/pages/user_detail/widget/widget_node_panel.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../common/utils/common.dart';
import '../../../common/widgets/chat_picture_preview.dart';
import '../../../common/widgets/circle_text.dart';
import '../../../common/widgets/delete_category_dialog.dart';
import '../../../common/widgets/extend_image.dart';
import '../../../common/widgets/im_util.dart';
import '../../../common/widgets/imageview/image_preview_page.dart';
import '../../../common/widgets/imageview/image_preview_view.dart';
import 'common_dialog.dart';

Widget buildBase(BuildContext context, Info info, int canEdit, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  String level = getLevel(info.status);

  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "基础资料",
            code: "",
            show: Container(
              width: ScreenUtil().screenWidth * 0.98,
              // height: 300,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 0,
                  runSpacing: 0,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.format_list_numbered,
                            "编号",
                            info.code.toString(),
                            false)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(context, Colors.black, Icons.store,
                            "门店", info.appStoreName.toString(), false)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(context, Colors.black, Icons.store,
                            "状态", level, false)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(context, "请输入姓名",
                              "", info.name.toString(), "name", 1, info);
                          if (result != null) {
                            callSetState("base", true);
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.drive_file_rename_outline,
                            "姓名",
                            info.name.toString(),
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
                                ["未知", "男生", "女生"]
                              ],
                              info.gender == 0 ? [1] : [info.gender],
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
                            "性别",
                            info.gender == 1 ? "男生" : "女生",
                            true)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.contact_page_outlined,
                            "年龄",
                            info.age == 0 ? "-" : info.age.toString() + "岁",
                            false)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerDateTime(
                              context,
                              info.birthday == ""
                                  ? "-"
                                  : info.birthday.toString(),
                              "birthday",
                              info);

                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.broken_image_outlined,
                            "生日",
                            info.birthday == ""
                                ? "-"
                                : info.birthday.substring(0, 10) +
                                    "(" +
                                    info.chineseZodiac +
                                    "-" +
                                    info.zodiac +
                                    ")",
                            true)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.red,
                            Icons.settings_backup_restore_outlined,
                            "八字",
                            info.bazi.toString(),
                            false)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.orange,
                            Icons.whatshot,
                            "五行",
                            info.wuxing.toString(),
                            false)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          Result? result = await CityPickers.showCityPicker(
                              context: context,
                              locationCode: info.npAreaCode == ""
                                  ? (info.npCityCode == ""
                                      ? "320500"
                                      : info.npCityCode)
                                  : info.npAreaCode,
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
                            final logic = Get.find<UserDetailLogic>();
                            logic.editCustomerAddress(info.uuid, 1, result);

                            // var results = await IssuesApi.editCustomerAddress(
                            //     info['uuid'], 1, result);
                            // if (results['code'] == 200) {
                            //   // BlocProvider.of<DetailBloc>(context)
                            //   //     .add(EditDetailEventAddress(result, 1));
                            //   showToast(context, "编辑成功", false);
                            // } else {
                            //   showToast(context, results['message'], false);
                            // }
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.local_activity_outlined,
                            "籍贯",
                            (info.nativePlace == ""
                                ? "-"
                                : info.nativePlace.toString()),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          Result? result = await CityPickers.showCityPicker(
                              context: context,
                              locationCode: info.lpAreaCode == ""
                                  ? (info.lpAreaCode == ""
                                      ? "320500"
                                      : info.lpCityCode)
                                  : info.lpCityCode,
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
                            final logic = Get.find<UserDetailLogic>();
                            logic.editCustomerAddress(info.uuid, 2, result);
                            // var results = await IssuesApi.editCustomerAddress(
                            //     info['uuid'], 2, result);
                            // if (results['code'] == 200) {
                            //   // BlocProvider.of<DetailBloc>(context)
                            //   //     .add(EditDetailEventAddress(result, 2));
                            //   showToast(context, "编辑成功", false);
                            // } else {
                            //   showToast(context, results['message'], false);
                            // }
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.house_outlined,
                            "居住",
                            (info.locationPlace == ""
                                ? "-"
                                : info.locationPlace.toString()),
                            true)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.point_of_sale,
                            "销售",
                            info.saleUser.toString(),
                            false)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [nationLevel],
                              info.nation == 0 ? [1] : [info.nation],
                              "nation",
                              info,
                              "",
                              true);
                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.gamepad_outlined,
                            "民族",
                            info.nation == 0
                                ? "-"
                                : getNationLevel((info.nation)),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [getHeightList()],
                              info.height == 0
                                  ? [70]
                                  : [
                                      getIndexOfList(getHeightList(),
                                          info.height.toString())
                                    ],
                              "height",
                              info,
                              "身高(cm)",
                              false);
                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.height,
                            "身高",
                            info.height == 0
                                ? "-"
                                : info.height.toString() + "cm",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [getWeightList()],
                              info.weight == 0
                                  ? [35]
                                  : [
                                      getIndexOfList(getWeightList(),
                                          info.weight.toString())
                                    ],
                              "weight",
                              info,
                              "体重(kg)",
                              false);
                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.line_weight,
                            "体重",
                            info.weight == 0
                                ? "-"
                                : info.weight.toString() + "kg",
                            true)),
                    GestureDetector(
                        onTap: () {},
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.design_services_outlined,
                            "服务",
                            info.serveUser == ""
                                ? "-"
                                : info.serveUser.toString(),
                            false)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入兴趣",
                              "",
                              (info.interest == ""
                                  ? ""
                                  : info.interest.toString()),
                              "interest",
                              5,
                              info);
                          if (result != null) {
                            callSetState("base", true);
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.integration_instructions_outlined,
                            "兴趣",
                            info.interest == ""
                                ? "-"
                                : info.interest.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [floodLevel],
                              info.bloodType == 0 ? [3] : [info.bloodType],
                              "blood_type",
                              info,
                              "",
                              true);
                          callSetState("base", true);
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.blur_on_outlined,
                            "血型",
                            info.bloodType == 0
                                ? "-"
                                : getFloodLevel(info.bloodType),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入择偶要求",
                              "",
                              (info.demands == ""
                                  ? ""
                                  : info.demands.toString()),
                              "demands",
                              5,
                              info);
                          if (result != null) {
                            callSetState("base", true);
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.developer_mode,
                            "择偶",
                            (info.demands == ""
                                ? "-"
                                : info.demands.toString()),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入备注",
                              "",
                              (info.remark == "" ? "" : info.remark.toString()),
                              "remark",
                              5,
                              info);
                          if (result != null) {
                            callSetState("base", true);
                          }
                        },
                        child: _item_detail(
                            context,
                            Colors.black,
                            Icons.bookmarks_outlined,
                            "备注",
                            (info.remark == "" ? "-" : info.remark.toString()),
                            true)),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildEdu(BuildContext context, Info info, int canEdit, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "学历工作及资产",
            code: "",
            show: Container(
              width: ScreenUtil().screenWidth * 0.98,
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
                          var result = await showPickerArray(
                              context,
                              [EduLevel],
                              info.education == 0 ? [1] : [info.education],
                              "education",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.menu_book,
                            "个人学历",
                            info.education == 0
                                ? "-"
                                : getEduLevel(info.education),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入毕业院校",
                              "",
                              (info.school == "" ? "" : info.school.toString()),
                              "school",
                              1,
                              info);
                          if (result != null) {
                            callSetState("education", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.school,
                            "毕业院校",
                            info.school.toString() == ""
                                ? "-"
                                : info.school.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入所学专业",
                              "",
                              (info.major == "" ? "" : info.major.toString()),
                              "major",
                              1,
                              info);
                          if (result != null) {
                            callSetState("education", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.tab,
                            "所学专业",
                            info.major == "" ? "-" : info.major.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [companyTypeLevel],
                              info.work == 0 ? [1] : [info.work],
                              "work",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.reduce_capacity,
                            "企业类型",
                            info.work == 0
                                ? "-"
                                : getCompanyLevel(info.work) + "",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [WorkTypeLevel],
                              info.workJob == 0 ? [1] : [info.workJob],
                              "work_job",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.location_city,
                            "所属行业",
                            info.workJob == ""
                                ? "-"
                                : getWorkType(info.workJob),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入职位描述",
                              "",
                              (info.workIndustry == ""
                                  ? ""
                                  : info.workIndustry.toString()),
                              "work_industry",
                              5,
                              info);
                          if (result != null) {
                            callSetState("education", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.description_outlined,
                            "职位描述",
                            info.workIndustry == ""
                                ? "-"
                                : info.workIndustry.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [WorkOverTimeLevel],
                              info.workOvertime == 0
                                  ? [1]
                                  : [info.workOvertime],
                              "work_overtime",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.more_outlined,
                            "加班情况",
                            info.workOvertime == 0
                                ? "-"
                                : getWorkOverTime(info.workOvertime),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          // showPickerArray(context,[IncomeLevel],info['income']==0?[1]:[info['income']],"income",info,"",true);
                          var result = await showEditDialog(context, "请输入收入",
                              "", info.income.toString(), "income", 1, info);
                          if (result != null) {
                            callSetState("education", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.monetization_on_outlined,
                            "收入情况",
                            info.income == 0
                                ? "-"
                                : info.income.toString() + "万",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [hasHouseLevel],
                              info.hasHouse == 0 ? [1] : [info.hasHouse],
                              "has_house",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.house_outlined,
                            "是否有房",
                            info.hasHouse == 0
                                ? "-"
                                : getHasHouse(info.hasHouse),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [houseFutureLevel],
                              info.loanRecord == 0 ? [1] : [info.loanRecord],
                              "loan_record",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.copyright_rounded,
                            "房贷情况",
                            info.loanRecord == 0
                                ? "-"
                                : getHouseFuture(info.loanRecord),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [hasCarLevel],
                              info.hasCar == 0 ? [1] : [info.hasCar],
                              "has_car",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.car_rental,
                            "是否有车",
                            info.hasCar == 0 ? "-" : getHasCar(info.hasCar),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [carLevelLevel],
                              info.carType == 0 ? [1] : [info.carType],
                              "car_type",
                              info,
                              "",
                              true);
                          callSetState("education", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.wb_auto_outlined,
                            "车辆档次",
                            info.carType == 0 ? "-" : getCarLevel(info.carType),
                            true)),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildMarriage(
    BuildContext context,
    Info info,
    int canEdit,
    bool showControl,
    void Function(String tag, bool value) callSetState,
    String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "婚姻及父母家庭",
            code: "",
            show: Container(
              width: ScreenUtil().screenWidth * 0.98,
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
                          var result = await showPickerArray(
                              context,
                              [marriageLevel],
                              info.marriage == 0 ? [1] : [info.marriage],
                              "marriage",
                              info,
                              "",
                              true);
                          callSetState("marriage", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.wc,
                            "婚姻状态",
                            info.marriage == 0
                                ? "-"
                                : getMarriageLevel(info.marriage),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [childLevel],
                              info.hasChild == 0 ? [1] : [info.hasChild],
                              "has_child",
                              info,
                              "",
                              true);
                          callSetState("marriage", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.child_care,
                            "子女信息",
                            info.hasChild == 0
                                ? "-"
                                : getChildLevel(info.hasChild),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入子女备注",
                              "",
                              info.childRemark == null
                                  ? ""
                                  : (info.childRemark == ""
                                      ? ""
                                      : info.childRemark.toString()),
                              "child_remark",
                              5,
                              info);
                          if (result != null) {
                            callSetState("marriage", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.mark_chat_read_outlined,
                            "子女备注",
                            info.childRemark == ""
                                ? "-"
                                : info.childRemark.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [onlyChildLevel],
                              info.onlyChild == 0 ? [1] : [info.onlyChild],
                              "only_child",
                              info,
                              "",
                              true);
                          callSetState("marriage", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.looks_one_outlined,
                            "独生子女",
                            info.onlyChild == 0
                                ? "-"
                                : getOnlyChildLevel(info.onlyChild) + "",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [parentLevel],
                              info.parents == 0 ? [1] : [info.parents],
                              "parents",
                              info,
                              "",
                              true);
                          callSetState("marriage", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.watch_later_outlined,
                            "父母状况",
                            info.parents == 0
                                ? "-"
                                : getParentLevel(info.parents),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入父亲职业",
                              "",
                              info.fatherWork == null
                                  ? ""
                                  : (info.fatherWork == ""
                                      ? ""
                                      : info.fatherWork.toString()),
                              "father_work",
                              1,
                              info);
                          if (result != null) {
                            callSetState("marriage", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.attribution_rounded,
                            "父亲职业",
                            info.fatherWork == ""
                                ? "-"
                                : info.fatherWork.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入母亲职业",
                              "",
                              info.motherWork == null
                                  ? ""
                                  : (info.motherWork == ""
                                      ? ""
                                      : info.motherWork.toString()),
                              "mother_work",
                              1,
                              info);
                          if (result != null) {
                            callSetState("marriage", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.sports_motorsports_outlined,
                            "母亲职业",
                            info.motherWork == ""
                                ? "-"
                                : info.motherWork.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialog(
                              context,
                              "请输入父母收入",
                              "",
                              info.parentsIncome == null
                                  ? ""
                                  : (info.parentsIncome == ""
                                      ? ""
                                      : info.parentsIncome.toString()),
                              "parents_income",
                              1,
                              info);
                          if (result != null) {
                            callSetState("marriage", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.monetization_on,
                            "父母收入",
                            info.parentsIncome == ""
                                ? "-"
                                : info.parentsIncome.toString(),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [parentProtectLevel],
                              info.parentsInsurance == 0
                                  ? [1]
                                  : [info.parentsInsurance],
                              "parents_insurance",
                              info,
                              "",
                              true);
                          callSetState("marriage", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.redAccent,
                            Icons.nine_k,
                            "父母社保",
                            info.parentsInsurance == 0
                                ? "-"
                                : getParentProtectLevel(info.parentsInsurance),
                            true)),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildSimilar(
    BuildContext context,
    Info info,
    int canEdit,
    bool showControl,
    void Function(String tag, bool value) callSetState,
    String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "用户画像相关",
            code: "",
            show: Container(
              width: ScreenUtil().screenWidth * 0.98,
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
                          var result = await showPickerArray(
                              context,
                              [faithLevel],
                              info.faith == 0 ? [0] : [info.faith],
                              "faith",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.fastfood,
                            "宗教信仰",
                            info.faith == 0 ? "-" : getFaithLevel(info.faith),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [smokeLevel],
                              info.smoke == 0 ? [0] : [info.smoke],
                              "smoke",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.smoking_rooms,
                            "是否吸烟",
                            info.smoke == 0 ? "-" : getSmokeLevel(info.smoke),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [drinkLevel],
                              info.drinkwine == 0 ? [0] : [info.drinkwine],
                              "drinkwine",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.wine_bar,
                            "是否喝酒",
                            info.drinkwine == 0
                                ? "-"
                                : getDrinkLevel(info.drinkwine),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [lifeLevel],
                              info.liveRest == 0 ? [0] : [info.liveRest],
                              "live_rest",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.nightlife,
                            "生活作息",
                            info.liveRest == 0
                                ? "-"
                                : getLifeLevel(info.liveRest) + "",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [creatLevel],
                              info.wantChild == 0 ? [0] : [info.wantChild],
                              "want_child",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.child_friendly_outlined,
                            "生育欲望",
                            info.wantChild == 0
                                ? "-"
                                : getCreatLevel(info.wantChild),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArray(
                              context,
                              [marriageDateLevel],
                              info.marryTime == 0 ? [0] : [info.marryTime],
                              "marry_time",
                              info,
                              "",
                              true);
                          callSetState("similar", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.margin,
                            "结婚预期",
                            info.marryTime == 0
                                ? "-"
                                : getMarriageDateLevel(info.marryTime),
                            true)),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildUserSelect(
    BuildContext context,
    Demand demand,
    int canEdit,
    bool showControl,
    String uuid,
    void Function(String tag, bool value) callSetState,
    String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "择偶要求",
            code: "",
            show: Container(
              width: ScreenUtil().screenWidth * 0.98,
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
                          // showPickerArray(
                          //     context,
                          //     [faithLevel],
                          //     info['wish_ages'] == "" ? [0] : [info['wish_ages']],
                          //     "wish_ages",
                          //     info,
                          //     "",
                          //     true);
                          var result = await showPickerDemandAge(
                              context, demand.wishAges, uuid, canEdit);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.contact_page_outlined,
                            "年龄",
                            demand.wishAges == ""
                                ? "-"
                                : getAgeDemand(demand.wishAges),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          // showPickerArray(
                          //     context,
                          //     [smokeLevel],
                          //     info['wish_weights'] == 0 ? [0] : [info['wish_weights']],
                          //     "wish_weights",
                          //     info,
                          //     "",
                          //     true);
                          var result = await showPickerDemandWeight(
                              context, demand.wishWeights, uuid, canEdit);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.line_weight,
                            "体重",
                            demand.wishWeights == ""
                                ? "-"
                                : getWeightDemand(demand.wishWeights),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = showPickerArrayDemand(
                              context,
                              [EduLevel],
                              demand.wishEducation == ""
                                  ? [0]
                                  : [int.parse(demand.wishEducation)],
                              "wish_education",
                              demand,
                              "",
                              true,
                              uuid);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.menu_book,
                            "学历",
                            demand.wishEducation == ""
                                ? "-"
                                : getEduLevel(int.parse(demand.wishEducation)),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          // showPickerArray(
                          //     context,
                          //     [lifeLevel],
                          //     info['wish_heights'] == 0
                          //         ? [0]
                          //         : [info['wish_heights']],
                          //     "wish_heights",
                          //     info,
                          //     "",
                          //     true);
                          var result = await showPickerDemandHeight(
                              context, demand.wishHeights, uuid, canEdit);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.height,
                            "身高",
                            demand.wishHeights == ""
                                ? "-"
                                : getHeightDemand(demand.wishHeights) + "",
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          Result? result = await CityPickers.showCityPicker(
                              context: context,
                              locationCode: demand.wishLpAreaCode == ""
                                  ? (demand.wishLpCityCode == ""
                                      ? "320500"
                                      : demand.wishLpCityCode)
                                  : demand.wishLpAreaCode,
                              cancelWidget: Text(
                                "取消",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 40.sp),
                              ),
                              confirmWidget: Text(
                                "确定",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 40.sp),
                              ));
                          debugPrint(result.toString());
                          if (result != null) {
                            final logic = Get.find<UserDetailLogic>();
                            logic.editCustomerDemandAddress(uuid, result);
                            // var results =
                            //     await IssuesApi.editCustomerDemandAddress(
                            //         uuid, 2, result);
                            // if (results['code'] == 200) {
                            //   BlocProvider.of<DetailBloc>(context)
                            //       .add(EditDetailEventDemandAddress(result, 2));
                            //   showToast(context, "编辑成功", false);
                            // } else {
                            //   showToast(context, results['message'], false);
                            // }
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.local_activity_outlined,
                            "现居地",
                            demand.wishLpCityName == ""
                                ? "-"
                                : (demand.wishLpProvinceName +
                                    demand.wishLpCityName +
                                    demand.wishLpAreaName),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showPickerArrayDemand(
                              context,
                              [marriageLevel],
                              demand.wishMarriage == ""
                                  ? [0]
                                  : [int.parse(demand.wishMarriage)],
                              "wish_marriage",
                              demand,
                              "",
                              true,
                              uuid);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.wc,
                            "婚姻状况",
                            demand.wishMarriage == ""
                                ? "-"
                                : getMarriageLevel(
                                    int.parse(demand.wishMarriage)),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var income = 0;
                          try {
                            income = int.parse(demand.wishIncome);
                          } catch (e) {}

                          var result = await showPickerArrayDemand(
                              context,
                              [IncomeLevel],
                              demand.wishIncome == "" ? [0] : [income],
                              "wish_income",
                              demand,
                              "",
                              true,
                              uuid);
                          callSetState("select", true);
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.monetization_on_outlined,
                            "年收入",
                            demand.wishIncome == ""
                                ? "-"
                                : getIncome((demand.wishIncome)),
                            true)),
                    GestureDetector(
                        onTap: () async {
                          if (canEdit == 0) {
                            showToastRed(context, "暂无权限修改", false);
                            return;
                          }
                          var result = await showEditDialogDemand(
                              context,
                              "请输入备注",
                              "",
                              demand.description == null
                                  ? ""
                                  : (demand.description == ""
                                      ? ""
                                      : demand.description.toString()),
                              "description",
                              5,
                              demand,
                              uuid);
                          if (result != null) {
                            callSetState("select", true);
                          }
                        },
                        child: item_detail_gradute(
                            context,
                            Colors.black,
                            Icons.margin,
                            "理想中的TA",
                            demand.description == ""
                                ? "-"
                                : (demand.description),
                            true)),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildPhoto(
    BuildContext context,
    Data userdetails,
    int canEdit,
    bool showControl,
    void Function(String tag, bool value) callSetState,
    String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: false,
            codeFamily: 'Inconsolata',
            text: "用户图片",
            code: "",
            show: Container(
              padding: EdgeInsets.only(top: 20.h, left: 15.w, right: 5.w),
              width: ScreenUtil().screenWidth * 0.98,
              // height: 300,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 0,
                  runSpacing: 0,
                  children: <Widget>[
                    _buildLinkTo(context, userdetails, callSetState, canEdit),
                  ]),
            )),
      ],
    ),
  );
}

Widget buildConnect(List<Widget> connectList, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  //_buildNodes(state.nodes, state.widgetModel.name)
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: connectList.length == 20 ? true : false,
            codeFamily: 'Inconsolata',
            text: "客户沟通记录",
            code: "",
            show: connectList.isNotEmpty
                ? SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    // height: 300,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[...connectList]),
                  )
                : const Text("暂无沟通")),
      ],
    ),
  );
}

Widget buildAppoint(List<Widget> appointListView, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  //_buildNodes(state.nodes, state.widgetModel.name)
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: appointListView.length == 20 ? true : false,
            codeFamily: 'Inconsolata',
            text: "客户排约记录",
            code: "",
            show: appointListView.isNotEmpty
                ? SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    // height: 300,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[...appointListView]),
                  )
                : Container(
                    child: Text("暂无排约"),
                  )),
      ],
    ),
  );
}

Widget buildAction(List<Widget> actionListView, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: actionListView.length == 20 ? true : false,
            codeFamily: 'Inconsolata',
            text: "客户操作记录",
            code: "",
            show: actionListView.isNotEmpty
                ? SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    // height: 300,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[...actionListView]),
                  )
                : Text("暂无记录")),
      ],
    ),
  );
}

Widget buildCall(List<Widget> callListView, bool showControl,
    void Function(String tag, bool value) callSetState, String name) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            name: name,
            callSetState: callSetState,
            showControl: showControl,
            showMore: callListView.length == 20 ? true : false,
            codeFamily: 'Inconsolata',
            text: "电话查看记录",
            code: "",
            show: callListView.isNotEmpty
                ? SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    // height: 300,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[...callListView]),
                  )
                : Container(
                    child: Text("暂无记录"),
                  )),
      ],
    ),
  );
}

Widget buildSelect(List<Widget> selectListView, bool showControl) {
  return Container(
    margin: EdgeInsets.only(left: 15.w, right: 5.w, bottom: 0.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //CustomsExpansionPanelList()
        //_item(context),
        WidgetNodePanel(
            showControl: showControl,
            showMore: selectListView.length == 20 ? true : false,
            codeFamily: 'Inconsolata',
            text: "电话查看记录",
            code: "",
            show: selectListView.length > 0
                ? SizedBox(
                    width: ScreenUtil().screenWidth * 0.98,
                    // height: 300,
                    child: Wrap(
                        alignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
                        children: <Widget>[...selectListView]),
                  )
                : Container(
                    child: const Text("暂无记录"),
                  )),
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
                Icon(
                  icon,
                  size: 32.sp,
                  color: Colors.black54,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10.w),
                ),
                Visibility(
                    visible: true,
                    child: Container(
                      width: ScreenUtil().screenWidth * 0.71,
                      child: Text(
                        answer,
                        maxLines: 20,
                        style: TextStyle(fontSize: 28.sp, color: color),
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
    String type, int maxLine, Info info) {
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
                final logic = Get.find<UserDetailLogic>();
                logic.editUserOnce(info.uuid, type, _controller.text);
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      });
}

showBackDialog(BuildContext context, String title, String hintText, String text,
    String type, int maxLine, int id, String uuid) {
  TextEditingController _controller =
      TextEditingController.fromValue(TextEditingValue(
    text: '${ text}', //判断keyword是否为空
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
                final logic = Get.find<UserDetailLogic>();
                logic.editUserOnce(uuid, type, _controller.text);
                // var result = await IssuesApi.addAppointBack(
                //     id, _controller.text);
                // if (result['code'] == 200) {
                //   showToast(context, "添加成功", false);
                //   Map<String, dynamic> photo = Map();
                //   photo['uuid'] = uuid;
                //   BlocProvider.of<DetailBloc>(context).add(FetchWidgetDetailNoFresh(photo));
                // } else {
                //   showToastRed(context, result['message'], false);
                // }
                Navigator.pop(context);
              },
              child: Text('确定'),
            ),
          ],
        );
      });
}

showEditDialogDemand(BuildContext context, String title, String hintText,
    String text, String type, int maxLine, Demand info, uuid) {
  TextEditingController _controller =
      TextEditingController.fromValue(TextEditingValue(
    text: '${ text}', //判断keyword是否为空
  ));
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Container(
            //elevation: 0.0,
            child: Column(
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
                final logic = Get.find<UserDetailLogic>();
                logic.editUserDemandOnce(uuid, type, _controller.text);
                // var result = await IssuesApi.editCustomerDemandOnce(
                //     uuid, type, _controller.text);
                // if (result['code'] == 200) {
                //   BlocProvider.of<DetailBloc>(context)
                //       .add(EditDetailDemandEvent(type, _controller.text));
                //   //showToast(context,"编辑成功",false);
                // } else {
                //   showToast(context, result['message'], false);
                // }
                Navigator.pop(context);
              },
              child: const Text('确定'),
            ),
          ],
        );
      });
}

String getLevel(int status) {
  if (status == 0) {
    return "C级";
  }
  if (status == 1) {
    return "B级";
  }
  if (status == 2) {
    return "A级";
  }
  if (status == 30) {
    return "D级";
  }
  if (status == 5) {
    return "M级";
  }
  if (status == -1) {
    return "P级";
  }
  return "";
}

Future<bool> showPickerDemandAge(
    BuildContext context, String data, String uuid, int canEdit) async {
  if (canEdit == 0) {
    showToastRed(context, "暂无权限修改", false);
    return false;
  }
  var f = data.split(",");
  var aa = 0, bb = 17;
  try {
    var a = int.parse(f[0]) - 18;
    aa = a;
    var b = int.parse(f[1]) - 18;
    bb = b;
  } catch (e) {
    debugPrint(e.toString());
  }
  if (aa > 80) aa = 80;
  if (bb > 80) bb = 80;
  var result = await Picker(
      selecteds: [aa, bb],
      itemExtent: 40,
      magnification: 1.2,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      cancelText: "取消",
      confirmText: "确定",
      cancelTextStyle: TextStyle(fontSize: 40.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 40.sp, color: Colors.blue),
      adapter: NumberPickerAdapter(data: [
        const NumberPickerColumn(begin: 18, end: 80),
        const NumberPickerColumn(begin: 18, end: 80),
      ]),
      selectedTextStyle: TextStyle(
        fontSize: 40.sp,
        color: Colors.redAccent,
      ),
      textStyle: TextStyle(
        fontSize: 30.sp,
        color: Colors.black,
      ),
      delimiter: [
        PickerDelimiter(
            child: Container(
          width: 30.w,
          alignment: Alignment.center,
          child: const Icon(Icons.more_vert),
        ))
      ],
      hideHeader: true,
      title: const Text("请选择年龄"),
      onConfirm: (Picker picker, List value) async {
        debugPrint(value.toString());
        debugPrint(picker.getSelectedValues().toString());
        var fg = picker.getSelectedValues();
        var values = <String>[];
        for (int i = 0; i < fg.length; i++) {
          values.add(fg[i].toString());
        }
        final logic = Get.find<UserDetailLogic>();
        logic.editUserDemandOnce(uuid, "wish_ages", values.join(","));
        // var result = await IssuesApi.editCustomerDemandOnce(
        //     uuid, "wish_ages", values.join(","));
        // if (result['code'] == 200) {
        //   BlocProvider.of<DetailBloc>(context)
        //       .add(EditDetailDemandEvent("wish_ages", values.join(",")));
        //   showToast(context, "编辑成功", false);
        // } else {
        //   showToast(context, result['message'], false);
        // }
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Future<bool> showPickerDemandHeight(
    BuildContext context, String data, String uuid, int canEdit) async {
  if (canEdit == 0) {
    showToastRed(context, "暂无权限修改", false);
    return false;
  }
  var f = data.split(",");
  var aa = 40, bb = 60;
  try {
    var a = int.parse(f[0]) - 120;
    aa = a;
    var b = int.parse(f[1]) - 120;
    bb = b;
  } catch (e) {
    debugPrint(e.toString());
  }
  if (aa > 200) aa = 200;
  if (bb > 200) bb = 200;
  var result = await Picker(
      selecteds: [aa, bb],
      itemExtent: 40,
      magnification: 1.2,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      cancelText: "取消",
      confirmText: "确定",
      cancelTextStyle: TextStyle(fontSize: 40.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 40.sp, color: Colors.blue),
      adapter: NumberPickerAdapter(data: [
        const NumberPickerColumn(begin: 120, end: 200),
        const NumberPickerColumn(begin: 120, end: 200),
      ]),
      selectedTextStyle: TextStyle(
        fontSize: 40.sp,
        color: Colors.redAccent,
      ),
      textStyle: TextStyle(
        fontSize: 30.sp,
        color: Colors.black,
      ),
      delimiter: [
        PickerDelimiter(
            child: Container(
          width: 30.w,
          alignment: Alignment.center,
          child: const Icon(Icons.more_vert),
        ))
      ],
      hideHeader: true,
      title: const Text("请选择身高"),
      onConfirm: (Picker picker, List value) async {
        debugPrint(value.toString());
        debugPrint(picker.getSelectedValues().toString());
        var fg = picker.getSelectedValues();
        var values = <String>[];
        for (int i = 0; i < fg.length; i++) {
          values.add(fg[i].toString());
        }
        final logic = Get.find<UserDetailLogic>();
        logic.editUserDemandOnce(uuid, "wish_heights", values.join(","));
        // var result = await IssuesApi.editCustomerDemandOnce(
        //     uuid, "wish_heights", values.join(","));
        // if (result['code'] == 200) {
        //   BlocProvider.of<DetailBloc>(context)
        //       .add(EditDetailDemandEvent("wish_heights", values.join(",")));
        //   showToast(context, "编辑成功", false);
        // } else {
        //   showToast(context, result['message'], false);
        // }
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Future<bool> showPickerDemandWeight(
    BuildContext context, String data, String uuid, int canEdit) async {
  if (canEdit == 0) {
    showToastRed(context, "暂无权限修改", false);
    return false;
  }
  var f = data.split("-");
  var aa = 25, bb = 30;
  try {
    var a = int.parse(f[0]) - 40;
    aa = a;
    var b = int.parse(f[1]) - 40;
    bb = b;
  } catch (e) {
    debugPrint(e.toString());
  }
  var result = await Picker(
      selecteds: [aa, bb],
      itemExtent: 40,
      magnification: 1.2,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      cancelText: "取消",
      confirmText: "确定",
      cancelTextStyle: TextStyle(fontSize: 40.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 40.sp, color: Colors.blue),
      adapter: NumberPickerAdapter(data: [
        const NumberPickerColumn(begin: 40, end: 200),
        const NumberPickerColumn(begin: 40, end: 200),
      ]),
      selectedTextStyle: TextStyle(
        fontSize: 40.sp,
        color: Colors.redAccent,
      ),
      textStyle: TextStyle(
        fontSize: 30.sp,
        color: Colors.black,
      ),
      delimiter: [
        PickerDelimiter(
            child: Container(
          width: 30.w,
          alignment: Alignment.center,
          child: const Icon(Icons.more_vert),
        ))
      ],
      hideHeader: true,
      title: const Text("请选择体重"),
      onConfirm: (Picker picker, List value) async {
        debugPrint(value.toString());
        debugPrint(picker.getSelectedValues().toString());
        var fg = picker.getSelectedValues();
        var values = <String>[];
        for (int i = 0; i < fg.length; i++) {
          values.add(fg[i].toString());
        }
        final logic = Get.find<UserDetailLogic>();
        logic.editUserDemandOnce(uuid, "wish_weights", values.join(","));
        // var result = await IssuesApi.editCustomerDemandOnce(
        //     uuid, "wish_weights", values.join("-"));
        // if (result['code'] == 200) {
        //   BlocProvider.of<DetailBloc>(context)
        //       .add(EditDetailDemandEvent("wish_weights", values.join("-")));
        //   showToast(context, "编辑成功", false);
        // } else {
        //   showToast(context, result['message'], false);
        // }
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Future<bool> showPickerArray(
    BuildContext context,
    List<List<String>> pickerData,
    List<int> select,
    String type,
    Info info,
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
        final logic = Get.find<UserDetailLogic>();
        logic.editUserOnce(info.uuid, type, values.toString());
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Future<bool> showPickerArrayDemand(
    BuildContext context,
    List<List<String>> pickerData,
    List<int> select,
    String type,
    Demand info,
    String title,
    bool isIndex,
    String uuid) async {
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
        String values;
        if (isIndex) {
          values = value.first.toString();
        } else {
          values = (picker.getSelectedValues().first.toString());
        }
        final logic = Get.find<UserDetailLogic>();
        logic.editUserDemandOnce(uuid, type, values.toString());
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Future<bool> showPickerDateTime(
    BuildContext context, String date, String type, Info info) async {
  String dates = "";
  if (date == "-") {
    dates = "1999-01-01 08:00:00";
  } else {
    dates = date;
  }
  var result = await Picker(
      itemExtent: 40,
      magnification: 1.2,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      adapter: DateTimePickerAdapter(
        type: PickerDateTimeType.kYMD,
        isNumberMonth: true,
        //strAMPM: const["上午", "下午"],
        // yearSuffix: "年",
        // monthSuffix: "月",
        // daySuffix: "日",
        value: DateTime.parse(dates),
        maxValue: DateTime.now(),
        minuteInterval: 1,
        minHour: 0,
        maxHour: 23,
        // twoDigitYear: true,
      ),
      title:
          Text("选择日期", style: TextStyle(fontSize: 35.sp, color: Colors.black)),
      cancelText: "取消",
      confirmText: "确定",
      cancelTextStyle: TextStyle(fontSize: 40.sp, color: Colors.grey),
      confirmTextStyle: TextStyle(fontSize: 40.sp, color: Colors.blue),
      textAlign: TextAlign.center,
      selectedTextStyle: const TextStyle(color: Colors.redAccent),
      delimiter: [
        PickerDelimiter(
            column: 4,
            child: Container(
              width: 16.w,
              alignment: Alignment.center,
              child:
                  const Text('', style: TextStyle(fontWeight: FontWeight.bold)),
              color: Colors.white,
            ))
      ],
      footer: Container(
        height: 50.h,
        alignment: Alignment.center,
        child: const Text(''),
      ),
      onConfirm: (Picker picker, List value) async {
        final logic = Get.find<UserDetailLogic>();
        logic.editUserOnce(info.uuid, type, picker.adapter.text);
      },
      onSelect: (Picker picker, int index, List<int> selecteds) {
        var stateText = picker.adapter.toString();
      }).showDialog(context);
  if (result != null) {
    return true;
  }
  return false;
}

Widget _buildLinkTo(BuildContext context, Data userdetail,
    void Function(String tag, bool value) callSetState, int canEdit) {
  List<Pics> imgList = userdetail.pics;
  var imageUrlList = <String>[];
  for (int i = 0; i < imgList.length; i++) {
    imageUrlList.add(imgList[i].fileUrl);
  }
  var imageListView = <ImageOptions>[];
  var picListView = <PicInfo>[];

  for (int i = 0; i < imgList.length; i++) {
    var e = imgList[i];
    if (e.fileUrl == "") continue;
    imageListView.add(ImageOptions(
      url: e.fileUrl,
      tag: e.fileUrl,
    ));

    picListView.add(PicInfo(
      url: e.fileUrl,
    ));

  }

  List<Widget> list = [];
  if (imgList.isNotEmpty) {
    for (int i = 0; i < imgList.length; i++) {
      var e = imgList[i];
      const String defaultImg =
          'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
      var boxWidth = ScreenUtil().screenWidth / 3 - 40.w;
      var imageHeight = 200.h;
      var boxMargin = 10.w;

      Widget adds = GestureDetector(
        onTap: () {
          // ImagePreview.preview(
          //   initialIndex: i,
          //   images: imageListView,
          //   onIndexChanged: (e) {},
          //   onLongPressed: (e) {},
          // );
          Get.to(() => IMUtil.previewPic(
              index: i,
              tag: e.fileUrl != ""
                  ? e.fileUrl
                  : ("assets/packages/images/ic_user_none_round.png"), picList: picListView));
        },
        child: Padding(
          key: ObjectKey(e.id),
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, bottom: boxMargin * 2),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.w),
                ),
                child: SizedBox(
                  width: boxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.blue,
                        child: Stack(
                          children: <Widget>[
                            SizedBox(
                              width: 250.w,
                              height: 200.h,
                              child: getCacheImage(
                                e.fileUrl != "" ? e.fileUrl : defaultImg,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                width: 50.w,
                                height: 50.h,
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(70),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.w),
                                    // Radius.circular(10.w),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if (canEdit == 0) {
                                      showToastRed(context, "暂无权限", true);
                                      return;
                                    }
                                    _deletePhoto(context, e, userdetail.info);
                                  },
                                  child: const Icon(
                                    CupertinoIcons.delete_solid,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              top: 0,
                              right: 0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      if (e.fileUrl != "") {
        list.add(adds);
      }
    }
  }

  list.add(GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Image.asset(
          "assets/images/add.png",
          width: 200.w,
          height: 200.h,
        ),
      ),
      onTap: () async {
        if (canEdit == 0) {
          showToastRed(context, "暂无权限", true);
          return;
        }
        //_getPermission(context);
        // List<Asset> images = <Asset>[];
        // List<Asset> resultList = <Asset>[];
        //
        // try {
        //   resultList = await MultiImagePicker.pickImages(
        //     // 选择图片的最大数量
        //     maxImages: 1,
        //     // 是否支持拍照
        //     enableCamera: true,
        //     materialOptions: MaterialOptions(
        //         // 显示所有照片，值为 false 时显示相册
        //         startInAllView: false,
        //         allViewTitle: '所有照片',
        //         actionBarColor: '#2196F3',
        //         textOnNothingSelected: '没有选择照片'),
        //   );
        // } on Exception catch (e) {
        //   e.toString();
        // }
        // //if (!mounted) return;
        // images = (resultList == null) ? [] : resultList;
        // // 上传照片时一张一张上传
        // for (int i = 0; i < images.length; i++) {
        //   // 获取 ByteData
        //   ByteData byteData = await images[i].getByteData(quality: 100);
        //
        //   EasyLoading.show();
        //   try {
        //     var resultConnectList =
        //         await IssuesApi.uploadPhoto("1", byteData, _loading);
        //     // debugPrint(resultConnectList['data']);
        //
        //     var result = await IssuesApi.editCustomer(
        //         userdetail['info']['uuid'], "1", resultConnectList['data']);
        //     if (result['code'] == 200) {
        //       BlocProvider.of<DetailBloc>(context).add(UploadImgSuccessEvent(
        //           userdetail, resultConnectList['data'], result['data']));
        //       showToast(context, "上传成功", false);
        //       callSetState("photo", true);
        //     } else {
        //       showToast(context, result['message'], false);
        //     }
        //   } on DioError catch (e) {
        //     var dd = e.response.data;
        //     EasyLoading.showSuccess(dd['message']);
        //     //showToast(context,dd['message'],false);
        //   }
        //   EasyLoading.dismiss();
        // }

        List<AssetEntity> asset = <AssetEntity>[];
       var assets =  await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            textDelegate: const AssetPickerTextDelegate(),
            maxAssets: 1,
            selectedAssets: asset,
            pickerTheme: AssetPicker.themeData(
              Colors.lightBlueAccent,
              light: true,
            ),
          ),
        );
       var  imageFile =  assets!.first;
        File? file = await imageFile.file;
        // final pickedImage = await ImagePicker()
        //     .getImage(source: ImageSource.gallery, imageQuality: 50);
        // File? imageFile = pickedImage != null ? File(pickedImage.path) : null;
        if (file?.path != null) {
          File? croppedFile = await ImageCropper().cropImage(
              aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 2),
              sourcePath: file!.path,
              aspectRatioPresets: Platform.isAndroid
                  ? [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ]
                  : [
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio5x3,
                      CropAspectRatioPreset.ratio5x4,
                      CropAspectRatioPreset.ratio7x5,
                      CropAspectRatioPreset.ratio16x9
                    ],
              androidUiSettings: const AndroidUiSettings(
                  hideBottomControls: true,
                  toolbarTitle: '图片裁剪',
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: true),
              iosUiSettings: const IOSUiSettings(
                title: '图片裁剪',
              ));
          if (croppedFile != null) {
            final logic = Get.find<UserDetailLogic>();
            logic.uploadPhoto(croppedFile.path);
          }
        }
      }));

  return Wrap(
    children: [...list],
  );
}

_deletePhoto(BuildContext context, Pics img, Info detail) {
  showDialog(
      context: context,
      builder: (ctx) => Dialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.w))),
            child: Container(
              width: 50,
              child: DeleteCategoryDialog(
                title: '删除图片',
                content: '是否确定继续执行?',
                onSubmit: () {
                  // BlocProvider.of<DetailBloc>(context)
                  //     .add(EventDelDetailImg(img, detail['info']));
                  final logic = Get.find<UserDetailLogic>();
                  logic.delPhoto(img.id);

                  Navigator.of(context).pop();
                },
              ),
            ),
          ));
}

Widget item_detail_gradute(BuildContext context, Color color, IconData icon,
    String name, String answer, bool show) {
  bool isDark = false;

  return Container(
    padding: EdgeInsets.only(top: 10.h, bottom: 0),
    width: double.infinity,
    //height: 180.h,
    child: Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.only(
              left: 10.w, right: 20.w, top: 10.h, bottom: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                Icon(
                  icon,
                  size: 32.sp,
                  color: Colors.black54,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.w),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 30.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10.w),
                ),
                Visibility(
                    visible: true,
                    child: SizedBox(
                      width: ScreenUtil().screenWidth * 0.58,
                      child: Text(
                        answer,
                        maxLines: 20,
                        style: TextStyle(fontSize: 28.sp, color: color),
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

avatar(String url, bool isVip, String name) {
  return Stack(
    children: [
      url == ""
          ? Container(
              margin: EdgeInsets.only(left: 20.w, top: 20.h),
              color: Colors.transparent,
              child: CircleText(
                text: name,
                size: 140.w,
                fontSize: 50.sp,
                color: Colors.lightBlue,
                //shadowColor: Colors.transparent,
              ),
            )
          : Container(
              margin: EdgeInsets.only(left: 30.w, top: 32.h),
              child: CircleAvatar(
                radius: (70.w),
                child: ClipOval(
                  child: SizedBox(
                    width: 160.w,
                    height: 160.h,
                    child: getCacheImage(
                      url,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
      isVip
          ? Container(
              width: 200.w,
              height: 200.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/radio_header_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.only(left: 0.w, top: 10.h),
            )
          : Container(),
    ],
  );
}

header(BuildContext context, Data user) {
  bool isVip = false;
  bool expire = false;
  String vipName = "";
  String vipName1 = "";
  var vipExpireTime = user.info.vipExpireTime;
  if (vipExpireTime == "") {
    isVip = false;
  } else {
    if (user.info.status == 2) {
      if (user.info.vipId > 0 &&
          DateTime.parse(user.info.vipExpireTime).millisecondsSinceEpoch >
              DateTime.now().millisecondsSinceEpoch) {
        isVip = true;
        vipName = user.info.vipName;
        vipName1 = "(" + user.info.vipExpireTime + ")";
      } else {
        expire = true;
        vipName1 = "(会员已过期)";
      }
    } else {}
  }
  var headImg = "";
  if (user.info.headImg == "") {
    headImg = user.info.headImg;
  } else {
    if (user.info.checked == 0) {
      headImg = user.info.headImg;
    } else {
      headImg = user.info.esAge;
    }
  }

  return Container(
    height: 166.h,
    margin: EdgeInsets.only(top: 0.h, bottom: 0.h, left: 0.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              // ImagePreview.preview(
              //   images: List.generate(1, (index) {
              //     return ImageOptions(
              //       url: headImg != ""
              //           ? headImg
              //           : ("assets/packages/images/ic_user_none_round.png"),
              //       tag: headImg != ""
              //           ? headImg
              //           : ("assets/packages/images/ic_user_none_round.png"),
              //     );
              //   }),
              // );
                Get.to(() => IMUtil.previewPic(
                    index: 0,
                    tag: headImg != ""
                        ? headImg
                        : ("assets/packages/images/ic_user_none_round.png"), picList: [PicInfo(url: headImg != ""
                    ? headImg
                    : ("assets/packages/images/ic_user_none_round.png"))]));

            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 0.w),
              child: headImg != ""
                  ? avatar(headImg, isVip, user.info.name)
                  : Container(
                      margin: EdgeInsets.only(left: 20.w, top: 0.h),
                      width: 180.w,
                      height: 180.h,
                      child: Image.asset(
                          "assets/packages/images/ic_user_none_round.png"),
                    ),
            )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    constraints: BoxConstraints(
                      maxWidth: 120.w,
                    ),
                    margin: EdgeInsets.fromLTRB(10.w, 10.h, 0.w, 0.h),
                    child: Text(
                      user.info.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Container(
                    //color: Colors.black12,
                    padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 0.h),
                    margin: EdgeInsets.fromLTRB(5.w, 10.h, 0.w, 0.h),
                    alignment: Alignment.centerLeft,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 100),
                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(5.h)),
                      //设置四周边框
                      border: Border.all(width: 1, color: Colors.red),
                    ),
                    child: Text(
                      user.info.age.toString() + "岁",
                      style: TextStyle(color: Colors.black, fontSize: 18.sp),
                    )),
                isVip == true
                    ? Container(
                        width: 60.h,
                        height: 60.h,
                        margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.h),
                        child: Lottie.asset(
                            'assets/packages/lottie_flutter/vip-icon.json'),
                      )
                    : Container(),
                Container(
                    constraints: BoxConstraints(
                      maxWidth: 110.w,
                    ),
                    margin: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0.h),
                    child: Text(
                      vipName,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Container(
                    constraints: BoxConstraints(
                      maxWidth: 170.w,
                    ),
                    margin: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0.h),
                    child: Text(
                      vipName1,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                user.info.locationPlace == ""
                    ? Container(
                        margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0.h),
                        height: 40.h,
                      )
                    : Container(
                        width: 280.w,
                        child: Tag(
                          color: Color.fromRGBO(241, 241, 241, 100),
                          borderColor: Color.fromRGBO(241, 241, 241, 100),
                          borderWidth: 1,
                          margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 0.h),
                          height: 40.h,
                          radius: 10.w,
                          text: Text(
                            user.info.locationPlace.toString(),
                            style: TextStyle(
                              fontSize: 24.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                user.info.serveUser != ""
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                        child: Text(
                          user.info.serveUser != "" ? "服务:" : "",
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontWeight: FontWeight.w300,
                            fontSize: 25.sp,
                          ),
                        ))
                    : (user.info.saleUser != ""
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 0.h),
                            child: Text(
                              user.info.saleUser != "" ? "销售:" : "",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.w300,
                                fontSize: 25.sp,
                              ),
                            ))
                        : Container(
                            margin: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 0.h),
                          )),
                user.info.serveUser != ""
                    ? Container(
                        margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
                        child: Text(
                          user.info.serveUser,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 25.sp,
                          ),
                        ))
                    : (user.info.saleUser == ""
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 0.h),
                          )
                        : Container(
                            margin: EdgeInsets.fromLTRB(0.w, 5.h, 5.w, 0.h),
                            child: Text(
                              user.info.saleUser,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 25.sp,
                              ),
                            ))),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
