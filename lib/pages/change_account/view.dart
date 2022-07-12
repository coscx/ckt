import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/routers/names.dart';
import '../../common/services/storage.dart';
import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/extend_image.dart';
import 'logic.dart';

class ChangeAccountPage extends StatelessWidget {
  final logic = Get.find<ChangeAccountLogic>();
  final state = Get
      .find<ChangeAccountLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffefefef),
      child: Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme.of(context).copyWith(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light, // Status bar
              ),
            ),
          ),
          child: SafeArea(
            child: Obx(() {
              return Scaffold(
                  backgroundColor: Color(0xffefefef),
                  appBar: AppBar(
                    titleSpacing: 220.w,
                    leadingWidth: 100.w,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              logic.manage.value = !logic.manage.value;
                            },
                            child: Text(logic.manage.value == true
                                ? "管理"
                                : "取消",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                      SizedBox(width: 40.w),
                    ],
                    //bottom: bar(),
                  ),
                  body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:Column(
                    children: [
                      _buildTopLogos(),
                      _buildTopTitle(),
                      ScrollConfiguration(
                          behavior: DyBehaviorNull(),
                          child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                padding: EdgeInsets.only(top: 100.h),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      _buildContent(),
                                    ]),
                              )
                          )),
                    ],
                  ))
              );
            }),
          )),
    );
  }

  Widget _buildContent() {
    return GetBuilder<ChangeAccountLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          margin: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // _buildAddAccount(),
              // Container(height: 20.h, color: Color(0xffefefef),),
              // _buildAddAccount1(),
              ..._buildList(),
              //Container(height: 20.h, color: Color(0xffefefef),),
              _buildAddAccount2(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildList() {
    return logic.account.reversed.map((e) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: logic.manage.value == true ? (Colors.white) : (e
                    .memberid == StorageService.to.getString("memberId")
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white),
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: logic.manage.value == false &&
                    e.memberid != StorageService.to.getString("memberId")
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              logic.changeAccount(e);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  top: 20.h,
                                  bottom: 20.h),
                              height: 120.h,
                              child: e.avatar != ""
                                  ? Container(
                                  width: 100.w,
                                  child: getCacheImage(e.avatar))
                                  : Image.asset(
                                  "assets/images/default/ic_user_male.png"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.name != "" ? e.name : "MSTAR",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.normal)),
                              Text(
                                  e.mobile != "" ? e.mobile : "13355088996",
                                  style: TextStyle(
                                      color: Color(0xffaaaaaa),
                                      fontSize: 27.sp,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                  e.memberid == StorageService.to.getString("memberId")
                      ? Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20.w, top: 28.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5.w),
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              5))),
                                ),
                                Text("当前使用",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
                      :
                  (logic.manage.value == false ? Container(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.w),
                            ),
                            side: BorderSide(
                              width: 0, color: Colors.redAccent,),
                          ),
                          child: Container(
                            child: Text("清除", style: TextStyle(
                                fontFamily: "PingFang",
                                fontSize: 30.sp,
                                color: Colors.white),),
                            padding: EdgeInsets.only(
                                top: 0.h, left: 0.w, bottom: 0.h, right: 0.w),
                          ),
                          onPressed: () {
                            logic.removeAccount(e);
                          },
                        ),
                      ],
                    ),
                  ) : Container()),

                ],
              )
          ),

          Container(height: 20.h, color: Color(0xffefefef),),

        ],
      );
    }).toList();
  }


  Widget _buildAddAccount2() {
    return logic.manage.value == true ? Container(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.offAllNamed(AppRoutes.LOGIN);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                          height: 120.h,
                          child: Image.asset("assets/images/ckt/add-image.png"),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("添加账号",
                              style: TextStyle(
                                  color: Color(0xff808080),
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),

                    ],
                  ),
                ],
              ),

            ],
          )
      ),
    ) : Container();
  }

  Widget _buildTopLogos() {
    return Container(
        height: 50.h,
        child: Image.asset("assets/images/ckt/logo.png")
    );
  }

  Widget _buildTopTitle() {
    return Container(
      padding: EdgeInsets.only(top: 90.h),
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(logic.manage.value == true ? "轻触头像以切换账号" : "清除登录痕迹",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 50.sp,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
