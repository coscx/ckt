import 'package:badges/badges.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/conversion/widget/date.dart';
import 'package:flutter_ckt/pages/conversion/widget/dialog_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/pop_menu.dart';
import 'logic.dart';
class ConversionPage extends StatelessWidget {
  final logic = Get.find<ConversionLogic>();
  final state = Get.find<ConversionLogic>().state;


  @override
  Widget build(BuildContext context) {
    logic.init();
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light, // Status bar
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 20.w,
            leadingWidth: 0,
            title: Row(
              children: [
                Text("消息",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
            backgroundColor: Colors.white,
            elevation: 0,
            //去掉Appbar底部阴影
            //去掉Appbar底部阴影

            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.w, 10.h, 20.w, 0.h),
                //height: 20.h,
                //width: 20.w,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.add_circle_outline,
                    size: 48.sp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, UnitRouter.user);
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                  height: 195.h,
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0x08000000),
                          offset: const Offset(0.5, 0.5),
                          blurRadius: 1.5.w,
                          spreadRadius: 1.5.w),
                      const BoxShadow(color: Colors.white)
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0.h),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
//                交叉轴的布局方式，对于column来说就是水平方向的布局方式
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //就是字child的垂直布局方向，向上还是向下
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 35.h,
                              bottom: 15.h,
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(90),
                                width: ScreenUtil().setWidth(90),
                                alignment: FractionalOffset.topLeft,
                                child: Image.asset(
                                    "assets/packages/images/ic_chat_match.webp"),
                              ),
                              Text(
                                "心动速配",
                                style:  TextStyle(
                                    color: Colors.black54, fontSize: 26.sp),
                              ),
                            ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 35.h,
                              bottom: 15.h,
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(90),
                                width: ScreenUtil().setWidth(90),
                                alignment: FractionalOffset.topLeft,
                                child: Image.asset(
                                    "assets/packages/images/ic_moment_notice.webp"),
                              ),
                              Text(
                                "互动消息",
                                style:  TextStyle(
                                    color: Colors.black54, fontSize: 26.sp),
                              ),
                            ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 35.h,
                              bottom: 15.h,
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(90),
                                width: ScreenUtil().setWidth(90),
                                alignment: FractionalOffset.topLeft,
                                child: Image.asset(
                                    "assets/packages/images/ic_visitor.webp"),
                              ),
                              Text(
                                "访客记录",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 26.sp),
                              ),
                            ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 35.h,
                              bottom: 15.h,
                            ),
                            child: Column(children: <Widget>[
                              Container(
                                height: ScreenUtil().setHeight(90),
                                width: ScreenUtil().setWidth(90),
                                alignment: FractionalOffset.topLeft,
                                child: Image.asset(
                                    "assets/packages/images/ic_playing.webp"),
                              ),
                              Text(
                                "好友在玩",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 26.sp),
                              ),
                            ]),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                        ],
                      ))),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: imRefreshHeader(),
                    controller: logic.refreshController,
                    onRefresh: logic.onRefresh,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      color: Colors.white,
                      child: Obx(()=>_buildContent(context)),
                    )),
              ),
            ],
          ),
        ));
  }
  Widget imRefreshHeader() {
    return const ClassicHeader(
      refreshingText: "加载中...",
      idleText: "加载最新会话",
      completeText: '加载完成',
      releaseText: '松开刷新数据',
      failedIcon: null,
      failedText: '刷新失败，请重试。',
    );
  }
  Widget _buildContent(BuildContext context) {
    return ScrollConfiguration(
      behavior: DyBehaviorNull(),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.conversion.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () async {
                 logic.onTap(logic.state.conversion[index]);
                },
                child: _buildListItem(
                    context, state.conversion[index], state.conversion[index].cid!));
          }),
    );
  }
  Widget _buildListItem(
      BuildContext context, Conversion conversation, String cid) {
    return PopupMenu(
        callback: (value) {
          DialogUtil.showBaseDialog(context, '即将删除该对话的全部聊天记录',
              right: '删除', left: '再想想', rightClick: (res) {
                logic.onTapDeleteConversion(cid);
              });
        },
        user: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 15.h, left: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  conversation.newMsgCount == 0
                      ? Container(
                    margin: EdgeInsets.only(left: 20.w, top: 7.h),
                    padding: EdgeInsets.all(10.w),
                    height: 92.h,
                    width: 92.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(46.w),
                      // image url 去要到自己的服务器上去请求回来再赋值，这里使用一张默认值即可
                      image: DecorationImage(
                          image: conversation.type ==
                              ConversionType.CONVERSATION_PEER
                              ? Image.asset(
                              "assets/packages/images/chat_hi.png")
                              .image
                              : Image.asset(
                              "assets/packages/images/chat_notice.png")
                              .image),
                    ),
                  )
                      : Badge(
                    badgeContent: Text(
                      '${conversation.newMsgCount}',
                      style:
                      TextStyle(color: Colors.white, fontSize: 26.sp),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w, top: 7.h),
                      padding: EdgeInsets.all(10.w),
                      height: 92.h,
                      width: 92.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(46.w),
                        // image url 去要到自己的服务器上去请求回来再赋值，这里使用一张默认值即可
                        image: DecorationImage(
                            image: conversation.type ==
                                ConversionType.CONVERSATION_PEER
                                ? Image.asset(
                                "assets/packages/images/chat_hi.png")
                                .image
                                : Image.asset(
                                "assets/packages/images/chat_notice.png")
                                .image),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16.w, top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxWidth: 260.w),
                          margin: EdgeInsets.only(top: 2.w, left: 10.w),
                          child: Text(
                            conversation.type ==
                                ConversionType.CONVERSATION_PEER
                                ? conversation.cid!
                                : conversation.cid! + "群",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 30.sp),
                          ),
                        ),
                        conversation.type == ConversionType.CONVERSATION_PEER
                            ? Container(
                          constraints: BoxConstraints(maxWidth: 0.6.sw),
                          margin: EdgeInsets.only(top: 8.w),
                          child: Text(
                              (conversation.message?.type ==
                                  MessageType.MESSAGE_REVOKE
                                  ? (conversation.message!.sender ==
                                  logic.memberId
                                  ? "你撤回了一条消息"
                                  : conversation.message!.sender+
                                  "撤回了一条消息")
                                  : (conversation.detail!.contains(
                                  'assets/images/face') ||
                                  conversation.detail!.contains(
                                      'assets/images/figure'))
                                  ? '[表情消息]'
                                  : conversation.detail!),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 30.sp)),
                        )
                            : Container(
                          constraints: BoxConstraints(maxWidth: 0.6.sw),
                          margin: EdgeInsets.only(top: 8.w),
                          child: Text(
                              (conversation.message?.type ==
                                  MessageType.MESSAGE_REVOKE
                                  ? (conversation.message!.sender ==
                                  logic.memberId
                                  ? "你撤回了一条消息"
                                  : conversation.message!.sender +
                                  "撤回了一条消息")
                                  : (conversation.message!.sender +
                                  ":" +
                                  ((conversation.detail!.contains(
                                      'assets/images/face') ||
                                      conversation.detail!.contains(
                                          'assets/images/figure'))
                                      ? '[表情消息]'
                                      : conversation.detail!))),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 30.sp)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 14.w, bottom: 18.h, top: 14.h),
                child: Text(
                    tranImTime(tranFormatTime(conversation.message!.timestamp)),
                    style: TextStyle(color: Colors.grey, fontSize: 30.sp)),
              )
            ],
          ),
        ));
  }
}
