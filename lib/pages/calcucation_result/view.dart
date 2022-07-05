import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/utils/common.dart';
import 'logic.dart';

class CalcucationResultPage extends StatelessWidget {
  final logic = Get.find<CalcucationResultLogic>();
  final state = Get.find<CalcucationResultLogic>().state;

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
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    titleSpacing: 220.w,
                    leadingWidth: 100.w,
                    elevation: 0,
                    title: Text("测算结果",
                        style: TextStyle(fontSize: 36.sp, color: Colors.black)),
                  ),
                  body: Column(
                    children: [
                      Container(
                        width: ScreenUtil().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                                margin: EdgeInsets.only(left: 50.w, top: 20.h),
                                child: Text("恭喜您",
                                    style: TextStyle(
                                        fontSize: 50.sp, color: Colors.black))),
                            Container(

                                margin: EdgeInsets.only(left: 50.w, top: 0.h,bottom: 20.h),
                                child: Text("您的装修贷测算结果为:",
                                    style: TextStyle(
                                        fontSize: 32.sp, color: Colors.black))),
                            Container(
                                margin:
                                    EdgeInsets.only(left: 30.w, right: 30.h),
                                width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.w),
                                      topRight: Radius.circular(150.w),
                                      bottomLeft: Radius.circular(24.w),
                                      bottomRight: Radius.circular(24.w)),

                                 gradient: LinearGradient(
                                        stops: [0,1],
                                        colors: [
                                          Color(0xffFF241B),
                                          Color(0xffFF9D18),
                                        ],
                                        begin: Alignment(-2, 1),
                                        end: Alignment(2, 1),
                                      )
                                ),
                                child: logic.result =="" ? _buildNoResult()  :_buildContent(logic)
                            ),
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
Widget _buildNoResult(){
   return Column(
     children: [
       Container(
         height: 400.h,
         padding: EdgeInsets.only(
             top: 80.w, bottom: 0.h, left: 40.w),
         child: Image.asset("assets/images/ckt/no_result.png"),
       ),
       Container(
         padding: EdgeInsets.only(
             top: 0.w, bottom: 10.h, left: 40.w),
         child: Text("您当前不具备贷款资质",
             style: TextStyle(
                 fontSize: 40.sp,
                 color: Colors.white)),
       ),
       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             padding: EdgeInsets.only(
                 right: 50.h, left: 50.w,top: 40.h,bottom: 50.h),
             width: ScreenUtil().screenWidth,
             decoration: BoxDecoration(

               borderRadius:
               BorderRadius.circular(15.w),
             ),
             child: OutlinedButton(
               style: OutlinedButton.styleFrom(
                 backgroundColor:
                 Colors.white,
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
                   "重新测算",
                   style: TextStyle(
                       fontSize: 28.sp,
                       color: Colors.redAccent),
                 ),
                 padding: EdgeInsets.only(
                     top: 25.h,
                     left: 55.w,
                     bottom: 25.h,
                     right: 55.w),
               ),
               onPressed: () {
                 Navigator.of(Get.context!).pop();
               },
             ),
           ),
         ],
       ),

     ],
   );
}

Widget _buildContent(CalcucationResultLogic logic){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.only(
            top: 80.w, bottom: 10.h, left: 40.w),
        child: Text("本次申请分期可授予额度为  (元)",
            style: TextStyle(
                fontSize: 32.sp,
                color: Colors.white)),
      ),
      Container(
        padding: EdgeInsets.only(
            top: 10.w, bottom: 20.h, left: 50.w),
        child: Text(formatNum(logic.result),
            style: TextStyle(
                fontSize: 120.sp,
                color: Colors.white)),
      ),

      Container(
        padding: EdgeInsets.only(
            top: 0.w, bottom: 40.h, left: 50.w,right: 40.w),
        child: MySeparator(height: 1.h,color: Colors.white.withOpacity(0.5),),
      ),
      Container(
        padding: EdgeInsets.only(
            top: 10.w, right: 20.h, left: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMiddle("assets/images/ckt/edu.png","额度高","最高额度100万"),
            _buildMiddle("assets/images/ckt/qianxian.png","期限长","最长期限8年"),
            _buildMiddle("assets/images/ckt/fangkuan.png","放款快","最快一天放款"),
          ],
        ),
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(
                right: 50.h, left: 50.w,top: 80.h,bottom: 60.h),
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(15.w),
            ),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor:
                Colors.white,
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
                  "重新测算",
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.redAccent),
                ),
                padding: EdgeInsets.only(
                    top: 25.h,
                    left: 55.w,
                    bottom: 25.h,
                    right: 55.w),
              ),
              onPressed: () {
                Navigator.of(Get.context!).pop();
              },
            ),
          ),
        ],
      ),

    ],
  );
}
Widget _buildMiddle(String icon,title,subtitle){

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          width: 65.w,
          padding: EdgeInsets.only(
              top: 10.w, bottom: 0.h, left: 22.w),
          child: Image.asset(icon),
        ),

        Container(
          padding: EdgeInsets.only(
              top: 15.w, bottom: 0.h, left: 22.w),
          child: Text(title,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white)),
        ),
        Container(
          padding: EdgeInsets.only(
              top: 2.w, bottom: 0.h, left: 22.w),
          child: Text(subtitle,
              style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white)),
        ),

      ],
    ),
  );

}



class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 2.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
