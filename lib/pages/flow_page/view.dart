import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/routers/names.dart';
import 'package:flutter_ckt/common/widgets/empty_page.dart';
import 'package:flutter_ckt/pages/flow_page/widget/flow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/my_scroll_physics.dart';
import '../../common/widgets/refresh.dart';
import 'logic.dart';

class FlowPage extends StatelessWidget {
  final logic = Get.find<FlowPageLogic>();
  final state = Get.find<FlowPageLogic>().state;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "微信推文";

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
            key: _scaffoldKey,
            appBar: _buildAppBar(context),
            body: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0.h),
                  child: ScrollConfiguration(
                      behavior: DyBehaviorNull(),
                      child: SmartRefresher(
                        physics: const MyScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: DYrefreshHeader(),
                        footer: DYrefreshFooter(),
                        controller: logic.refreshController,
                        onRefresh: logic.onRefresh,
                        onLoading: logic.onLoading,
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: <Widget>[
                            Obx(()=>_buildContent()),
                          ],
                        ),
                      )),
                ),
              ],
            )));
  }

  AppBar? _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 20.w,
      leadingWidth: 0,
      title: Row(
        children: [
          Text(title,
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
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.SearchFlow,arguments:logic.selectItems )?.then((value) {

              logic.onRefresh();
            });
          },
        ),
        SizedBox(width: 20.w),
      ],
      //bottom: bar(),
    );
  }

  Widget _buildContent() {
    return logic.state.wxUser.isNotEmpty
        ? SliverToBoxAdapter(
            child: Center(
            child: Container(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MyFlow(
                    liveData: logic.state.wxUser,
                  )
                ],
              ),
            ),
          ))
        : SliverToBoxAdapter(
            child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 200.h),
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  EmptyPage(),
                  // Icon(Icons.airplay, color: Colors.orangeAccent, size: 300.sp),
                  // Container(
                  //
                  //   child: Text(
                  //     "暂时没有用户了",
                  //     style: TextStyle(
                  //       fontSize: 40.sp,
                  //       color: Colors.orangeAccent,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ));
  }
}
