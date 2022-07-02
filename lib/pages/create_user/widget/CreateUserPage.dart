import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/pages/create_user/widget/textStyles.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/common.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../user_detail/widget/common_dialog.dart';
import 'enums.dart';
class CreateUserPages extends StatefulWidget {
  @override
  _CreateUserPageState createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPages> {
  Color? inActiveColor = Colors.grey[200];
  Color? inActiveColorDark = Colors.grey[600];
  Color activeColor = Colors.lightBlue;
  String name ="";
  String mobile ="";
  int gender  = 1;
  String birthday = "";
  int from = 1;
  int marriage = 1;
  double age = 18, weight = 60, height = 170;

  final FocusNode _textFieldNode = FocusNode();
  final FocusNode _mobileFieldNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usernameController = TextEditingController(text: '');
  final _mobileController = TextEditingController(text: '');
  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textFieldNode.dispose();
    _mobileFieldNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final blockVertical = mediaQuery.size.height / 100;
    return Scaffold(
      key: _scaffoldKey,

      body: Column(
        children: <Widget>[
          // App title
          Padding(
            padding:  EdgeInsets.only(top: 60.h, left: 22.w, right: 2.w,bottom: 20.h),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Hero(
                  tag: "appBarTitle",
                  child: Text(
                    "用户创建",
                    style: isThemeDark(context)
                        ? TitleTextStyles.dark
                        : TitleTextStyles.light,
                  ),
                ),

              ],
            ),
          ),

    Expanded(
            child: ScrollConfiguration(
          behavior: DyBehaviorNull(),
          child: GestureDetector(
              onTap: (){
                _textFieldNode.unfocus();
                _mobileFieldNode.unfocus();
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child:ListView(
            shrinkWrap: true,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Hero(
                            tag: "topContainer",
                            child: Container(
                              padding:  EdgeInsets.only(top: 0.h, left: 25.w, right: 25.w,bottom: 10.h),
                             // type: MaterialType.transparency,
                              child: SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
//背景
                                    color: const Color.fromRGBO(255, 255, 255, 50),
                                    //设置四周圆角 角度
                                    borderRadius: BorderRadius.all(Radius.circular(20.h)),
                                    //设置四周边框
                                    //border:  Border.all(width: 1, color: Colors.red),
                                  ),
                                  padding:  EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w,bottom: 10.h),
                                  child: Column(
                                    children: <Widget>[
                                      //BlocBuilder<GlobalBloc, GlobalState>(builder: _buildCredit),

                                    Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child:  TextField(
                                            focusNode:_textFieldNode ,
                                            autofocus: false,
                                            style: TextStyle(color: Colors.black, fontSize: 30.sp),
                                            controller: _usernameController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                            labelText: "姓名",
                                            labelStyle: const TextStyle(color: Colors.blue),
                                            hintText: "请输入...",
                                            enabledBorder:  OutlineInputBorder(
                                            borderSide:
                                             BorderSide(color: Colors.blue, width: 2.w),
                                            ),
                                            border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.w)
                                            )
                                            )
                                        )
                                      )
                                    ),
                                      Container(
                                          child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child:  TextField(
                                                  focusNode:_mobileFieldNode ,
                                                  autofocus: false,
                                                  style: TextStyle(color: Colors.black, fontSize: 30.sp),
                                                  controller: _mobileController,
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                      labelText: "手机号",
                                                      labelStyle: const TextStyle(color: Colors.blue),
                                                      hintText: "请输入...",
                                                      enabledBorder:  OutlineInputBorder(
                                                        borderSide:
                                                         BorderSide(color: Colors.blue, width: 2.w),
                                                      ),
                                                      border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(10.w)
                                                      )
                                                  )
                                              )
                                          )
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedGender =
                                                      Gender.male;
                                                  gender = 1;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 18.h, horizontal: 10.w),
                                                child: Material(
                                                  color: selectedGender ==
                                                          Gender.male
                                                      ? activeColor
                                                      :  inActiveColor,
                                                  elevation: 4.0,
                                                  borderRadius:
                                                      BorderRadius.circular(10.w),
                                                  shadowColor: Colors.grey,
                                                  child: Container(
                                                    // splashColor: Colors.redAccent,
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         16.w),
                                                    child: Container(
                                                      height: blockVertical * 5.5,
                                                      child: Center(
                                                          child: Text(
                                                        "男",
                                                        style:
                                                        TextStyle(
                                                          //fontFamily: "Poppins",
                                                         // fontWeight: FontWeight.w100,
                                                          decoration: TextDecoration.none,
                                                          fontSize: 40.sp,
                                                          color: selectedGender ==
                                                              Gender.male
                                                              ? Colors.white
                                                              :  Colors.black,
                                                        ),
                                                      )),
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedGender =
                                                      Gender.female;
                                                  gender = 2;
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 12.h, horizontal: 6.w),
                                                child: Material(
                                                  color: selectedGender ==
                                                          Gender.female
                                                      ? activeColor
                                                      : isThemeDark(context)
                                                          ? inActiveColorDark
                                                          : inActiveColor,
                                                  elevation: 4.0,
                                                  borderRadius:
                                                      BorderRadius.circular(10.w),
                                                  shadowColor: Colors.grey,
                                                  child: Container(
                                                    // splashColor: Colors.redAccent,
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         16.w),
                                                    child: Container(
                                                      height: blockVertical * 5.5,
                                                      child: Center(
                                                          child: Text(
                                                        "女",
                                                        style:
                                                        TextStyle(
                                                          //fontFamily: "Poppins",
                                                          //fontWeight: FontWeight.w100,
                                                          decoration: TextDecoration.none,
                                                          fontSize: 40.sp,
                                                          color: selectedGender ==
                                                              Gender.female
                                                              ? Colors.white
                                                              :  Colors.black,
                                                        ),
                                                      )),
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                          onTap: (){
                                            _textFieldNode.unfocus();
                                            _mobileFieldNode.unfocus();
                                            showPickerDateTime(context,"","birthday");
                                          },child:  _item_detail(context,Colors.black,Icons.calendar_today_outlined,"生日",birthday,true)),
                                      GestureDetector(
                                          onTap: (){
                                            _textFieldNode.unfocus();
                                            _mobileFieldNode.unfocus();
                                            showPickerArray(context,[marriageLevel],[marriage],"marriage","",true);
                                          } ,child:  _item_detail_gradute(context,Colors.redAccent,Icons.wc,"婚姻状态",marriageLevel[marriage],true)),
                                      GestureDetector(
                                          onTap: (){
                                            _textFieldNode.unfocus();
                                            _mobileFieldNode.unfocus();
                                            showPickerArray(context,[fromLevel],[from],"from","",true);
                                          } ,child:  _item_detail_gradute(context,Colors.redAccent,Icons.whatshot,"来访渠道",fromLevel[from],true)),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h, bottom: 270.h,left: 10.h,right: 10.h),
                                        child: Container(
                                          width: ScreenUtil().screenWidth*0.89,
                                          height: 70.h,
                                          child: RaisedButton(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(40.w))),
                                            color: Colors.lightBlue,
                                            onPressed: () async {
                                              mobile = _mobileController.text;
                                              name = _usernameController.text;
                                              var result= await CommonAPI.addCustomer(mobile,name,gender,birthday,marriage,from);
                                              if(result.code==200){

                                                showToast(context,"创建成功",false);
                                                Navigator.of(context).pop();
                                              }else{

                                                showToastRed(context,result.message!,false);
                                              }

                                            },
                                            child: Text("提交",
                                                style: TextStyle(color: Colors.white, fontSize: 40.sp)),
                                          ),
                                        ),
                                      ),

                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
              )
            ),
            )
          ),
        ],
      ),
    );
  }
  showPickerDateTime(BuildContext context,String date,String type) {
    String dates = "";
    if (date =="-" || date =="" ){
      dates ="1999-01-01 08:00:00";
    }else{
      dates=date;
    }
    Picker(
        selectionOverlay:CupertinoPickerDefaultSelectionOverlay(background: Colors.transparent,),
        itemExtent: 40,
        magnification: 1.2,
        adapter:  DateTimePickerAdapter(
          type: PickerDateTimeType.kYMD,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          // yearSuffix: "年",
          // monthSuffix: "月",
          // daySuffix: "日",
          value: DateTime.parse(dates),
          maxValue: DateTime.now(),
          minuteInterval: 1,
          minHour: 0,
          maxHour: 23,
          // twoDigitYear: true,
        ),
        title:  Text("选择生日"),
        cancelText: "取消",
        confirmText: "确定",
        textAlign: TextAlign.center,
        selectedTextStyle: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.normal),
        delimiter: [
          PickerDelimiter(column: 4, child: Container(
            width: 16.w,
            alignment: Alignment.center,
            child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
            color: Colors.white,
          ))
        ],
        footer: Container(
          height: 50.h,
          alignment: Alignment.center,
          child: Text(''),
        ),
        onConfirm: (Picker picker, List value) async {
          setState(() {
            birthday = picker.adapter.text.substring(0,10);
          });

          print(picker.adapter.text);
        },
        onSelect: (Picker picker, int index, List<int> selecteds) {

          var stateText = picker.adapter.toString();

        }
    ).showDialog(context);
  }

  showPickerArray(BuildContext context,List<List<String >> pickerData,List<int > select,String type,String title,bool isIndex) {
    Picker(
        itemExtent: 40,
        magnification: 1.2,
        selectionOverlay:CupertinoPickerDefaultSelectionOverlay(background: Colors.transparent,),
        smooth: 50,
        adapter: PickerDataAdapter<String>(pickerdata: pickerData, isArray: true),
        hideHeader: true,
        title:  Text("请选择"+title),
        cancelText: "取消",
        confirmText: "确定",
        selecteds:select,
        // columnPadding: EdgeInsets.only(top: 50.h,bottom: 50.h,left: 50.w,right: 50.w),
        selectedTextStyle: TextStyle(
          fontSize: 34.sp,
          color: Colors.redAccent,
        ),
        textStyle: TextStyle(
          fontSize: 28.sp,
          color: Colors.black,
        ),
        onConfirm: (Picker picker, List value) async {
          print(value.toString());
          print(picker.getSelectedValues());
          int values;
          if(isIndex){
            values = value.first;
          }else{
            values = int.parse(picker.getSelectedValues().first);
          }
          setState(() {
            if(type =="marriage"){
              marriage = values;
            }
            if(type =="from"){
              from = values;
            }
          });

          // var result= await IssuesApi.editCustomerOnce(info['uuid'],type,values);
          // if(result['code']==200){
          //   BlocProvider.of<DetailBloc>(context).add(EditDetailEvent(type,values));
          //   _showToast(context,"编辑成功",false);
          // }else{
          //
          //   _showToast(context,result['message'],false);
          // }
        }
    ).showDialog(context);
  }
  Widget _item_detail(BuildContext context,Color color,IconData icon,String name ,String answer,bool show) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 10.h,
          bottom: 0
      ),
      width: double.infinity,
      height: 120.h,
      child:  Material(
          color:  Colors.transparent ,
          child: Container(
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w,top: 10.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 50.sp,
                          color: Colors.blue,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 35.sp, color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Visibility(
                            visible: true,
                            child: Container(
                              width: ScreenUtil().screenWidth*0.533,
                              child: Text(
                                answer,
                                maxLines: 20,
                                style: TextStyle(
                                    fontSize: 40.sp, color: Colors.redAccent),
                              ),
                            )),
                      ]),
                  //Visibility是控制子组件隐藏/可见的组件
                  Visibility(
                    visible: show,
                    child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(children: <Widget>[

                              SizedBox(
                                width: 10.w,
                              ),
                              Visibility(
                                  visible: false,
                                  child: Text(
                                    "2021-01-12 15:35:30",
                                    style: TextStyle(
                                        fontSize: 24.sp, color: Colors.blue),
                                  )),



                              const Visibility(
                                  visible: false,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("rightImageUri"),
                                  ))
                            ]),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 30.sp,
                            color: Colors.black54,
                          )

                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }
  Widget _item_detail_gradute(BuildContext context,Color color,IconData icon,String name ,String answer,bool show) {
    bool isDark = false;

    return  Container(
      padding:  EdgeInsets.only(
          top: 0.h,
          bottom: 0
      ),
      width: double.infinity,
      height: 120.h,
      child:  Material(
          color:  Colors.transparent ,
          child: Container(
            child: Container(
              margin: EdgeInsets.only(left: 10.w, right: 20.w,top: 10.h,bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 50.sp,
                          color: Colors.blue,
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 15.w),
                          child: Text(
                            name,
                            style: TextStyle(fontSize: 35.sp, color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Visibility(
                            visible: true,
                            child: Container(
                              width: ScreenUtil().screenWidth*0.45,
                              child: Text(
                                answer,
                                maxLines: 20,
                                style: TextStyle(
                                    fontSize: 35.sp, color: color),
                              ),
                            )),
                      ]),
                  //Visibility是控制子组件隐藏/可见的组件
                  Visibility(
                    visible: show,
                    child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Row(children: <Widget>[

                              SizedBox(
                                width: ScreenUtil().setWidth(10.w),
                              ),
                              Visibility(
                                  visible: false,
                                  child: Text(
                                    "2021-01-12 15:35:30",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: Colors.grey),
                                  )),



                              const Visibility(
                                  visible: false,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("rightImageUri"),
                                  ))
                            ]),
                          ),

                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 30.sp,
                            color: Colors.black54,
                          )

                        ]),
                  )
                ],
              ),
            ),
          )),
    );
  }





}
