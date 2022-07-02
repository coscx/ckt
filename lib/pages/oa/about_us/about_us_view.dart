import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../common/widgets/chat/images.dart';
import '../../../common/widgets/chat/strings.dart';
import '../../../common/widgets/chat/styles.dart';
import '../../../common/widgets/chat/titlebar.dart';
import '../../../common/widgets/common_webview.dart';
import '../../../common/widgets/navigator_utils.dart';
import 'about_us_logic.dart';

class AboutUsPage extends StatelessWidget {
  final logic = Get.find<AboutUsLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 40.w,
        leadingWidth: 60.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("关于",
            style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 38.sp,
              decoration: TextDecoration.none,
              color: Colors.black,
            )),
        //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
        backgroundColor: Colors.white,
        elevation: 0,

        //bottom: bar(),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24.h,
          ),
          Image.asset(
            ImageRes.ic_aboutUs,
            width: 120.h,
            height: 100.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Obx(() => Text(
                'V${logic.version.value}',
                style: PageStyle.ts_333333_26sp,
              )),
          SizedBox(
            height: 24.h,
          ),

          _buildItemView(
            label: "用户协议",
            onTap: (){
              NavigatorUtils.pushPage(
                context: context,
                targPage: CommonWebViewPage(
                  pageTitle: "用户协议",
                  htmlUrl: "http://link.queqiaochina.com/agree.html",
                ),
              );
            }
          ),
          _buildItemView(
            label: "隐私政策",
              onTap: (){
                NavigatorUtils.pushPage(
                  context: context,
                  targPage: CommonWebViewPage(
                    pageTitle: "隐私政策",
                    htmlUrl: "http://link.queqiaochina.com/privacy.html",
                  ),
                );
              }
          ),

        ],
      ),
    );
  }

  Widget _buildItemView({required String label, Function()? onTap}) => Ink(
        color: PageStyle.c_FFFFFF,
        height: 80.h,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 44.w),
            decoration: BoxDecoration(
              border: BorderDirectional(
                bottom: BorderSide(
                  color: PageStyle.c_999999_opacity40p,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: PageStyle.ts_333333_32sp,
                ),
                Spacer(),
                Image.asset(
                  ImageRes.ic_next,
                  width: 10.w,
                  height: 18.h,
                )
              ],
            ),
          ),
        ),
      );
}
