import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/entities/home/search_erp.dart';
import 'package:flutter_ckt/pages/search/widget/photo_widget_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../../common/widgets/my_scroll_physics.dart';
import '../../../common/widgets/refresh.dart';
import '../logic.dart';
import 'app_search_bar.dart';

class SearchPages extends StatefulWidget {
  final List<Data> photos;
  final int isAppoint;
  const SearchPages({Key? key, required this.photos, required this.isAppoint}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPages> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  final logic = Get.find<SearchLogic>();
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
          backgroundColor: Colors.white,
          key: _scaffoldkey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            //去掉Appbar底部阴影
            leadingWidth: 150.w,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Container(
                padding: EdgeInsets.only(left: 0.w, top: 0.w, bottom: 0),
                child: Text("用户搜索",
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 45.sp,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ))),
          ),
          body: WillPopScope(
            onWillPop: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              return true;
            },
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 0.w, top: 120.w, bottom: 0),
                  child: ScrollConfiguration(
                      behavior: DyBehaviorNull(),
                      child: SmartRefresher(
                          physics: const MyScrollPhysics(),
                          enablePullDown: false,
                          enablePullUp: true,
                          header: DYrefreshHeader(),
                          footer: DYrefreshFooter(),
                          controller: logic.refreshController,
                          onLoading: logic.onLoading,
                          child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                // 触摸收起键盘
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              child: Container(
                                color: Colors.white,
                                child: CustomScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  slivers: <Widget>[

                                    _buildBodyByState(context)
                                  ],
                                ),
                              )))),
                ),
                _buildSliverAppBar(),
              ],
            ),
          ),
        ));
  }

  Widget _buildSliverAppBar() {
    return Container(
        padding: EdgeInsets.only(left: 40.w, right: 40.w), child: AppSearchBar(isAppoint: widget.isAppoint,));
  }

  Widget _buildBodyByState(BuildContext context) {
    return _buildSliverList(widget.photos);
  }

  Widget _buildSliverList(List<Data> photos) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (_, int index) => Container(
                  child: GestureDetector(
                      child: PhotoSearchWidgetListItem(
                photo: photos[index],
                        isAppoint: widget.isAppoint,
              ))),
          childCount: photos.length),
    );
  }
}
