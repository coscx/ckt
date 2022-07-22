import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../search_appoint/logic.dart';
import '../logic.dart';

class AppSearchBar extends StatefulWidget {
  final int isAppoint;

  const AppSearchBar({Key? key, required this.isAppoint}) : super(key: key);
  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController(); //文本控制器
  bool showClear = true;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
          width: ScreenUtil().screenWidth * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100.w)),
              color: const Color(0xFFeeeeee)),
          child: TextField(
            textAlign: TextAlign.start,
            autofocus: false,
            //自动聚焦，闪游标
            controller: _controller,
            maxLines: 1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 22.h),
              hintText: '手机号、用户名、id...',
              hintStyle: TextStyle(
                fontSize: 28.sp,
              ),
              suffixIcon: showClear
                  ? IconButton(
                    icon:
                        const Icon(Icons.clear, color: Color(0xFF444444)),
                    onPressed: () {
                      // 清空搜索内容
                      _controller.clear();
                    },
                  )
                  : Container(),
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF444444),
              ),
              border: InputBorder.none,
            ),
            onChanged: (str) => {if (str.isNotEmpty) {} else {}},

            onSubmitted: (str) {

              FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
            },
          )),
      buildSubmit()
    ],
  );

  Widget buildSubmit() {
    return Container(
      height: 70.h,
      width: 180.w,
      padding: EdgeInsets.only(top: 0.h, bottom: 0.h, left: 10.h, right: 0.h),
      child: CupertinoButton(
        child: Text("确定",style: TextStyle(
          fontSize: 28.sp,color: Colors.black
        ),),
        pressedOpacity: 0.1,
        padding: EdgeInsets.zero,
        color: const Color(0xFFeeeeee),
        borderRadius: BorderRadius.all(Radius.circular(35.w)),
        onPressed: () {

            final logic = Get.find<SearchLogic>();
            logic.searchUser(_controller.text);


          FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
