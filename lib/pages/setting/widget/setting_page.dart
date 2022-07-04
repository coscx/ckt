import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/routers/names.dart';
import '../../../common/style/toly_icon.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../../common/widgets/delete_category_dialog.dart';

class SettingPages extends StatelessWidget {
  bool showBackGround =false;
  bool animate =false;
  bool showPerformanceOverlay =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0, //去掉Appbar底部阴影
        title: Text('应用设置',
            style: TextStyle(
                color: Colors.black,
                fontSize: 48.sp,
                fontWeight: FontWeight.normal)),
      ),
      body: ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child: Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[
                // ListTile(
                //   leading: Icon(
                //     Icons.palette,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   title: Text('主题色设置'),
                //   trailing: _nextIcon(context),
                //   onTap: () => Navigator.of(context)
                //       .pushNamed(UnitRouter.theme_color_setting),
                // ),
                // Divider(),
                // ListTile(
                //   leading: Icon(
                //     Icons.translate,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   title: Text('字体设置'),
                //   trailing: _nextIcon(context),
                //   onTap: () =>
                //       Navigator.of(context).pushNamed(UnitRouter.font_setting),
                // ),
                //
                // Divider(),
                // _buildShowBg(context),
                // Divider(),
                // _buildAnimate(context),
                // Divider(),
                // _buildShowOver(context),
                // Divider(),
                // ListTile(
                //   leading: Icon(
                //     Icons.info,
                //     color: Theme.of(context).primaryColor,
                //   ),
                //   title: Text('版本信息'),
                //   trailing: _nextIcon(context),
                //   onTap: () =>
                //       Navigator.of(context).pushNamed(UnitRouter.version_info),
                // ),
                //
                // Divider(),
                SizedBox(
                  height: 40.h,
                ),
                buildChangeButton(context, "切换账号", Colors.blue),
                SizedBox(
                  height: 20.h,
                ),
                buildButton(context, "退出登录", Colors.blue),

              ],
            ),
          )),
    );
  }

  _exit(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.w))),
              child: Container(
                width: 100.w,
                child: DeleteCategoryDialog(
                  title: '退出登录',
                  content: '是否确定继续执行?',
                  onSubmit: () {
                    FltImPlugin im = FltImPlugin();
                    im.logout();
                    Future.delayed(const Duration(milliseconds: 1)).then((e) async {
                      await StorageService.to.remove("im_token");
                      await StorageService.to.remove("memberId");
                      await StorageService.to.remove("token");
                      await StorageService.to.remove("user_token");
                      await StorageService.to.remove("user_profile");
                      Get.offAllNamed(AppRoutes.LOGIN);
                    });
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     new MaterialPageRoute(builder: (context) => LoginPage()
                    //     ), (route) => route == null);
                  },
                ),
              ),
            ));
  }

  Widget buildButton(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _exit(context);
          },
          child:
              Container(child: Text(txt, style: TextStyle(fontSize: 33.sp, color: Colors.white)),
              padding: EdgeInsets.only(top: 10.h,left: 55.w,bottom:10.h,right: 55.w),

              ),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Theme.of(context).primaryColor,
              shadowColor: Colors.black12,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 65.w, vertical: 15.h)),
        ),
      ],
    );
  }
  Widget buildChangeButton(BuildContext context, String txt, MaterialColor color) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(AppRoutes.ChangeAccount);
          },
          child:
          Container(child: Text(txt, style: TextStyle(fontSize: 33.sp, color: Colors.white)),
            padding: EdgeInsets.only(top: 10.h,left: 55.w,bottom:10.h,right: 55.w),

          ),
          style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Theme.of(context).primaryColor,
              shadowColor: Colors.black12,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 65.w, vertical: 15.h)),
        ),
      ],
    );
  }
  Widget _buildShowBg(BuildContext context) =>
       SwitchListTile(
                value: showBackGround,
                secondary: Icon(
                  TolyIcon.icon_background,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('主页选择记忆'),
                onChanged: (show) {

                },
              );

  Widget _buildAnimate(BuildContext context) =>
      SwitchListTile(
                value: animate,
                secondary: Icon(
                  TolyIcon.icon_star,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('开启动画'),
                onChanged: (show) {

                },
              );

  Widget _buildShowOver(BuildContext context) =>
       SwitchListTile(
                value: showPerformanceOverlay,
                secondary: Icon(
                  TolyIcon.icon_show,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('显示性能浮层'),
                onChanged: (show) {

                },
              );

  Widget _nextIcon(BuildContext context) =>
      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
