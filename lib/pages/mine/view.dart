import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/routers/names.dart';
import '../../common/widgets/delete_category_dialog.dart';
import '../../common/widgets/extend_image.dart';
import 'logic.dart';

class MinePage extends StatelessWidget {
  final logic = Get.find<MineLogic>();
  final state = Get
      .find<MineLogic>()
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
        child: GetBuilder<MineLogic>(builder: (logic) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leadingWidth: 0,
                  leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
                  backgroundColor: Colors.white,
                  expandedHeight: 220.h,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, -0.4),
                              colors: <Color>[
                                Color(0x00000000),
                                Color(0x00000000)
                              ],
                            ),
                          ),
                        ),

                        Container(
                          height: 120.h,
                          width: 120.w,
                          alignment: FractionalOffset.topLeft,
                          child: Image.asset(
                              "assets/packages/images/friend_card_bg.png"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              width: 150.w,
                              child: Stack(
                                children: [
                                  logic.userHead== "" ? Container() :
                                  Positioned(
                                    left: 25.w,
                                    top: 120.h,
                                    child: Container(
                                      width: 90.h,
                                      height: 90.h,
                                      child: Container(
                                        child: ClipOval(
                                          child: Container(
                                            child: getCacheImage(
                                              logic.userHead,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.w,
                                    top: 100.h,
                                    child: Container(
                                      width: 120.h,
                                      height: 120.h,
                                      //margin: EdgeInsets.fromLTRB(1.w, 5.h, 5.w, 0.h),
                                      child: Lottie.asset(
                                          'assets/packages/lottie_flutter/36535-avatar-pendant.json'),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(
                                top: 60.h,
                                left: 20.w,
                                bottom: 0.h,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 0.h,
                                      left: 30.w,
                                      bottom: 5.h,
                                    ),
                                    child: Text(
                                      logic.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40.sp),
                                    ),
                                  ),

                                  Container(

                                    padding: EdgeInsets.only(
                                      top: 0.h,
                                      left: 30.w,
                                      bottom: 0.h,
                                    ),

                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/packages/images/bb_id.svg",
                                            //color: Colors.black87,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 0.h,
                                              left: 10.w,
                                              bottom: 0.h,
                                            ),
                                            child: Text(
                                              "S001M00" + logic.memberId,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.bold,),
                                            ),
                                          ),
                                        ]),
                                  ),


                                ],
                              ),
                            ),

                          ],
                        ),
                        Positioned(
                          right: 40.w,
                          top: 80.w,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 0.w,
                                right: 0.w,
                                top: 0.h,
                                bottom: 70.h
                            ),
                            child: GestureDetector(
                              onTap: () {
                                //Navigator.pushNamed(context, UnitRouter.setting);
                                Get.toNamed(AppRoutes.Setting);
                              },
                              child: Container(
                                width: 50.h,
                                height: 50.h,
                                //margin: EdgeInsets.fromLTRB(1.w, 5.h, 5.w, 0.h),
                                child: Lottie.asset(
                                    'assets/packages/lottie_flutter/6547-gear.json'),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0.h,
                              bottom: 20.h,
                              left: 20.w,
                              right: 20.w
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {

                                },
                                child: TopCard(
                                  url: 'assets/images/default/lost.png',
                                  title: '昨日流失',
                                  content: logic.lost,
                                  colorStart: Color(0xff0CDAC5),
                                  colorEnd: Color(0xff3BBFF9),
                                ),
                              ), GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoutes.Fine);
                                },
                                child: TopCard(
                                  url: 'assets/images/default/join.png',
                                  title: '昨日入库',
                                  content: logic.join,
                                  colorStart: Color(0xffF6A681),
                                  colorEnd: Color(0xffF86CA0),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //Navigator.pushNamed(context, UnitRouter.connect);
                                },
                                child: TopCard(
                                  url: 'assets/images/default/connect.png',
                                  title: '昨日沟通',
                                  content: logic.connect,
                                  colorStart: Color(0xff9A7FF6),
                                  colorEnd: Color(0xffEA76EE),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.w),
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Color(0x19000000),
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.5,
                                spreadRadius: 1.5), BoxShadow(
                                color: Colors.white)
                            ],
                          ),
                          margin: EdgeInsets.fromLTRB(30.w, 40.h, 30.w, 0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.w),
                              child: Container(

                                margin: EdgeInsets.fromLTRB(30.w, 0.h, 30.w, 0),

                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
//                交叉轴的布局方式，对于column来说就是水平方向的布局方式
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //就是字child的垂直布局方向，向上还是向下
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    // SizedBox(
                                    //   width: ScreenUtil().setWidth(10.w),
                                    // ),
                                    GestureDetector(
                                        onTap: () {
                                          // Navigator.pushNamed(context, UnitRouter.create_user_page);
                                          Get.toNamed(AppRoutes.CreateUser);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                            //top: 20.h,
                                            // bottom: 15.h,

                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              height: 150.h,
                                              width: 150.w,
                                              alignment: FractionalOffset
                                                  .topLeft,
                                              child: Lottie.asset(
                                                  'assets/packages/lottie_flutter/85263-plus-sky-theme.json'),
                                            ),


                                          ]),
                                        )),


                                    GestureDetector(
                                        onTap: () {
                                          //Navigator.pushNamed(context, UnitRouter.select_page);

                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              height: 150.h,
                                              width: 150.w,
                                              alignment: FractionalOffset
                                                  .topLeft,
                                              child: Lottie.asset(
                                                  'assets/packages/lottie_flutter/98042-robot.json'),
                                            ),

                                          ]),
                                        )),

                                    GestureDetector(
                                        onTap: () {

                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 0.h,
                                            bottom: 0.h,

                                          ),
                                          child: Column(children: <Widget>[
                                            Container(
                                              height: 150.h,
                                              width: 150.w,
                                              alignment: FractionalOffset
                                                  .topLeft,
                                              child: Lottie.asset(
                                                  'assets/packages/lottie_flutter/97568-graph.json'),
                                            ),

                                          ]),
                                        )

                                    ),

                                    GestureDetector(
                                      onTap: () {


                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                          // top: 10.h,
                                          // bottom: 10.h,

                                        ),
                                        child: Column(children: <Widget>[
                                          Container(
                                            height: 150.h,
                                            width: 150.w,
                                            alignment: FractionalOffset.topLeft,
                                            child: Lottie.asset(
                                                'assets/packages/lottie_flutter/97577-instagram.json'),
                                          ),

                                        ]),
                                      ),
                                    ),

                                  ],
                                ),
                              ))),


                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 40.h),
                        child: Column(
                          children: <Widget>[
                            // GestureDetector(
                            //   onTap: () async {
                            //     var ss = await StorageService.to.getString(
                            //         "openid");
                            //     if (ss == "") {
                            //       logic.bindWxOnTap();
                            //     } else {
                            //       _bindWx(context, "");
                            //     }
                            //   },
                            //   child: MenuItem(
                            //     icon: "assets/packages/images/login_wechat.svg",
                            //     title: logic.bind,
                            //   ),
                            // ),
                            Container(
                              color: Colors.white,
                              margin: EdgeInsets.only(top: 0.h),
                              child: Column(
                                children: <Widget>[

                                  GestureDetector(
                                    onTap: () async {
                                      Get.toNamed(AppRoutes.ChangeAccount);
                                    },
                                    child: NewMenuItem(
                                      icon: "assets/images/exchange.png",
                                      title: "账号切换",
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _exit(context);
                                    },
                                    child: NewMenuItem(
                                      icon: "assets/images/logout.png",
                                      title: "退出登录",
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        })
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
  _bindWx(BuildContext context, String img) {
    showDialog(
        context: context,
        builder: (ctx) =>
            Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.w))),
              child: Container(
                width: 50.w,
                child: DeleteCategoryDialog(
                  title: '此账号已绑定微信',
                  content: '是否确定重新绑定?',
                  onSubmit: () {
                    logic.bindWxOnTap();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }
}

class TopCard extends StatelessWidget {
  TopCard(
      {required this.url, required this.title, this.onPressed, required this.content, required this.colorStart, required this.colorEnd});

  final String url;
  final String title;
  final String content;
  final Color colorStart;
  final Color colorEnd;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(8.h)),
          //设置四周边框
          //border:  Border.all(width: 1, color: Colors.red),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              colorStart,
              colorEnd
            ],
          ),
        ),
        child: Container(
          child: Stack(
            children: [
              Container(
                width: 220.w,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.w, top: 20.h, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 0.w, bottom: 5.h),

                            child: Text(title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.sp)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 0.w, bottom: 5.h),
                            child: Text(content,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.sp)),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              Positioned(
                bottom: -16.w,
                right: 10.w,
                //margin: EdgeInsets.only( bottom: 0.h,right: 10.w),
                width: 80.w,
                height: 80.h,
                child: Image.asset(
                    url),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  MenuItem({ required this.icon, required this.title, this.onPressed});

  final String icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 12.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                  ),
                  child: SvgPicture.asset(
                    icon,
                    // color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black87, fontSize: 16.0),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black12,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 13),
            child: Container(),
          )
        ],
      ),
    );
  }
}
class NewMenuItem extends StatelessWidget {
  NewMenuItem({ required this.icon, required this.title, this.onPressed});

  final String icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(
              left: 40.w,
              top: 0.h,
              right: 40.w,
              bottom: 10.h,
            ),
            child: Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(
                    right: 30.w,
                  ),
                  child: Image.asset(
                    icon,
                    width: 90.w,
                    // color: Colors.black54,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.black87, fontSize: 32.sp),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black12,
                )
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 40.w, right: 40.w, top: 26.h),
            child: Container(),
          )
        ],
      ),
    );
  }

}