import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/widgets/fine/fine.dart';
import 'package:flutter_ckt/pages/lost_user/widget/loat_app_bar_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../common/entities/home/common.dart';
import '../../common/widgets/dy_behavior_null.dart';
import '../../common/widgets/empty_page.dart';
import '../../common/widgets/refresh.dart';
import 'logic.dart';

class LostPage extends StatelessWidget {
  final logic = Get.find<LostLogic>();
  final state = Get.find<LostLogic>().state;

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
        child: GetBuilder<LostLogic>(builder: (logic) {
          return Scaffold(
              key: logic.scaffoldKey,
              body: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: <Widget>[
                          //BlocBuilder<GlobalBloc, GlobalState>(builder: _buildBackground),
                          Container(
                            padding: EdgeInsets.only(top: 0.h),
                            child: ScrollConfiguration(
                                behavior: DyBehaviorNull(),
                                child: SmartRefresher(
                                  physics: const BouncingScrollPhysics(),
                                  enablePullDown: logic.ff ? true : false,
                                  enablePullUp: logic.ff ? true : false,
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
                          //   padding: EdgeInsets.only(top: 20.h),
                          //   child: _buildHead(context),
                          // ),
                          // Bar(
                          //   selectItems: logic.selectItems,
                          //   onItemClick: (data) {
                          //   logic.openSelect(data);
                          // },
                          // ),
                        ],
                      ))));
        }));
  }

  Widget _buildHead(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
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
                    padding: EdgeInsets.only(
                        left: 50.w, right: 40.w, top: 10.h, bottom: 10.h),
                    child: Text("未划分用户",
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                        )),
                  )
                : Text("未划分用户",
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.blue,
                    )),
            2: logic.sex == 2
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 50.w, right: 40.w, top: 10.h, bottom: 10.h),
                    child: Text("已划分用户",
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                        )),
                  )
                : Text("已划分用户",
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.blue,
                    )),
          },
        ),
      ],
    );
  }

  void _onValueChanged(int value) {
    logic.sex = value;
    logic.onSexChange();
  }

  Widget _buildContent(BuildContext context) {
    if (logic.loanData.isEmpty) return SliverToBoxAdapter(child: EmptyPage());
    return logic.loanData.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              var e = logic.loanData[index];
              return FineContent(
                icon: getStatus(e).icon,
                name: getStatus(e).name,
                money: getStatus(e).money,
                count: getStatus(e).count,
                status: getStatus(e).status,
                time: getStatus(e).time,
                color: getStatus(e).color,
                isSelect: logic.getSelectCheckbox(index),
                onChange: (bool d, int index, int position) {
                  logic.setSelectCheckbox(d, index, position);
                },
                index: index,
                allSelect: logic.allSelect,
                id: e.loanid,
              );
            }, childCount: logic.loanData.length),
          )
        : SliverToBoxAdapter(
            child: Center(
            child: Container(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.airplay, color: Colors.orangeAccent, size: 200.sp),
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
}

class Bar extends StatelessWidget implements PreferredSizeWidget {
  final List<SelectItem> selectItems;
  final Function(dynamic) onItemClick;

  const Bar({
    Key? key,
    required this.selectItems,
    required this.onItemClick,
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
              child: LostAppBarComponent(
            selectItems: selectItems,
            onItemClick: (data) {
              onItemClick(data);
            },
          )),
        ],
      ),
    );
  }
}
