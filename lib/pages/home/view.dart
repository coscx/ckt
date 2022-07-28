import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/widgets/fine/fine.dart';
import 'package:flutter_ckt/pages/home/widget/app_bar_component.dart';
import 'package:flutter_ckt/pages/home/widget/gzx_filter_goods_page.dart';
import 'package:flutter_ckt/pages/home/widget/photo_widget_list_item.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multiselect_scope/multiselect_scope.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../common/entities/home/common.dart';
import '../../common/routers/names.dart';
import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/my_scroll_physics.dart';
import '../../common/widgets/empty_page.dart';
import '../../common/widgets/refresh.dart';
import '../search/widget/app_search_bar.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();

  final state = Get
      .find<HomeLogic>()
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
        child:
            GetBuilder<HomeLogic>(builder: (logic) {
              return Scaffold(
                  key: logic.scaffoldKey,
                  endDrawer: GZXFilterGoodsPage(
                    selectItems: logic.selectItems,
                  ),
                  // appBar: AppBar(
                  //   titleSpacing: 20.w,
                  //   leadingWidth: 0,
                  //   title: Row(
                  //     children: [
                  //       Text(logic.title,
                  //           style: TextStyle(
                  //               color: Theme.of(context).primaryColor,
                  //               fontSize: 48.sp,
                  //               fontWeight: FontWeight.bold)),
                  //         logic.totalCount == ""
                  //           ? Container()
                  //           : Container(
                  //           padding: EdgeInsets.only(left: 20.w),
                  //             child: Row(
                  //               children: [
                  //                 Text('共:',
                  //                 style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 30.sp,
                  //                     fontWeight: FontWeight.w200)),
                  //                 Text(logic.totalCount,
                  //                     style: TextStyle(
                  //                         color: Colors.redAccent,
                  //                         fontSize: 30.sp,
                  //                         fontWeight: FontWeight.normal))
                  //               ],
                  //             ),
                  //           ),
                  //
                  //     ],
                  //   ),
                  //   //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
                  //   backgroundColor: Colors.white,
                  //   elevation: 0,
                  //   //去掉Appbar底部阴影
                  //   actions: <Widget>[
                  //     IconButton(
                  //       icon: const Icon(
                  //         Icons.search,
                  //         color: Colors.black87,
                  //       ),
                  //       onPressed: () {
                  //         Get.toNamed(AppRoutes.SearchUser,arguments: 0);
                  //       },
                  //     ),
                  //     SizedBox(width: 20.w),
                  //
                  //   ],
                  //
                  //   //bottom: bar(),
                  // ),
                  body: GestureDetector(
                     child:Container(
                      decoration: BoxDecoration(
                        //背景
                        color: const Color.fromRGBO(247, 247, 247, 100),
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(0.h)),
                        //设置四周边框
                        //border: new Border.all(width: 1, color: Colors.red),
                      ),
                      child: Stack(
                        children: <Widget>[
                          //BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground),
                          Container(
                            padding: EdgeInsets.only(top: 80.h),
                            child: ScrollConfiguration(
                                behavior: DyBehaviorNull(),
                                child: SmartRefresher(
                                  physics: const BouncingScrollPhysics(),
                                  enablePullDown: logic.ff ? true :false,
                                  enablePullUp: logic.ff ? true :false,
                                  header: DYrefreshHeader(),
                                  footer: DYrefreshFooter(),
                                  controller: logic.refreshController,
                                  onRefresh: logic.onRefresh,
                                  onLoading: logic.onLoading,
                                  child: CustomScrollView(
                                    controller: logic.scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    slivers: <Widget>[
                                      _buildContent(context),
                                    ],
                                  ),
                                )),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(top: 80.h),
                          //   child: _buildHead(context),
                          // ),
                          // Positioned(
                          //     top: -11.h,
                          //     right: 0,
                          //     child: Container(child: Text("123"),)
                          // ),
                          // Container(
                          //     padding: EdgeInsets.only(top: 30.h),
                          //     child: _buildSliverAppBar()
                          // ),
                          Bar(
                            selectItems: logic.selectItems,
                            roleId: logic.roleId,
                            scaffoldState: logic.scaffoldKey, onItemClick: (data) {
                              logic.ss();
                           },
                          ),
                        ],
                      )
                  ))
              );
            })
    );
  }


  Widget _buildSliverAppBar() {
    return GestureDetector(
      onTap: (){
          Get.toNamed(AppRoutes.Friend);
      },
      child: Container(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: AppSearchBar(isAppoint: 1,)),
    );
  }

  Widget _buildHead(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        SizedBox(
          width: 1.w,
        ),
        SizedBox(
          width: 100.w,
          child: Text(
            "筛选:",
            style: TextStyle(
              fontSize: 32.sp,
              color: Colors.black,
            ),
          ),
        ),
        CupertinoSegmentedControl<int>(
          //unselectedColor: Colors.yellow,
          //selectedColor: Colors.green,
          //pressedColor: Colors.blue,
          //borderColor: Colors.red,
          groupValue: logic.sex == 0 ? 1 : logic.sex,
          onValueChanged: _onValueChanged,
          padding: EdgeInsets.only(right: 0.w),
          children: {
            1: logic.sex == 1
                ? Padding(
              padding: EdgeInsets.only(left: 50.w, right: 40.w),
              child: Text("男",
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                  )),
            )
                : Text("男",
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.blue,
                )),
            2: logic.sex == 2
                ? Padding(
              padding: EdgeInsets.only(left: 50.w, right: 40.w),
              child: Text("女",
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.white,
                  )),
            )
                : Text("女",
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.blue,
                )),
          },
        ),
        buildHeadTxt(context),
        PopupMenuButton<String>(
          itemBuilder: (context) => buildItems(),
          padding: EdgeInsets.only(right: 0.w),
          offset: Offset(-15.w, 70.h),
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.w),
                bottomRight: Radius.circular(20.w),
                topRight: Radius.circular(5.w),
                bottomLeft: Radius.circular(20.w),
              )),
          onSelected: (e) async {
            //print(e);
            var ccMode = 0;
            if (e == '全部') {
              logic.currentPhotoMode = 0;
              ccMode = 10;
            }
            if (e == '我的') {
              logic.currentPhotoMode = 2;
              ccMode = 2;
            }
            if (e == '良缘') {
              logic.currentPhotoMode = 1;
              ccMode = 1;
            }
            if (e == '公海') {
              logic.currentPhotoMode = 3;
              ccMode = 3;
            }


            logic.roleId = ccMode;
            logic.onRefresh();
          },
          onCanceled: () => debugPrint('onCanceled'),
        )
      ],
    );
  }

  void _onValueChanged(int value) {
    logic.sex = value;
    logic.onSexChange();
  }

  List<PopupMenuItem<String>> buildItems() {
    final map = {
      "全部": Icons.margin,
      "我的": Icons.person_outline,
      "良缘": Icons.wc,
      "公海": Icons.album_outlined,
    };
    return map.keys
        .toList()
        .map((e) =>
        PopupMenuItem<String>(
            value: e,
            child: Row(
              //spacing: 10.w,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.blue,
                ),
                Text(e),
              ],
            )))
        .toList();
  }

  Widget buildHeadTxt(BuildContext context) {
    if (logic.currentPhotoMode == 0) {
      return SizedBox(
        width: 70.w,
        child: Text("全部", style: TextStyle(
          fontSize: 30.sp,
          color: Colors.black,
        )),
      );
    }
    if (logic.currentPhotoMode == 2) {
      return SizedBox(
        width: 70.w,
        child: Text("我的", style: TextStyle(
          fontSize: 30.sp,
          color: Colors.black,
        )),
      );
    }
    if (logic.currentPhotoMode == 1) {
      return SizedBox(
        width: 70.w,
        child: Text("良缘", style: TextStyle(
          fontSize: 30.sp,
          color: Colors.black,
        )),
      );
    }
    if (logic.currentPhotoMode == 3) {
      return SizedBox(
        width: 70.w,
        child: Text("公海", style: TextStyle(
          fontSize: 30.sp,
          color: Colors.black,
        )),
      );
    }
    return SizedBox(
      width: 70.w,
      child: Text("全部", style: TextStyle(
        fontSize: 30.sp,
        color: Colors.black,
      )),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (logic.state.homeUser.isEmpty)
      return SliverToBoxAdapter(child: EmptyPage());
    return logic.state.homeUser.isNotEmpty
        ? SliverList(
          delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                return PhotoWidgetListItem(
                  photo: logic.state.homeUser[index],
                  isSelect: logic.getSelectCheckbox(index),
                  onChange: (bool d,int index,int position) {
                    logic.setSelectCheckbox(d,index,position);
                  }, index: index, allSelect: logic.allSelect,);
              },
              childCount: logic.state.homeUser.length),
        )
        : SliverToBoxAdapter(
        child: Center(
          child: Container(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.airplay,
                    color: Colors.orangeAccent, size: 200.sp),
                Container(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Text(
                    "暂时没有用户了",
                    style: TextStyle(
                      fontSize: 40.sp,
                      color: Colors.orangeAccent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  List<GestureDetector> _buildMyItem() {
    if (logic.loanData.isEmpty){
      return [GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.FineDetail);
        },
        child: EmptyPage(),
      )];
    }
    return logic.loanData
        .map((e) => GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.FineDetail,arguments: e.loanId);
      },
      child: FineContent(
        icon: getStatus(e).icon,
        name: getStatus(e).name,
        money: getStatus(e).money,
        count: getStatus(e).count,
        status: getStatus(e).status,
        time: getStatus(e).time,
        color: getStatus(e).color,
      ),
    ))
        .toList();
  }
}

class Bar extends StatelessWidget implements PreferredSizeWidget {
  final List<SelectItem> selectItems;
  final int roleId;
  final GlobalKey<ScaffoldState> scaffoldState;
  final Function(dynamic) onItemClick;
  const Bar({Key? key,
    required this.selectItems,
    required this.roleId,
    required this.scaffoldState, required this.onItemClick,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(580.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
      child: Column(
        children: [
          Expanded(
              child: AppBarComponent(
                selectItems: selectItems,
                state: scaffoldState,
                mode: roleId, onItemClick: (data) { onItemClick(data); },
              )),
        ],
      ),
    );
  }
}
