import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:badges/badges.dart';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/conversion/widget/date.dart';
import 'package:flutter_ckt/pages/conversion/widget/dialog_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/routers/names.dart';
import '../../../common/widgets/delete_category_dialog.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import 'logic.dart';

class PersonPage extends StatelessWidget {
  final logic = Get.find<PersonLogic>();
  final state = Get.find<PersonLogic>().state;

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
              SizedBox(
                width: 20.h,
              ),
            ],
          ),
          body: Column(
            children: <Widget>[

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
                      child: _buildContent(context),
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
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () async {

                },
                child: _buildListItem(context,index));
          }),
    );
  }

  Widget _buildListItem(
      BuildContext context,  int index) {
    return  GestureDetector(
        onTap: (){
          index ==
              0
              ? Get.toNamed(AppRoutes.Follow):Get.toNamed(AppRoutes.Public);
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 15.h, left: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.w, top: 7.h),
                    padding: EdgeInsets.all(10.w),
                    height: 92.h,
                    width: 92.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(46.w),
                      // image url 去要到自己的服务器上去请求回来再赋值，这里使用一张默认值即可
                      image: DecorationImage(
                          image: index ==
                              0
                              ? Image.asset(
                              "assets/images/event.png")
                              .image
                              : Image.asset(
                              "assets/images/follow.png")
                              .image),
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
                            index ==
                                0
                                ? "跟进通知":"掉落公海通知",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 30.sp),
                          ),
                        ),
                       Container(
                          constraints: BoxConstraints(maxWidth: 0.6.sw),
                          margin: EdgeInsets.only(top: 8.w),
                          child: Text(
                              index ==
                                  0
                                  ? "暂无通知":"暂无通知",
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

            ],
          ),
        )
    );
  }

}
