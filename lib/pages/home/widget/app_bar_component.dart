import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/common/entities/loan/step.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/entities/home/common.dart';
import '../../../common/entities/home/common.dart';
import '../../../common/services/storage.dart';
import '../../../common/widgets/dropdown/src/gzx_dropdown_header.dart';
import '../../../common/widgets/dropdown/src/gzx_dropdown_menu.dart';
import '../../../common/widgets/dropdown/src/gzx_dropdown_menu_controller.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../logic.dart';

class AppBarComponent extends StatefulWidget {
  final List<SelectItem> selectItems;
  final Function(dynamic) onItemClick;

  const AppBarComponent({
    Key? key,
    required this.selectItems,
    required this.onItemClick,
  }) : super(key: key);

  @override
  _AppBarComponentState createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  final logic = Get.find<HomeLogic>();
  List<CitySelect> firstLevels = <CitySelect>[];
  List<StoreSelect> all = <StoreSelect>[];
  final String title = "";
  final Color bgColor = Colors.black;
  final Color textColor = Colors.redAccent;
  final List<String> _dropDownHeaderItemStrings = [
    '操作步骤',
    '来源渠道',
    '当前员工',
    '更多'
  ];
  final List<SortCondition> _brandSortConditions = [];
  late SortCondition _selectBrandSortCondition;
  final GZXDropdownMenuController _dropdownMenuController =
      GZXDropdownMenuController();
  List<StoreSelect> secondtLevels = <StoreSelect>[];
  final GlobalKey _stackKey = GlobalKey();
  int roleId = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    SortCondition cc1 = SortCondition();
    cc1.name = "操作步骤";
    cc1.id = 0;
    cc1.isSelected = false;
    _brandSortConditions.add(cc1);
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
      var result = await CommonAPI.getSuperStep({});
      if (result.code == 200) {
        List<StepDataData> da = result.data!.data!;
        for (var value in da) {
          SortCondition cc1 = SortCondition();
          cc1.name = value.label + "(" + value.num.toString() + ")";
          cc1.id = value.status;
          cc1.isSelected = false;
          _brandSortConditions.add(cc1);
        }
      }
    } else if (roleKey == "director") {
      var result = await CommonAPI.getManageStep({});
      if (result.code == 200) {
        List<StepDataData> da = result.data!.data!;
        for (var value in da) {
          SortCondition cc1 = SortCondition();
          cc1.name = value.label + "(" + value.num.toString() + ")";
          cc1.id = value.status;
          cc1.isSelected = false;
          _brandSortConditions.add(cc1);
        }
      }

    }else if (roleKey == "salesman") {
      var result = await CommonAPI.getSaleManStep({});
      if (result.code == 200) {
        List<StepDataData> da = result.data!.data!;
        for (var value in da) {
          SortCondition cc1 = SortCondition();
          cc1.name = value.label + "(" + value.num.toString() + ")";
          cc1.id = value.status;
          cc1.isSelected = false;
          _brandSortConditions.add(cc1);
        }
      }

    } else {}

    if (!mounted) return;
    setState(() {});
  }

  bool getSelect() {
    var f = <SelectItem>[];
    for (int i = 0; i < widget.selectItems.length; i++) {
      if (widget.selectItems[i].type! < 100) {
        f.add(widget.selectItems[i]);
      }
    }
    return f.isNotEmpty;
  }

  String getTitleName(int type) {
    String title = "";
    for (int i = 0; i < widget.selectItems.length; i++) {
      if (widget.selectItems[i].type == type) {
        title = widget.selectItems[i].name.toString();
      }
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    if(getTitleName(11)!=""){
      _dropDownHeaderItemStrings[1] = getTitleName(11);
    }else{
      _dropDownHeaderItemStrings[1] ="来源渠道";
    }
    if(getTitleName(9)!=""){
      _dropDownHeaderItemStrings[2] = getTitleName(10);
    }else{
      _dropDownHeaderItemStrings[2] ="当前员工";
    }
    return Stack(
      key: _stackKey,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: GZXDropDownHeader(
                radius: 12.w,
                color: Colors.white,
                height: 65.h,
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0],
                      style: TextStyle(
                          color: (_dropDownHeaderItemStrings[0] == "操作步骤")
                              ? Colors.black
                              : Colors.redAccent)),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1],
                      style: TextStyle(
                          color: (_dropDownHeaderItemStrings[1] == "来源渠道")
                              ? Colors.black
                              : Colors.redAccent)),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2],
                      style: TextStyle(
                          color: (_dropDownHeaderItemStrings[2] == "当前员工")
                              ? Colors.black
                              : Colors.redAccent)),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3],
                      style: TextStyle(
                          color: (getSelect() == false)
                              ? Colors.black
                              : Colors.redAccent),
                      iconSize: 30.sp),
                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: (index) {
                  if (index > 0) {
                    widget.onItemClick(index);
                    _dropdownMenuController.hide();
                  }
                },
              ),
            ),
          ],
        ),
        GZXDropDownMenu(
          controller: _dropdownMenuController,
          animationMilliseconds: 350,
          menus: [
            GZXDropdownMenuBuilder(
                dropDownHeight: 62.h * _brandSortConditions.length,
                dropDownWidget:
                    _buildConditionListWidget(_brandSortConditions, (value) {
                  _selectBrandSortCondition = value;
                  _dropDownHeaderItemStrings[0] =
                      _selectBrandSortCondition.name!;
                  _dropdownMenuController.hide();
                  setState(() {});
                  int k = 0;
                  for (int i = 0; i < widget.selectItems.length; i++) {
                    if (widget.selectItems[i].type == 120) {
                      widget.selectItems[i].id = value.id.toString();
                      k = 1;
                      break;
                    }
                  }
                  if (k > 0) {
                  } else {
                    SelectItem s = SelectItem();
                    s.type = 120;
                    s.id = value.id.toString();

                    widget.selectItems.add(s);
                  }
                  logic.onRefresh();
                })),
            // GZXDropdownMenuBuilder(
            //     dropDownHeight: 62.h * _brandSortConditions.length,
            //     dropDownWidget:
            //     _buildConditionListWidget(_brandSortConditions, (value) {
            //       _selectBrandSortCondition = value;
            //       _dropDownHeaderItemStrings[1] =
            //           _selectBrandSortCondition.name!;
            //       _dropdownMenuController.hide();
            //       setState(() {});
            //       int k = 0;
            //       for (int i = 0; i < widget.selectItems.length; i++) {
            //         if (widget.selectItems[i].type == 120) {
            //           widget.selectItems[i].id = value.id.toString();
            //           k = 1;
            //           break;
            //         }
            //       }
            //       if (k > 0) {
            //       } else {
            //         SelectItem s = SelectItem();
            //         s.type = 120;
            //         s.id = value.id.toString();
            //         widget.selectItems.add(s);
            //       }
            //       logic.onRefresh();
            //     })),
            // GZXDropdownMenuBuilder(
            //     dropDownHeight: 62.h * _distanceSortConditions.length,
            //     dropDownWidget: _buildConditionListWidget(
            //         _distanceSortConditions, (value) {
            //       _selectDistanceSortCondition = value;
            //       _dropDownHeaderItemStrings[2] =
            //           _selectDistanceSortCondition.name!;
            //       _dropdownMenuController.hide();
            //       setState(() {});
            //       int k = 0;
            //       for (int i = 0; i < widget.selectItems.length; i++) {
            //         if (widget.selectItems[i].type == 130) {
            //           widget.selectItems[i].id = value.id.toString();
            //           k = 1;
            //           break;
            //         }
            //       }
            //       if (k > 0) {
            //       } else {
            //         SelectItem s = SelectItem();
            //         s.type = 130;
            //         s.id = value.id.toString();
            //         widget.selectItems.add(s);
            //       }
            //       logic.onRefresh();
            //     })),
          ],
        ),
      ],
    );
  }

  int _selectTempFirstLevelIndex = 0;
  int _selectFirstLevelIndex = 0;

  int _selectSecondLevelIndex = -1;

  _buildStoreWidget(void Function(SelectItem selectValue) itemOnTap) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 200.w,
          child: ListView(
            children: firstLevels.map((item) {
              int index = firstLevels.indexOf(item);
              return GestureDetector(
                onTap: () {
                  _selectTempFirstLevelIndex = index;

                  if (_selectTempFirstLevelIndex == 0) {
                    SelectItem s = SelectItem();
                    s.type = 101;
                    s.id = "1";
                    s.name = "全部门店";
                    itemOnTap(s);
                    return;
                  } else {
                    secondtLevels = [];
                    for (int i = 0; i < all.length; i++) {
                      if (all[i].city == item.id) {
                        StoreSelect ddd1 = StoreSelect();
                        ddd1.id = all[i].id;
                        ddd1.name = all[i].name;
                        ddd1.city = item.id;
                        secondtLevels.add(ddd1);
                      }
                    }
                    setState(() {});
                  }
                  setState(() {});
                },
                child: Container(
                    height: 80.h,
                    color: _selectTempFirstLevelIndex == index
                        ? Colors.grey[100]
                        : Colors.white,
                    alignment: Alignment.center,
                    child: _selectTempFirstLevelIndex == index
                        ? Text(
                            '${item.name}',
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : Text('${item.name}')),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[100],
            child: _selectTempFirstLevelIndex == 0
                ? Container()
                : ListView(
                    children: secondtLevels.map((item) {
                      int index = secondtLevels.indexOf(item);
                      return GestureDetector(
                          onTap: () {
                            _selectSecondLevelIndex = index;
                            _selectFirstLevelIndex = _selectTempFirstLevelIndex;
                            if (_selectSecondLevelIndex == 0) {
                              SelectItem s = SelectItem();
                              s.type = 100;
                              s.id = item.id.toString();
                              s.name = item.name;
                              itemOnTap(s);
                            } else {
                              SelectItem s = SelectItem();
                              s.type = 100;
                              s.id = item.id.toString();
                              s.name = item.name;
                              itemOnTap(s);
                            }
                          },
                          child: Container(
                            height: 80.h,
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              SizedBox(
                                width: 40.w,
                              ),
                              _selectFirstLevelIndex ==
                                          _selectTempFirstLevelIndex &&
                                      _selectSecondLevelIndex == index
                                  ? Text(
                                      '${item.name}',
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text('${item.name}'),
                            ]),
                          ));
                    }).toList(),
                  ),
          ),
        )
      ],
    );
  }

  _buildConditionListWidget(items, itemOnTap(SortCondition)) {
    return ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          // item 的个数
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 2.h),
          // 添加分割线
          itemBuilder: (BuildContext context, int index) {
            SortCondition goodsSortCondition = items[index];
            return GestureDetector(
              onTap: () {
                for (var value in items) {
                  value.isSelected = false;
                }

                goodsSortCondition.isSelected = true;

                itemOnTap(goodsSortCondition);
              },
              child: SizedBox(
//            color: Colors.blue,
                height: 59.h,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 32.w,
                    ),
                    Expanded(
                      child: Text(
                        goodsSortCondition.name!,
                        style: TextStyle(
                          color: goodsSortCondition.isSelected!
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                    goodsSortCondition.isSelected!
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                            size: 32.sp,
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: 32.w,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
