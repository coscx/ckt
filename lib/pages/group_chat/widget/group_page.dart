import 'dart:io';
import 'dart:typed_data';

import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/widgets/chat/chat_input_view.dart';
import 'package:flutter_ckt/common/widgets/chat/event_bus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/widgets/chat/voice.dart';
import '../logic.dart';
import 'message_list_view.dart';

class GroupPage extends StatefulWidget {

  final List<Message> messageList;
  final Conversion model;
  final String memId;
  final String title;
  const GroupPage({
    required this.messageList,
    Key? key,
    required this.model,
    required this.memId,
    required this.title,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();

}

class _GroupPageState extends State<GroupPage> {
  ScrollController scrollController = ScrollController();
  var voice = Voice((sec,path){

  });
  @override
  void initState() {
    voice.init();
    super.initState();
  }
  @override
  void dispose() {
    voice.stopPlayer();
    voice.stopRecorder();
    super.dispose();
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
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true, // 标题居中
                title: Text(widget.title,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold)),

                //leading:const Text('Demo',style: TextStyle(color: Colors.black, fontSize: 15)),
                backgroundColor: Colors.white,
                elevation: 0,
                //去掉Appbar底部阴影
                actions: <Widget>[
                  Container(
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, UnitRouter.search);
                      },
                    ),
                  ),
                  SizedBox(width: 20.w),
                ],

                //bottom: bar(),
              ),
              body: Column(children: <Widget>[
                GroupMessageListView(
                    messageList: widget.messageList,
                    onResendClick: (reSendEntity) {},
                    onItemClick: _onItemClick,
                    onItemLongClick: (entity) {
                      debugPrint("onItemLongClick");
                    },
                  onMenuItemClick: (entity,key) {

                    if (key ==0){
                      var logic = Get.find<GroupChatLogic>();
                      logic.sendRevokeMessage(entity as Message);
                    }
                  },
                    bodyClick: () {
                      debugPrint("bodyClick");
                      //hideKeyBoard();
                      EventBusUtil.fire(PeerRecAckEvent(""));
                    },
                    tfSender: widget.model.memId!,
                    scrollController: scrollController,
                  voice: voice,

                ),
                Divider(height: 1.h),
                ChatInputView(
                  model: widget.model,
                  memId: widget.memId,
                  scrollController: scrollController,
                  voice: voice, sendVoiceClick: (File file, int length) {
                  var logic = Get.find<GroupChatLogic>();
                  logic.sendVoiceMessage(file,length);
                }, sendImageClick: (Uint8List content) {
                  var logic = Get.find<GroupChatLogic>();
                  logic.sendImgMessage(content);
                }, sendTextClick: (String content) {
                  final logic = Get.find<GroupChatLogic>();
                  logic.sendTextMessage(content);
                },
                )
              ])),
        ));
  }

  _onItemClick(_entity) {}
}
