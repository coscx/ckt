import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/friend/view.dart';
import 'package:flutter_ckt/pages/home/view.dart';
import 'package:flutter_ckt/pages/other/fine/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/services/storage.dart';
import '../../home/logic.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with
        AutomaticKeepAliveClientMixin<DiscoveryPage>,
        SingleTickerProviderStateMixin {
  bool selected = false;
  late TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var pageList = [];
  String title = "选择";
  var subPage =[];
  @override
  void initState() {
    super.initState();
      String  roleKey = StorageService.to.getString("roleKey");
      if(roleKey =="super"){
        pageList = [
          HomePage(),
          FinePage(),
        ];
        subPage =["全部客户","我的客户"];
      }
     else  if(roleKey =="salesman"){
        pageList = [
          FinePage(),
        ];
        subPage =["我的客户"];
      }
      else  if(roleKey =="director"){
        pageList = [
          HomePage(),
          FinePage(),
          FriendPage(),
        ];
        subPage =["全部客户","我的客户","客户放弃"];
      }
      else if(roleKey =="administration"){
      pageList = [
        HomePage(),
        FinePage(),
      ];
      subPage =["我的客户","审批管理"];
    } else{
        pageList = [
          FinePage(),
        ];
        subPage =["我的客户"];
    }
    _tabController =
        TabController(initialIndex: 0, vsync: this, length: pageList.length);
  }

  _onPageChange(int index) async {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

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
            backgroundColor: Colors.transparent,
            appBar: DarkAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    color: Colors.transparent,
                    child: TabBar(
                      labelColor: Color(0xFF0a0f1e),
                      indicatorColor: Color(0xffFF7E98),
                      tabs: List.generate(subPage.length, (index) {
                        var str = subPage[index];

                        var tp = TextPainter(
                            textDirection: TextDirection.ltr,
                            text: TextSpan(
                                text: str,
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w800,
                                )))
                          ..layout();
                        return Tab(
                          // text和child 2选一这里要控制条目尺寸选着使用child
                          // tab下的文字style 默认会使用DefultTextStyle包裹 所有这里面的Text可以不用再声明style 切换也会自带文字缩放
                          // text: str,
                          child: Container(width: tp.width+10, child: Text(str)),
                        );
                      }),
                      controller: _tabController,
                      indicatorWeight: 3,
                      indicatorPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                      labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontSize: 34.sp,
                        color: Color(0xffFF7E98),
                        fontWeight: FontWeight.w800,
                      ),
                      unselectedLabelColor: Color(0xff999999),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 30.sp, color: Color(0xff999999)),
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: (index) {
                        _pageController.jumpToPage(index);
                      },
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = !selected;
                        selected ? title = "取消" : title = "选择";
                        bool gg = Get.isRegistered<HomeLogic>();
                        if (gg) {
                          var peerChatLogic = Get.find<HomeLogic>();
                          peerChatLogic.setAllSelect(selected);
                        }
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ]),
                Expanded(
                  child: PageView.builder(
                      key: const Key('pageView'),
                      itemCount: pageList.length,
                      onPageChanged: _onPageChange,
                      controller: _pageController,
                      itemBuilder: (_, index) => pageList[index]),
                )
              ],
            )));
  }
}

class DarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        child: Scaffold(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0.0);
}
