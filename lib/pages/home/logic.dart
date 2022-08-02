import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/entities/loan/loan.dart';
import 'package:flutter_ckt/common/entities/loan/saleman.dart';
import 'package:flutter_ckt/pages/home/widget/home_filter_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/apis/common.dart';
import '../../common/entities/home/common.dart';
import '../../common/services/storage.dart';
import '../../common/widgets/flutter_custom_select/utils/enum.dart';
import '../../common/widgets/flutter_custom_select/widget/flutter_custom_selector_sheet.dart';
import '../select_result/widget/select_result_page.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();
  List<SaleManDataData> loanData = <SaleManDataData>[];
  final List<SelectItem> selectItems = <SelectItem>[];
  final Map<String, bool> items = Map();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  String serveType = "1";
  String totalCount = "";
  String title = "客户管理";
  int curPage = 1;
  int pageSize = 20;
  int total = 20;
  int roleId = 0;
  int currentPhotoMode = 0;
  int sex = 1;
  double topDistance = 0;
  bool ff = true;
  bool allSelect = false;
  int groupValue = -1;

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  // 下拉刷新
  void _loadData() async {
    curPage = 1;
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var d = await CommonAPI.getSuperAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "director") {
      var d = await CommonAPI.getManageAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "salesman") {
      var d = await CommonAPI.getSaleManMyUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "administration") {
      var d = await CommonAPI.getAdministrativeMyUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    }else {
      var d = await CommonAPI.getSuperAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    }
    update();
  }

  // 下拉刷新
  void onRefresh() async {
    curPage = 1;
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var d = await CommonAPI.getSuperAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "director") {
      var d = await CommonAPI.getManageAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "salesman") {
      var d = await CommonAPI.getSaleManMyUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    } else if (roleKey == "administration") {
      var d = await CommonAPI.getAdministrativeMyUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    }  else {
      var d = await CommonAPI.getSuperAllUserList(getFilter({}));
      if (d.data != null && d.data?.data != null) {
        loanData = d.data!.data!;
      }
    }
    refreshController.resetNoData();
    refreshController.refreshCompleted();
    update();
  }

  // 下拉刷新
  void onSexChange() async {}

  // 上拉加载
  void onLoading() async {
    curPage++;
    int p = 0;
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var d =
          await CommonAPI.getSuperAllUserList(getFilter({"pageNum": curPage}));
      if (d.data != null && d.data?.data != null) {
        loanData.addAll(d.data!.data!);
        p = d.data!.total;
        if (p > 0) {
          double currentPage = p / 15;
          if (curPage > currentPage.ceil()) {
            refreshController.loadNoData();
            return;
          }
        }
      }
    } else if (roleKey == "director") {
      var d =
          await CommonAPI.getManageAllUserList(getFilter({"pageNum": curPage}));
      if (d.data != null && d.data?.data != null) {
        loanData.addAll(d.data!.data!);
        p = d.data!.total;
        if (p > 0) {
          double currentPage = p / 15;
          if (curPage > currentPage.ceil()) {
            refreshController.loadNoData();
            return;
          }
        }
      }
    } else if (roleKey == "salesman") {
      var d =
          await CommonAPI.getSaleManMyUserList(getFilter({"pageNum": curPage}));
      if (d.data != null && d.data?.data != null) {
        loanData.addAll(d.data!.data!);
        p = d.data!.total;
        if (p > 0) {
          double currentPage = p / 15;
          if (curPage > currentPage.ceil()) {
            refreshController.loadNoData();
            return;
          }
        }
      }
    } else if (roleKey == "administration") {
      var d =
      await CommonAPI.getAdministrativeMyUserList(getFilter({"pageNum": curPage}));
      if (d.data != null && d.data?.data != null) {
        loanData.addAll(d.data!.data!);
        p = d.data!.total;
        if (p > 0) {
          double currentPage = p / 15;
          if (curPage > currentPage.ceil()) {
            refreshController.loadNoData();
            return;
          }
        }
      }
    }else {
      var d =
          await CommonAPI.getSuperAllUserList(getFilter({"pageNum": curPage}));
      if (d.data != null && d.data?.data != null) {
        loanData.addAll(d.data!.data!);
        p = d.data!.total;
        if (p > 0) {
          double currentPage = p / 15;
          if (curPage > currentPage.ceil()) {
            refreshController.loadNoData();
            return;
          }
        }
      }
    }
    refreshController.loadComplete();
    update();
  }

  Map<String, dynamic> getFilter(Map<String, dynamic>? m) {
    Map<String, dynamic> data = Map();
    if (m != null) {
      data.addAll(m);
    }
    List<String> steps = <String>[];
    selectItems.map((e) {
      if (e.type == 5) {
        data['beginCreditTime'] = e.id;
      }
      if (e.type == 6) {
        data['endCreditTime'] = e.id;
      }
      if (e.type == 7) {
        data['beginCreateTime'] = e.id;
      }
      if (e.type == 8) {
        data['endCreateTime'] = e.id;
      }
      if (e.type == 9) {
        data['curUserId'] = e.id; //所属员工
      }
      if (e.type == 10) {
        data['bindUserId'] = e.id; //当前员工
      }
      if (e.type == 11) {
        data['cnId'] = e.id;
      }
      if (e.type == 99) {
        steps.add(e.id!);
      }
    }).toList();
    if (steps.isNotEmpty) {
      data['steps'] = steps.join(",");
    }
    return data;
  }

  getListItemString(List<Data> users) {}

  setDistance(double d) {
    topDistance += d;
    print(topDistance);
  }

  openSelect(int data) {
    if(data==0){
      majorWindow();
    }
    if (data == 1) {
      channelWindow();
    }
    if (data == 2) {
      currentWindow();
    }
    if (data == 3) {
      majorWindow();
    }
  }

  channelWindow() {
    var id;
    for (int i = 0; i < selectItems.length; i++) {
      if (selectItems[i].type == 11) {
        id = selectItems[i].id;
        break;
      }
    }
    showCupertinoModalBottomSheet(
      expand: false,
      bounce: false,
      context: Get.context!,
      duration: const Duration(milliseconds: 200),
      backgroundColor: Colors.white,
      builder: (context) => SelectPage(
        type: 3,
        onResendClick: (data) {
          print(data);
          int j = 0;
          for (int i = 0; i < selectItems.length; i++) {
            if (selectItems[i].type == 11) {
              j = 1;
              selectItems[i].id = data['id'].toString();
              selectItems[i].name = data['name'];
              break;
            }
          }

          if (j == 0) {
            SelectItem s = SelectItem();
            s.type = 11;
            s.name = data['name'];
            s.id = data['id'].toString();
            selectItems.add(s);
          }
          onRefresh();
          update();
        },
        onHide: (data) {
          selectItems.removeWhere((e) => e.type==11);
          onRefresh();
        },
        selectId: id,
      ),
    );
  }

  currentWindow() {
    var id;
    for (int i = 0; i < selectItems.length; i++) {
      if (selectItems[i].type == 10) {
        id = selectItems[i].id;
        break;
      }
    }
    showCupertinoModalBottomSheet(
      expand: false,
      bounce: false,
      context: Get.context!,
      duration: const Duration(milliseconds: 200),
      backgroundColor: Colors.white,
      builder: (context) => SelectPage(
        type: 2,
        onResendClick: (data) {
          print(data);
          int j = 0;
          for (int i = 0; i < selectItems.length; i++) {
            if (selectItems[i].type == 10) {
              j = 1;
              selectItems[i].id = data['id'].toString();
              selectItems[i].name = data['name'];
              break;
            }
          }

          if (j == 0) {
            SelectItem s = SelectItem();
            s.type = 10;
            s.name = data['name'];
            s.id = data['id'].toString();
            selectItems.add(s);
          }
          onRefresh();
          update();
        },
        onHide: (data) {
          selectItems.removeWhere((e) => e.type==10);
          onRefresh();
        },
        selectId: id,
      ),
    );
  }

  majorWindow() {
    showJustBottomSheet(
      context: Get.context!,
      dragZoneConfiguration: JustBottomSheetDragZoneConfiguration(
        dragZonePosition: DragZonePosition.inside,
        child: Container(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(6.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 4,
              width: 30,
              color: Theme.of(Get.context!).brightness == Brightness.light
                  ? Colors.grey[300]
                  : Colors.white,
            ),
          ),
        ),
      ),
      configuration: JustBottomSheetPageConfiguration(
          height: ScreenUtil().screenHeight / 1.2,
          builder: (context) {
            return StatefulBuilder(builder: (context1, setBottomSheetState) {
              return HomesFilterPage(
                  selectItems: selectItems,
                  onFresh: () {
                    setBottomSheetState(() {
                      selectItems.clear();
                    });
                  });
            });
          },
          scrollController: scrollController,
          closeOnScroll: true,
          cornerRadius: 60.w,
          backgroundColor: Colors.white,
          backgroundImageFilter: null),
    );
  }
}
