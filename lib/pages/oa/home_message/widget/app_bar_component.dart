import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/common/entities/home/tree_store.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/entities/home/common.dart';
import '../../../../common/widgets/dy_behavior_null.dart';
import '../logic.dart';

class AppBarComponent extends StatefulWidget {
  final List<SelectItem> selectItems;
  final GlobalKey<ScaffoldState> state;
  final int mode;
   const AppBarComponent({Key? key,
    required this.selectItems,required this.state, required this.mode,
  }) : super(key: key);
  @override
  _AppBarComponentState createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {

  final logic = Get.find<HomeMessageLogic>();
  List<CitySelect> firstLevels = <CitySelect>[];
  List<StoreSelect> all = <StoreSelect>[];
  final String title = "";
  final Color bgColor = Colors.black;
  final Color textColor = Colors.redAccent;
  final List<String> _dropDownHeaderItemStrings = ['全部门店', '客户状态', '沟通状态'];
  final List<SortCondition> _brandSortConditions = [];
  final List<SortCondition> _distanceSortConditions = [];
  late SortCondition _selectBrandSortCondition;
  late SortCondition _selectDistanceSortCondition;
  final GZXDropdownMenuController _dropdownMenuController =
  GZXDropdownMenuController();
  List<StoreSelect> secondtLevels = <StoreSelect>[];
  final GlobalKey _stackKey = GlobalKey();
  int roleId =0;
  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 1)).then((e) async {
      int ccMode =0;
      ccMode =StorageService.to.getInt("currentPhotoMode");
      if (widget.mode >0){
        ccMode = widget.mode;
      }
      var roleIds = StorageService.to.getString("roleId");
      if (roleIds != "" ) {

        setState(() {
          roleId = int.parse(roleIds);
          //print(roleId);
          //print(widget.mode);
          //print((widget.mode==2 && (roleId == 7 || roleId == 9)));
          if (ccMode==2 && (roleId == 7 || roleId == 9)){
              //print("88888888");
            _distanceSortConditions.clear();
            _distanceSortConditions
                .add(SortCondition(name: '沟通状态', id: 0, isSelected: true, all: true));
            _distanceSortConditions
                .add(SortCondition(name: '20.已入库资料不全', id: 20, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '21.新分VIP', id: 21, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '22.无对象,待推荐', id: 22, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '23.推动见面指导', id: 23, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '24.撮合再见面', id: 24, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '25.深入交往,推动恋爱', id: 25, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '26.确认恋爱', id: 26, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '27.结婚', id: 27, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '28.暂停', id: 28, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '29.放弃', id: 29, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '30.已共识退费', id: 30, isSelected: false, all: true));

          }else{
            _distanceSortConditions.clear();
            _distanceSortConditions
                .add(SortCondition(name: '沟通状态', id: 0, isSelected: true, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '新分未联系', id: 1, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '号码无效', id: 2, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '号码未接通', id: 3, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '可继续沟通', id: 4, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '有意向面谈', id: 5, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '已到店', id: 6, isSelected: false, all: true));
            _distanceSortConditions.add(
                SortCondition(name: '已成交', id: 7, isSelected: false, all: true));
            _distanceSortConditions.add(SortCondition(
                name: '12.公海', id: 12, isSelected: false, all: true));
          }
        });
      }
    });
    _brandSortConditions
        .add(SortCondition(name: '客户状态', id: 0, isSelected: true, all: true));
    _brandSortConditions
        .add(SortCondition(name: 'A级客户', id: 2, isSelected: false, all: true));
    _brandSortConditions
        .add(SortCondition(name: 'B级客户', id: 1, isSelected: false, all: true));
    _brandSortConditions.add(
        SortCondition(name: 'C级客户', id: 100, isSelected: false, all: true));
    _brandSortConditions
        .add(SortCondition(name: 'D级客户', id: 30, isSelected: false, all: true));

    _selectBrandSortCondition = _brandSortConditions[0];

    _distanceSortConditions
        .add(SortCondition(name: '沟通状态', id: 0, isSelected: true, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '新分未联系', id: 1, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '号码无效', id: 2, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '号码未接通', id: 3, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '可继续沟通', id: 4, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '有意向面谈', id: 5, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '已到店', id: 6, isSelected: false, all: true));
    _distanceSortConditions.add(
        SortCondition(name: '已成交', id: 7, isSelected: false, all: true));
    _distanceSortConditions.add(SortCondition(
        name: '公海', id: 12, isSelected: false, all: true));
    _selectDistanceSortCondition = _distanceSortConditions[0];

    CitySelect ta = CitySelect();
    ta.name = "全部门店";
    ta.id = 0;
    firstLevels.add(ta);

    Future.delayed(const Duration(microseconds: 1)).then((e) async {
      var result = await CommonAPI.getTreeStoreList();
      if (result.code == 200) {
        all.clear();
        List<TreeStore> da = result.data;
        for (var value in da) {
          CitySelect cc1 = CitySelect();
          cc1.name = value.name;
          cc1.id = value.cityCode =="" ? 0:int.parse(value.cityCode);
          firstLevels.add(cc1);
          List<Data> stores = value.data;
          for (var value in stores) {
            StoreSelect ddd1 = StoreSelect();
            ddd1.id = value.id;
            ddd1.name = value.name;
            ddd1.city = cc1.id;
            all.add(ddd1);
          }
        }
        if (!mounted) return;
        setState(() {});
      } else {

      }
    });

    super.initState();
  }
bool getSelect(){
    var f = <SelectItem>[];
  for (int i = 0; i < widget.selectItems.length; i++) {
    if (widget.selectItems[i].type! <100 ) {
      f.add(widget.selectItems[i]);
    }

  }
  return f.isNotEmpty;
}
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: _stackKey,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration:  const BoxDecoration(),
              child: GZXDropDownHeader(
                height: 65.h,
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0],
                      style: TextStyle(color: (_dropDownHeaderItemStrings[0] =="全部门店" || _dropDownHeaderItemStrings[0] =="全部")?Colors.black:Colors.redAccent)),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1], style: TextStyle(color: (_dropDownHeaderItemStrings[1] =="客户状态" )?Colors.black:Colors.redAccent)),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2], style: TextStyle(color: (_dropDownHeaderItemStrings[2] =="沟通状态" )?Colors.black:Colors.redAccent)),

                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: (index) {
                  if (index == 3) {
                    widget.state.currentState?.openEndDrawer();
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
                dropDownHeight: 62.h * 8.0,
                dropDownWidget: _buildStoreWidget((selectValue) {
                  _dropDownHeaderItemStrings[0] = selectValue.name!;
                  _dropdownMenuController.hide();
                  setState(() {});
                  if (selectValue.type == 101) {
                    if (selectValue.id == "1") {
                      selectValue.id = "0";
                    } else {
                      return;
                    }
                  }
                  int k = 0;
                  for (int i = 0; i < widget.selectItems.length; i++) {
                    if (widget.selectItems[i].type == 100) {
                      widget.selectItems[i].id = selectValue.id.toString();
                      k = 1;
                      break;
                    }
                  }
                  if (k > 0) {
                  } else {
                    SelectItem s = SelectItem();
                    s.type = 100;
                    s.id = selectValue.id.toString();
                    widget.selectItems.add(s);
                  }
                  logic.onRefresh();
                })),
            GZXDropdownMenuBuilder(
                dropDownHeight: 62.h * _brandSortConditions.length,
                dropDownWidget:
                _buildConditionListWidget(_brandSortConditions, (value) {
                  _selectBrandSortCondition = value;
                  _dropDownHeaderItemStrings[1] =
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
            GZXDropdownMenuBuilder(
                dropDownHeight: 62.h * _distanceSortConditions.length,
                dropDownWidget: _buildConditionListWidget(
                    _distanceSortConditions, (value) {
                  _selectDistanceSortCondition = value;
                  _dropDownHeaderItemStrings[2] =
                      _selectDistanceSortCondition.name!;
                  _dropdownMenuController.hide();
                  setState(() {});
                  int k = 0;
                  for (int i = 0; i < widget.selectItems.length; i++) {
                    if (widget.selectItems[i].type == 130) {
                      widget.selectItems[i].id = value.id.toString();
                      k = 1;
                      break;
                    }
                  }
                  if (k > 0) {
                  } else {
                    SelectItem s = SelectItem();
                    s.type = 130;
                    s.id = value.id.toString();
                    widget.selectItems.add(s);
                  }
                  logic.onRefresh();
                })),
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

  _buildConditionListWidget(items,  itemOnTap(SortCondition)) {
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