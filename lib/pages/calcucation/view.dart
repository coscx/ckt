import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/routers/names.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/widgets/dy_behavior_null.dart';
import '../frame/login/view.dart';
import 'logic.dart';

class CalcucationPage extends StatelessWidget {
  final logic = Get.find<CalcucationLogic>();
  final state = Get.find<CalcucationLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalcucationLogic>(builder: (logic) {
      return Scaffold(
          body: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // 触摸收起键盘
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Stack(
                      children: [
                        arcBackground(),
                        Container(
                            padding: EdgeInsets.only(top: 400.h),
                            width: ScreenUtil().screenWidth,
                            height: ScreenUtil().screenHeight,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  child: Container(
                                    width: ScreenUtil().screenWidth,
                                    height: ScreenUtil().screenHeight,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w),)),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                           Container(
                                             child: Row(
                                               children: [
                                                 Container(
                                                   child: Text("装修贷额度测算",
                                                       style: TextStyle(fontFamily: "PingFang",fontSize: 40.sp,color: Color(0xffDE2821)),
                                                       ),
                                                 ),
                                                 //Image.asset("assets/images/ckt/icon_cesuan.webp")

                                               ],
                                             ),
                                             padding: EdgeInsets.only(top: 40.h,left: 40.w),
                                           ),
                                            buildUsernameInput(),
                                            buildPasswordInput(),

                                          ],
                                        ),
                                        SizedBox(height: 40.h,),
                                        _buildButton(),

                                        _buildToQuotaList(),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),


                  ]),
                ),
              )));
    });
  }
Widget  _buildToQuotaList(){
    return Container(
      padding: EdgeInsets.only(top: 100.h,),
      child: GestureDetector(
        onTap: (){
           Get.toNamed(AppRoutes.CalcucationList);
        },
        child: Container(
          child: Text("历史测算记录",style: TextStyle(fontFamily: "PingFang",fontSize: 30.sp,color: Color(0xffDE2821)),
        ),

      )),
    );
}
  Widget _buildButton(){
  return  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: OutlinedButton(
        style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(70.w),
          ),
          side: BorderSide(width: 1.6.w, color: Color(0xffDE2821)),
          ),
            child: Container(
                child: Text("初步估算",style: TextStyle(fontFamily: "PingFang",fontSize: 30.sp,color: Color(0xffDE2821)),),
              padding: EdgeInsets.only(top: 28.h,left: 55.w,bottom:28.h,right: 55.w),

            ),
            onPressed: () {
                   Get.toNamed(AppRoutes.CalcucationPrepare,arguments: {"name":logic.usernameController.text,"mobile":logic.passwordController.text});
            },
          ),
      ),
     SizedBox(width: 40.w,),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xffDE2821),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70.w),
            ),
            side: BorderSide(width: 0, color: Color(0xffcccccc)),
          ),
          child: Container(
            child: Text("精准测算",style: TextStyle(fontFamily: "PingFang",fontSize: 30.sp,color: Colors.white),),
            padding: EdgeInsets.only(top: 28.h,left: 55.w,bottom:28.h,right: 55.w),
          ),
          onPressed: () {},
        ),
      ),
    ],
  );

  }
  Widget buildUsernameInput() {
    return Container(
      padding: EdgeInsets.only(top: 40.h,left: 20.w,right: 20.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF7F9FB),
              borderRadius: BorderRadius.circular(15.w),
            ),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Colors.black,
                    ),
                    controller: logic.usernameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                      border: InputBorder.none,
                      hintText: '请输入预测人姓名',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30.sp,fontFamily: "PingFang",),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPasswordInput() {
    return Container(
      padding: EdgeInsets.only(top: 20.h,left: 20.w,right: 20.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF7F9FB),
              borderRadius: BorderRadius.circular(15.w),
            ),
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 35.sp,
                      color: Colors.black,
                    ),
                    focusNode: logic.textFieldNode,
                    controller: logic.passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                      border: InputBorder.none,
                      hintText: '请输入您的手机号码',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 30.sp,fontFamily: "PingFang",),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget arcBackground() {
    return ArcBackground(
      image: const AssetImage("assets/images/ckt/banner.webp"),
      child: Padding(
        padding: EdgeInsets.all(100.w),
        child: Container(
            height: 260.h,
            padding: EdgeInsets.all(20.w),
            // decoration: BoxDecoration(
            //     color: Colors.white.withAlpha(0), shape: BoxShape.rectangle),
            child: Container()
        ),
      ),
    );
  }


}
class ArcBackground extends StatelessWidget {
  final Widget child;
  final ImageProvider image;
  const ArcBackground({Key? key, required this.child, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}