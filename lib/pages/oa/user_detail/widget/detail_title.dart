
import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/user_detail/widget/panel.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_star/star_score.dart';

import '../../../../common/values/cons.dart';
const List<int> colors = Cons.tabColors;
class WidgetDetailTitle extends StatelessWidget {
  final Map<String, dynamic>? userDetail;

  const WidgetDetailTitle({Key? key, this.userDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildLeft(userDetail!),
            _buildRight(userDetail!),
          ],
        ),
        const Divider(),
      ],
    );
  }
Widget _buildLeft(Map<String, dynamic> userDetail) => Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20),
        child: Text(
          "用户名：" + userDetail['user']['userName'],
          style: TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff1EBBFD),
              fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Panel(
            child: Text("性别：" +
                (userDetail['user']['sex'].toString() == "1" ? "男" : "女") +
                " 年龄：" +
                userDetail['user']['age'].toString() +
                " 手机号：" +
                userDetail['user']['tel'].toString() +
                " 颜值：" +
                userDetail['user']['facescore'].toString())),
      )
    ],
  ),
);

Widget _buildRight(Map<String, dynamic> userDetail) => Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.w)),
            child: Image(
                image: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/ic_launcher.png',
                  image: userDetail['user']['img'],
                ).image)),
      ),
    ),
    StarScore(
      score: 0,
      star: Star(size: 30.sp, fillColor: Colors.blue),
    )
  ],
);
}