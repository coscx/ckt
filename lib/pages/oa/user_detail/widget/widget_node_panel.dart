import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/user_detail/widget/panel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/style/toly_icon.dart';
import 'circle.dart';
import 'highlighter_style.dart';

/// 说明: 一个Widget的知识点对应的界面

class WidgetNodePanel extends StatefulWidget {
  final String? text;
  final String? subText;
  final String? code;
  final Widget? show;
  final HighlighterStyle? codeStyle;
  final String? codeFamily;
  final bool? showMore;
  bool? showControl;
  final void Function(String tag,bool value)? callSetState;
  String? name;
  WidgetNodePanel(
      {Key? key, this.text,
      this.subText,
      this.code,
      this.show,
      this.codeStyle,
      this.codeFamily,
      this.showMore, this.showControl,this.callSetState,this.name
      }) : super(key: key);

  @override
  _WidgetNodePanelState createState() => _WidgetNodePanelState();
}

class _WidgetNodePanelState extends State<WidgetNodePanel> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  Color get themeColor => Theme.of(context).primaryColor;

@override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        buildNodeTitle(),
        SizedBox(
          height: 2.h,
        ),
        //_buildCode(context),
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          child:   Visibility(
              visible:widget.showControl!,
              replacement:const Text('data'),
              maintainState:true,
              child:Column(
                children: [
                  widget.show!,
                  widget.showMore! ? Container(
                      margin: EdgeInsets.only(left: 10.w, right: 20.w,top: 10.h,bottom: 10.h),
                      child: const Text("查看更多")
                  ):Container()
                ],
              )
          ),
        ),

        //_buildNodeInfo(),
        const Divider(),
      ],
    );
  }

  Widget buildNodeTitle() => GestureDetector(
    onTap: _toggleCodePanel,
      child:Row(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w),
            child: Circle(
              color: themeColor,
              radius: 5,
            ),
          ),
          Expanded(
            child: Text(
              '${widget.text}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),
            ),
          ),
          //_buildShareButton(),
          _buildCodeButton(widget.showControl!)
        ],
      ) ,
  );


  Widget _buildCodeButton(bool show ) => Padding(
        padding:  EdgeInsets.only(right: 18.w),
        child: Icon(
            TolyIcon.icon_code,
            color: themeColor,
          ),

      );



  // 折叠代码面板
  _toggleCodePanel() {
    setState(() {
      _crossFadeState =
          !isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;
      widget.showControl =!widget.showControl!;
      widget.callSetState!(widget.name!,widget.showControl!);
    });
  }
}
