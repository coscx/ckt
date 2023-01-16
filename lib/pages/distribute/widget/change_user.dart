import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/entities/detail/user.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../../common/widgets/delete_category_dialog.dart';
import '../../user_detail/widget/common_dialog.dart';

class ErpUser {
  String name;
  int id;
  bool isSelected;
  int city;

  ErpUser(
      {required this.name,
      required this.id,
      required this.city,
      required this.isSelected});
}

class ErpUserPage extends StatefulWidget {
  final String uuid;

  const ErpUserPage({required this.uuid});

  @override
  State<StatefulWidget> createState() {
    return _NaviPageState();
  }
}

class _NaviPageState extends State<ErpUserPage> {
  List<User> user = []; //二级分类集合
  List<User> user1 = []; //二级分类集合
  List<User> user2 = []; //二级分类集合
  List<User> user3 = []; //二级分类集合
  final List<String> _datas = ["销售部门", "服务部门", "其他部门"]; //一级分类集合
  int selectId = 0;
  String selectName = "";
  String selectUuid = "";
  int index = 0; //一级分类下标
  bool select = false;

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      var result = await CommonAPI.getErpUser();
      if (result.code == 200) {
      } else {}
      var y = result.data;
      var users = y.data;
      for (int i = 0; i < users.length; i++) {
        var e = users[i];
        if (e.status == 0) {
          continue;
        }
        if (e.departmentId == 6) {
          e.relname = e.relname + "(销售经理)";
        }
        if (e.departmentId == 7) {
          e.relname = e.relname + "(服务经理)";
        }

        if (e.departmentId == 6 ||
            e.departmentId == 8 ||
            e.departmentId == 9 ||
            e.departmentId == 10) {
          user1.add(e);
        } else if (e.departmentId == 7 ||
            e.departmentId == 11 ||
            e.departmentId == 12 ||
            e.departmentId == 13) {
          user2.add(e);
        } else {
          user3.add(e);
        }
      }

      /// 初始化
      setState(() {
        index = 0;
        user = user1;
      });
    } catch (e) {
      print(e);
    }
  }

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
              titleSpacing: 40.w,
              leadingWidth: 60.w,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("请选择",
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 38.sp,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  )),
              //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
              backgroundColor: Colors.white,
              elevation: 0,

              //bottom: bar(),
            ),
            body: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: ScreenUtil().screenHeight - 400.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                              itemCount: _datas.length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return getRow(position);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                  //height: double.infinity,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 20.w),
                                  color: Colors.white,
                                  child: user.length == 0
                                      ? Container(
                                          height: 300,
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.loop,
                                                  color: Colors.grey,
                                                  size: 160.sp),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 32.h),
                                                child: const Text(
                                                  "加载中",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : getChip(index), //传入一级分类下标
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 50.h, bottom: 0.h, left: 10.h, right: 10.h),
                      child: Container(
                        color: Colors.white,
                        width: ScreenUtil().screenWidth * 0.89,
                        height: 70.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectId == 0) {
                              showToastRed(context, '请选择用户', true);
                              return;
                            }

                            var actionList = await CommonAPI.distribute(
                                widget.uuid, ++index, selectId);
                            if (actionList.code == 200) {
                              showToast(context, '划分成功', true);
                              Navigator.pop(context, selectId);
                            } else {
                              showToastRed(context, actionList.message!, true);
                              Navigator.pop(context, selectId);
                            }
                          },
                          child: Text("提交",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 40.sp)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget getRow(int i) {
    Color textColor = Theme.of(context).primaryColor; //字体颜色
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        //Container下的color属性会与decoration下的border属性冲突，所以要用decoration下的color属性
        decoration: BoxDecoration(
          color: index == i ? Colors.grey.withAlpha(33) : Colors.white,
          border: Border(
            left: BorderSide(
                width: 5,
                color:
                    index == i ? Theme.of(context).primaryColor : Colors.white),
          ),
        ),
        child: Text(
          _datas[i],
          style: TextStyle(
            color: index == i ? textColor : Colors.black,
            fontWeight: index == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          index = i; //记录选中的下标
          textColor = Colors.green;
        });
      },
    );
  }

  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);
    return Wrap(
      spacing: 24.w, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        user.length,
        (int index) {
          return ActionChip(
            //标签文字
            label: Text(
              user[index].relname,
              style: TextStyle(
                  fontSize: 32.sp,
                  color:
                      user[index].id == selectId ? Colors.white : Colors.black),
            ),
            //点击事件
            onPressed: () {
              setState(() {
                selectId = user[index].id;
                selectName = user[index].relname;
                selectUuid = user[index].uuid;
                //bindDialog(context,user[index]['store_name'],""+user[index]['depart_name']+":"+user[index]['relname']);
              });
            },
            elevation: 3,
            backgroundColor:
                user[index].id == selectId ? Colors.blue : Colors.grey.shade200,
          );
        },
      ).toList(),
    );
  }

  ///
  /// 根据一级分类下标更新二级分类集合
  ///
  List<User> _updateArticles(int i) {
    setState(() {
      if (i == 0) {
        user = user1;
      }
      if (i == 1) {
        user = user2;
      }
      if (i == 2) {
        user = user3;
      }
    });
    return user;
  }
}

bindDialog(BuildContext context, String title, String content) {
  showDialog(
      context: context,
      builder: (ctx) => Dialog(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.w))),
            child: Container(
              width: 50.w,
              child: DeleteCategoryDialog(
                title: title,
                content: content,
                onSubmit: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ));
}
