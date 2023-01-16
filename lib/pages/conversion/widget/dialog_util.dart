import 'package:flutter/material.dart';
import '../../../common/widgets/chat/functions.dart';
import 'object_util.dart';

class DialogUtil {
  static buildToast(String str) {

  }

  static buildSnakeBar(BuildContext context, String str) {
    final snackBar =  SnackBar(
        content:  Text(str),
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.blue);

  }

  //如果context在Scaffold之前，弹不出请用这个
  //使用GlobalKey开销较大，如果有其他可选方案，应尽量避免使用它
  static buildSnakeBarByKey(String str, GlobalKey<ScaffoldState> key) {
    final snackBar =  SnackBar(
        content:  Text(str),
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.blue);

  }

  /*
  * 普通dialog
  */
  static showBaseDialog(BuildContext context, String content,
      {String title = '提示',
      String left = '取消',
      String right = '确认',
      OnItemClick? leftClick,
      OnItemClick? rightClick}) {
    showDialog(
        context: context,
        barrierDismissible: true, //点击对话框barrier(遮罩)时是否关闭它
        builder: (BuildContext context) =>  AlertDialog(
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                title: ObjectUtil.isEmpty(title)
                    ? SizedBox(
                        width: 0,
                        height: 10,
                      )
                    :  Text(title),
                titlePadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                content:  Text(content),
                actions: <Widget>[
                  ObjectUtil.isEmpty(left)
                      ? SizedBox(
                          width: 0,
                          height: 15,
                        )
                      : ElevatedButton(
                          child:  Text(
                            left,
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (null != leftClick) {
                              leftClick(0);
                            }
                          },
                        ),
                  ObjectUtil.isEmpty(right)
                      ? SizedBox(
                          width: 0,
                          height: 15,
                        )
                      : ElevatedButton(
                          child:  Text(
                            right,
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (null != rightClick) {
                              rightClick(0);
                            }
                          },
                        )
                ]));
  }
}
