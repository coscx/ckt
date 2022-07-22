import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/pages/home/view.dart';
import 'package:flutter_ckt/pages/other/fine/view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../home/logic.dart';


class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with
        AutomaticKeepAliveClientMixin<DiscoveryPage>,
        SingleTickerProviderStateMixin {
  bool selected =false;
  late TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var pageList = [];
  String title ="选择";
  @override
  void initState() {
    super.initState();
     pageList = [
      HomePage(),
      FinePage(),
    ];
    _tabController = TabController(initialIndex: 0, vsync: this, length: pageList.length);

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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.transparent,
                child: TabBar(
                  labelColor: Color(0xFF0a0f1e),
                  indicatorColor: Color(0xffFF7E98),
                  tabs: <Widget>[
                    Tab(text: "全部客户"),
                    Tab(text: "我的客户"),
                  ],
                  controller: _tabController,
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.only(left: 10, right: 10),
                  labelPadding: EdgeInsets.symmetric(horizontal: 8),
                  isScrollable: true,
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Color(0xffFF7E98),
                    fontWeight: FontWeight.w800,
                  ),
                  unselectedLabelColor: Color(0xff999999),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 14, color: Color(0xff999999)),
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    _pageController.jumpToPage(index);
                  },
                ),
              )),
             GestureDetector(
               onTap: (){
                setState((){
                  selected =!selected;
                  selected ?title ="取消" : title ="选择";
                  bool gg =Get.isRegistered<HomeLogic>();
                  if (gg){
                    var peerChatLogic = Get.find<HomeLogic>();
                    peerChatLogic.setAllSelect(selected);
                  }
                });
               },
               child: Container(
                 padding: EdgeInsets.only(right: 40),
                   child: Text(title,style: TextStyle(fontSize: 18),)),
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