import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/style/toly_icon.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../../common/widgets/delete_category_dialog.dart';
import '../../../common/widgets/toast.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();
  final state = Get
      .find<LoginLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(builder: (logic) {
      return Scaffold(
          body: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: SingleChildScrollView(
                child: Wrap(children: [
                  arcBackground(),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildLoginByState(context),
                        ],
                      ))
                ]),
              ))

      );
    });
  }

  Widget arcBackground() {
    return ArcBackground(
      image: const AssetImage("assets/images/background.webp"),
      child: Padding(
        padding: EdgeInsets.all(100.w),
        child: Container(
          height: 280.h,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
                color: Colors.white.withAlpha(0), shape: BoxShape.rectangle),
            child: Container()
        ),
      ),
    );
  }

  Widget _buildLoginByState(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(
              //   "ERP系统登录",
              //   style: TextStyle(fontSize: 40.sp),
              // ),
              SizedBox(
                height: 10.h,
              ),
              // Text(
              //   "登录",
              //   style: TextStyle(color: Colors.grey),
              // ),
              SizedBox(
                height: 10.h,
              ),
              buildUsernameInput(),
              Stack(
                alignment: const Alignment(0.8, 0),
                children: [
                  buildPasswordInput(),
                  GestureDetector(
                      onTap: () {
                        logic.showPwd = !logic.showPwd;
                        logic.update();
                      },
                      child: Icon(logic.showPwd
                          ? TolyIcon.icon_show
                          : TolyIcon.icon_hide))
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: logic.autoLogin,
                      //shape: CircleBorder(),//这里就是实现圆形的设置
                      onChanged: (e) {
                        logic.autoLogin = !logic.autoLogin;
                        logic.update();
                      }),
                  Text(
                    "自动登录",
                    style: TextStyle(
                        color: const Color(0xff444444), fontSize: 30.sp),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        _register(context);
                      },
                      child: Text(
                        "如何注册?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25.sp,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
              _buildBtn(context),
               Obx(() {
                return logic.showWx.value ?buildOtherLogin(): Container();
              }) ,
              //const CircularProgressIndicator()
              Container(
                padding:
                EdgeInsets.only(left: 20.w, right: 0.w, top: 100.h),
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: logic.privacy,
                        shape: const CircleBorder(),//这里就是实现圆形的设置
                        onChanged: (e) {
                          logic.privacy = !logic.privacy;
                          logic.update();
                        }),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  text: TextSpan(
                      text: "登录即代表同意",
                      style: TextStyle(color: Colors.grey[600]),
                      children: [
                        TextSpan(
                          text: "《用户协议》",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: logic.registProtocolRecognizer
                            ..onTap = () {
                              //打开用户协议
                              logic.openUserProtocol(context);
                            },
                        ),
                        TextSpan(
                          text: "与",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextSpan(
                          text: "《隐私政策》",
                          style: const TextStyle(color: Colors.blue),
                          recognizer: logic.privacyProtocolRecognizer
                            ..onTap = () {
                              //打开用户协议
                              logic.openPrivateProtocol(context);
                            },
                        ),

                      ]),
                )

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _register(BuildContext context) {
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
                  title: '注册功能暂未开放',
                  content: '请联系主管申请账号',
                  onSubmit: () {
                    //BlocProvider.of<HomeBloc>(context).add(EventResetCheckUser(photo,1));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ));
  }

  Widget _buildBtn(BuildContext context) =>
      Container(
        margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 0),
        height: 80.h,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.w))),
          color: Colors.blue,
          onPressed: () {
            if (!logic.privacy) {
              toastInfo(msg: '请勾选同意用户协议与隐私政策');
              return;
            }
            if (logic.usernameController.text.isEmpty) {
              toastInfo(msg: '请输入账号');
              return;
            }
            if (logic.passwordController.text.isEmpty) {
              toastInfo(msg: '请输入密码');
              return;
            }


            logic.textFieldNode.unfocus();
            logic.login(
                logic.usernameController.text, logic.passwordController.text);
          },
          child: Text("登   录",
              style: TextStyle(color: Colors.white, fontSize: 30.sp)),
        ),
      );

  Widget buildUsernameInput() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 20.h,
                width: 1.w,
                color: Colors.grey.withOpacity(0.5),
                margin: EdgeInsets.only(left: 00.0, right: 10.w),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.black,
                  ),
                  controller: logic.usernameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入用户名...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30.sp),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildPasswordInput() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(30.w),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.h,
                width: 1.w,
                color: Colors.grey.withOpacity(0.5),
                margin: EdgeInsets.only(left: 00.0, right: 10.w),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    fontSize: 35.sp,
                    color: Colors.black,
                  ),
                  focusNode: logic.textFieldNode,
                  obscureText: !logic.showPwd,
                  controller: logic.passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入密码...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30.sp),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildOtherLogin() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!logic.privacy) {
              toastInfo(msg: '请勾选同意用户协议与隐私政策');
              return;
            }
            logic.wxLogin();
          },
          child: SvgPicture.asset(
            "assets/packages/images/login_wechat.svg",
            //color: Colors.green,
          ),
        ),

      ],
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
      clipper: ArcClipper(),
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

class ArcClipper extends CustomClipper<Path> {
  final double factor;

  ArcClipper({this.factor = 0.618});

  @override
  Path getClip(Size size) =>
      Path()
        ..moveTo(0, 0)
        ..relativeLineTo(size.width, 0)..relativeLineTo(0, 0.8 * size.height)
        ..arcToPoint(
          Offset(0.0, size.height * 0.618),
          radius: const Radius.elliptical(50.0, 10.0),
          rotation: 0.0,
        )
        ..close();

  @override
  bool shouldReclip(ArcClipper oldClipper) => factor != oldClipper.factor;
}
