import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../../common/routers/names.dart';
import '../../../../common/widgets/dy_behavior_null.dart';
import '../../../../common/widgets/empty_page.dart';
import '../../../../common/widgets/my_scroll_physics.dart';
import '../../../../common/widgets/refresh.dart';
import '../../../common/entities/loan/loan.dart';


import '../../common/entities/home/common.dart';
import '../../common/widgets/flutter_custom_select/widget/flutter_single_select.dart';
import 'logic.dart';

class ChannelPage extends StatelessWidget {
  final logic = Get.find<ChannelLogic>();
  final state = Get
      .find<ChannelLogic>()
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
        child: Scaffold(
            backgroundColor: Color(0xffefefef),
            //endDrawer: CategoryEndDrawer(),
            appBar: AppBar(
              //backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
              elevation: 0,
              //去掉Appbar底部阴影
              leadingWidth: 0,
              leading: const Text(
                  'Demo', style: TextStyle(color: Colors.black, fontSize: 15)),
              titleSpacing: 30.w,
              title: Row(
                children: [
                  Text("渠道管理",
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await appointDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 40.w, top: 0.h),
                    width: 200.w,
                    child: Row(
                      children: [
                        Text("添加渠道",style: TextStyle(fontSize: 36.sp),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffeeeeee)
                    // gradient: LinearGradient(
                    //   stops: [0, 0.5, 1],
                    //   colors: [
                    //     Color(0xffE2F1FF),
                    //     Color(0xffF9FBEB),
                    //     Color(0xffFFF4FA)
                    //   ],
                    //   begin: Alignment(2, 1),
                    //   end: Alignment(-2, -1),
                    // )
                ),
                child: SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: Container(
                    margin: EdgeInsets.only(top: 0.h),
                    child: Stack(
                      children: [
                        GetBuilder<ChannelLogic>(builder: (logic) {
                          return _buildContent(context);
                        }),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     const MyCard(),
                        //     const MyCard1(),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                  ),
                ))));
  }

  Future<bool> _whenPop(BuildContext context) async {
    return true;
  }
  Widget buildBottomPop(){

    List<SelectItem> channelSelect = <SelectItem>[];
    SelectItem channel1 = SelectItem();
    channel1.id = 1.toString();
    channel1.type = 1;
    channel1.name = "渠道公司";
    channel1.isSelect = false;
    channelSelect.add(channel1);

    SelectItem channel2 = SelectItem();
    channel2.id = 2.toString();
    channel2.type = 2;
    channel2.name = "装修公司";
    channel2.isSelect = false;
    channelSelect.add(channel2);
    return Container(
      child: Row(
        children: [
           Container(
              width: 120.w,
              padding:
              EdgeInsets.only(left: 20.w, top: 0.h, right: 0.w, bottom: 0.h),
              alignment: Alignment.centerLeft,
              child: Text("渠道：",
                  style:
                  TextStyle(fontSize: 32.sp, color: const Color(0xFF6a6a6a))),
            ),
          Expanded(
          child:Container(
            width: ScreenUtil().screenWidth,
            padding: EdgeInsets.only(
                left: 0.w, top: 0.h, right: 40.w, bottom: 0.h),
            child: CustomSingleSelectField<SelectItem>(
                title: "渠道类型",
                items: channelSelect,
                onSelectionDone: (data){
                  FocusScope.of(Get.context!).requestFocus(FocusNode()); //收起键盘
                },
                onSelectionCancel: (data){
                  FocusScope.of(Get.context!).requestFocus(FocusNode()); //收起键盘
                },
                itemAsString: (item) {
                  return item.name.toString();
                },
                dropDownItemAsString: (item) {
                  return item.name.toString()+"("+item.type.toString()+")";
                }
            ),
          )),
        ],
      ),
    );

  }
  Future<bool> appointDialog(BuildContext context) async {
    final logic = Get.find<ChannelLogic>();
    var result = SmartDialog.show(
        backDismiss: false,
        clickMaskDismiss: false,
        builder: (c) { return StatefulBuilder(builder: (context, state) {
          return GestureDetector(
            onTap: () {
              logic.remarkFieldNode.unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().screenWidth * 0.95,
                  height: 500.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                  ),
                  child: SingleChildScrollView(
                    //alignment: Alignment.bottomCenter,
                    //maxHeight: 700.h,
                    child: Stack(
                      //alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[

                        Positioned(
                          top: 30.h,
                          right: 30.h,
                          child: GestureDetector(
                            onTap: () {
                             SmartDialog.dismiss();
                            },
                            child: Image.asset(
                              'assets/images/btn_close_black.png',
                              width: 40.w,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30.h,
                          left: 270.w,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Text("添加渠道",
                                style:
                                TextStyle(fontSize: 36.sp, color:  Colors.black,fontWeight: FontWeight.w600)),
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80.w,right:80.w,top: 100.h),
                              //width: 300.w,
                              height: 80.h,
                              child: Row(
                                children: [


                                  Expanded(
                                    child: TextField(
                                      controller: logic.appointController,
                                      focusNode: logic.remarkFieldNode,
                                      style: const TextStyle(color: Colors.black),
                                      minLines: 7,
                                      maxLines: 7,
                                      cursorColor: Colors.blue,
                                      //cursorRadius: Radius.circular(40.h),
                                      cursorWidth: 3.w,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 40.w,right: 0,top: 50.h,bottom: 0),
                                        hintText: "请输入...",
                                        hintStyle:
                                        const TextStyle(color: Colors.blue),
                                        border:  OutlineInputBorder(    borderRadius: BorderRadius.all(Radius.circular(40.h)),),
                                        enabledBorder:  OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(40.h)),
                                            borderSide:
                                            BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      onChanged: (v) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 80.w,right: 80.w,top: 20.h),
                              child: CoolDropdown(
                                resultHeight: 80.h,
                                resultWidth: c.width-40.w,
                                resultPadding: EdgeInsets.only(left: 40.w,right: 40.w),
                                dropdownList: logic.dropdownItemList,
                                onChange: (_) {},
                                defaultValue: logic.dropdownItemList[0],
                                selectedItemBD:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,

                                ),
                                  selectedItemTS:TextStyle(color: Colors.blue, fontSize: 20),
                                resultBD:    BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.h),
                                  border: Border.all(width: 2.w,color: Colors.blue)
                                ),
                                dropdownWidth: c.width-40.w,
                                // placeholder: 'insert...',
                              ),
                            ),
                            Container(
                              width: ScreenUtil().screenWidth,
                              height: 80.h,
                              margin:
                              EdgeInsets.only(top: 40.h,left: 40.w,right: 40.w),
                              child: RaisedButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.h))),
                                color: Colors.lightBlue,
                                onPressed: () {

                                },
                                child: Text("提交",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36.sp)),
                              ),
                            ),
                          ],
                        ),




                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        });});
    return Future(() => false);
  }

  Widget _buildContent(BuildContext context) =>
      WillPopScope(
          onWillPop: () => _whenPop(context),
          child: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: Opacity(
                opacity: logic.opacity,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.w),
                          topRight: Radius.circular(40.w))),
                  margin: EdgeInsets.only(top: 0.h),
                  child: Container(
                    margin: EdgeInsets.only(top: 0.h),
                    child: SmartRefresher(
                        physics: const MyScrollPhysics(),
                        enablePullDown: true,
                        enablePullUp: true,
                        header: DYrefreshHeader(),
                        footer: DYrefreshFooter(),
                        controller: logic.refreshController,
                        onRefresh: logic.onRefresh,
                        onLoading: logic.onLoading,
                        child: SingleChildScrollView(
                          controller: logic.scrollControl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildMyItem(),
                          ),
                        )),
                  ),
                ),
              )));

  List<GestureDetector> _buildMyItem() {
    if (logic.loanData.isEmpty) {
      return [GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.FineDetail);
        },
        child: EmptyPage(),
      )
      ];
    }
    return logic.loanData
        .map((e) =>
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.Fine,
                arguments: {"cn_id": e.cnid, "title": e.cnname});
          },
          child: MyChannelContent(
            cnId: e.cnid,
            cnName: e.cnname,
            cnCode: e.cncode,
            cnType: getCnType(e.cntype),
            cnUser: e.searchvalue.toString(),
            remark: e.remark,
            time: e.createtime,
            color: Colors.white,
          ),
        ))
        .toList();
  }

  MyItem getStatus(Data data) {
    String status = "";
    Color color = const Color(0xffFF6666);
    String icon = "";

    if (data.status == 9) {
      status = "放款失败";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_fail.png";
    }
    if (data.status == 11) {
      status = "资质不符";
      color = const Color(0xff4CD070);
      icon = "assets/images/default/fine_no.png";
    }
    if (data.status == 10) {
      status = "客户放弃";
      color = const Color(0xff6360CA);
      icon = "assets/images/default/fine_lost.png";
    }
    if (data.status == 1) {
      status = "联系中";
      color = const Color(0xff4DA1EE);
      icon = "assets/images/default/fine_call.png";
    }
    if (data.status == 8) {
      status = "已放款";
      color = const Color(0xffD8AA0F);
      icon = "assets/images/default/fine_success.png";
    }
    return MyItem(
      icon: icon,
      name: data.csName,
      status: status,
      money: data.loanAmount.toString(),
      time: data.submitTime,
      count: data.loanCycle.toString(),
      color: color,
    );
  }

  String getCnType(int type) {
    String data = "";
    if (type == 1) {
      data = "业务员";
    }
    if (type == 2) {
      data = "渠道公司";
    }
    if (type == 3) {
      data = "装修公司";
    }
    return data;
  }
}

Widget buildButton(BuildContext context, int groupValue,
    ChangeCallback callback) {
  return Container(
    padding: EdgeInsets.only(left: 0.w, right: 0.w),
    alignment: Alignment.centerLeft,
    child: Wrap(runSpacing: 30.w, spacing: 30.w, children: [
      MButton(
        name: "已放款",
        index: 8,
        groupValue: groupValue,
        callback: callback,
      ),
      MButton(
        name: "放款失败",
        index: 9,
        groupValue: groupValue,
        callback: callback,
      ),
      MButton(
        name: "客户放弃",
        index: 10,
        groupValue: groupValue,
        callback: callback,
      ),
      MButton(
        name: "资质不符",
        index: 11,
        groupValue: groupValue,
        callback: callback,
      ),
      MButton(
        name: "联系中",
        index: 1,
        groupValue: groupValue,
        callback: callback,
      ),
    ]),
  );
}

typedef ChangeCallback = void Function(int index, bool value, String name);

class MButton extends StatefulWidget {
  final String name;
  final int index;

  final int groupValue;
  final ChangeCallback callback;

  const MButton({Key? key, required this.name,
    required this.index,
    required this.groupValue,
    required this.callback}) : super(key: key);

  @override
  _MButtonState createState() => _MButtonState();
}

class _MButtonState extends State<MButton> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.groupValue == widget.index;
    return ChoiceChip(
      backgroundColor: selected ? Colors.white : const Color(0xffF5F6F9),
      selectedColor: selected ? Colors.transparent : const Color(0xffF5F6F9),
      side: BorderSide(
          width: 2.w, color: selected ? Colors.blue : Colors.transparent),
      padding:
      EdgeInsets.only(left: 40.w, right: 40.w, top: 15.h, bottom: 15.h),
      labelPadding: EdgeInsets.only(left: 0.w, right: 0.w),
      selectedShadowColor: Colors.transparent,
      shadowColor: Colors.transparent,
      pressElevation: 0,
      elevation: 0,
      label: Text(
        widget.name,
        style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
            fontSize: 30.sp,
            fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      ),
      selected: selected,
      onSelected: (bool value) {
        setState(() {
          widget.callback(widget.index, !selected, widget.name);
        });
      },
    );
  }
}

class MyCard extends StatefulWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0, 1],
            colors: [Color(0xffA4D3FF), Color(0xff1890FF)],
            begin: Alignment(1, -1),
            end: Alignment(-1, -1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.w))),
      width: 320.w,
      height: 120.h,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Text("共获取客户",
                            style: TextStyle(
                                color: Colors.white, fontSize: 30.sp))),
                    Text("4人",
                        style: TextStyle(
                            color: Colors.white, fontSize: 30.sp)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 10.w,
              child: SizedBox(
                  width: 110.w,
                  height: 110.h,
                  child: Image.asset("assets/images/default/customer.png")))
        ],
      ),
    );
  }
}

class MyCard1 extends StatefulWidget {
  const MyCard1({Key? key}) : super(key: key);

  @override
  _MyCard1State createState() => _MyCard1State();
}

class _MyCard1State extends State<MyCard1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            stops: [0, 1],
            colors: [Color(0xffFFB83A), Color(0xffFFD58A)],
            begin: Alignment(-1, -1),
            end: Alignment(1, -1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.w))),
      width: 320.w,
      height: 120.h,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.h, left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: Text("已放款",
                            style: TextStyle(
                                color: Colors.white, fontSize: 30.sp))),
                    Text("8人",
                        style: TextStyle(
                            color: Colors.white, fontSize: 30.sp)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 10.w,
              child: SizedBox(
                  width: 110.w,
                  height: 110.h,
                  child: Image.asset("assets/images/default/money.png")))
        ],
      ),
    );
  }
}

class MyContent extends StatefulWidget {
  final String icon;
  final String name;
  final String money;
  final String count;
  final String status;
  final String time;
  final Color color;

  const MyContent({Key? key, required this.icon,
    required this.name,
    required this.money,
    required this.count,
    required this.status,
    required this.time,
    required this.color}) : super(key: key);

  @override
  _MyContentState createState() => _MyContentState();
}

class MyChannelContent extends StatefulWidget {
  final int cnId;
  final String cnName;
  final String cnCode;
  final String cnType;
  final String cnUser;
  final String time;
  final String remark;
  final Color color;

  const MyChannelContent({Key? key, required this.cnId,
    required this.cnName,
    required this.cnCode,
    required this.cnType,
    required this.cnUser,
    required this.remark,
    required this.time,
    required this.color}) : super(key: key);

  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyChannelContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.w),
      ),

      margin: EdgeInsets.only(top: 20.h, left: 40.w, right: 40.w),
      padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: EdgeInsets.only(top: 0.h, left: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text("渠道名称：",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text(widget.cnName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text("渠道编号：",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text(widget.cnCode,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text("渠道类型：",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text(widget.cnType,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text("渠道创建人：",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text(widget.cnUser,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),

                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text("创建时间：",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: Text(widget.time,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),

                    SizedBox(height: 20.h,)
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

}
