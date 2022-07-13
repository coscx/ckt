import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/entities/im/Im_message.dart';
import '../../../common/widgets/chat/file_util.dart';
import '../../../common/widgets/extend_image.dart';
import '../../../common/widgets/imageview/image_preview_page.dart';
import '../../../common/widgets/imageview/image_preview_view.dart';
import '../../conversion/widget/dialog_util.dart';
import '../../../common/widgets/chat/functions.dart';
import '../../conversion/widget/object_util.dart';

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}
class PeerChatItemWidget extends StatefulWidget {
  final Message entity;
  final OnItemClick onResend;
  final OnItemClick onItemClick;
  final OnItemClick onItemLongClick;
  final OnMenuItemClick onMenuItemClick;
  final String  tfSender;
  PeerChatItemWidget({required this.entity,required this.onResend, required this.onItemClick,required this.onItemLongClick,  required this.tfSender, required this.onMenuItemClick});
  @override
  PeerChatItemWidgetState createState() => PeerChatItemWidgetState();
}

class PeerChatItemWidgetState extends State<PeerChatItemWidget> {
  CustomPopupMenuController _controller = CustomPopupMenuController();
  List<ItemModel> menuItems = [
    ItemModel('撤回', Icons.content_copy),
    ItemModel('转发', Icons.send),
    ItemModel('收藏', Icons.collections),
    ItemModel('删除', Icons.delete),
    ItemModel('多选', Icons.playlist_add_check),
    ItemModel('引用', Icons.format_quote),
    ItemModel('提醒', Icons.add_alert),
    ItemModel('搜一搜', Icons.search),
  ];

  Widget _buildLongPressMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          crossAxisCount: 5,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: menuItems.asMap().entries
              .map((item) => GestureDetector(
            onTap: (){
              debugPrint("onTap Menu"+item.key.toString());
              widget.onMenuItemClick(widget.entity,item.key);
              _controller.hideMenu();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  item.value.icon,
                  size: 35.sp,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 4.h),
                  child: Text(
                    item.value.title,
                    style: TextStyle(color: Colors.white, fontSize: 24.sp),
                  ),
                ),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
  FltImPlugin im = FltImPlugin();
  @override
  Widget build(BuildContext context) {
    return _chatItemWidget(widget.entity,widget.onResend,widget.onItemClick,widget.onItemLongClick,widget.tfSender);
  }

  Widget _chatItemWidget(Message entity, OnItemClick onResend, OnItemClick onItemClick,OnItemClick onItemLongClick,String tfSender) {
    if (entity.type == MessageType.MESSAGE_REVOKE) {
      return buildRevokeWidget(entity,tfSender);
    }
    if (entity.sender == tfSender) {
   {
     double hs =10.w;
     if (entity.type == MessageType.MESSAGE_TEXT) {
       hs = 50.w;
       if ((entity.content!['text'] != null && entity.content!['text'].contains('assets/images/face') )||
           (entity.content!['text'] != null && entity.content!['text'].contains('assets/images/figure'))) {
         hs = -150.w;
       }
     } else if (entity.type == MessageType.MESSAGE_IMAGE) {
       hs = -150.w;
     }
      //自己的消息
      return Container(
        margin: EdgeInsets.only(left: 40.w, right: 10.w, bottom: 6.h, top: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //显示是否重发1、发送2中按钮，发送成功0或者null不显示
            (entity.flags == 0 || entity.flags == 8)
                ? IconButton(
                icon: Icon(Icons.error, color: Colors.red, size: 18.sp),
                onPressed: () {
                  onResend(entity);
                })
                : ((entity.flags == 1)
                ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20.h, right: 20.w),
              width: 32.w,
              height: 32.h,
              child: SizedBox(
                  width: 12.w,
                  height: 12.h,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Colors.blue),
                    strokeWidth: 2,
                  )),
            )
                :  SizedBox(
              width: 10.w,
            )),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h, top: 0.h),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CustomPopupMenu(
                        controller: _controller,
                        child: _contentWidget(entity,tfSender),
                        menuBuilder: _buildLongPressMenu,
                        barrierColor: Colors.transparent,
                        pressType: PressType.longPress,
                        verticalMargin:1.h,
                        horizontalMargin:hs,
                      )
                      // GestureDetector(
                      //   child: _contentWidget(entity,tfSender),
                      //   onTap: () {
                      //     onItemClick(entity);
                      //   },
                      //   onLongPress: () {
                      //     onItemLongClick(entity);
                      //
                      //   },
                      // ),

                    ],
                  ),
                )),
            SizedBox(width: 10.w),
            _headPortrait('', 0),
          ],
        ),
      );
    }



    } else {
      //其他人的消息
      return Container(
        margin: EdgeInsets.only(left: 10.w, right: 40.w, bottom: 6.h, top: 0.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headPortrait('', 1),
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.w, right: 0.w, bottom: 0.h, top: 0.h),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: _contentWidget(entity,tfSender),
                        onTap: () {
                          onItemClick(entity);
                        },
                        // onLongPress: () {
                        //   if (null != onItemClick) {
                        //     onItemLongClick(entity);
                        //   }
                        //
                        // },
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
    }
  }


  /*
  *  头像
  */
  Widget _headPortrait(String url, int owner) {
    return Container(
        width: 88.w,
        height: 88.h,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white
        ),

      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: url.isEmpty
              ? Image.asset(

              (owner == 1
                  ? FileUtil.getImagePath('ic_user_female',
                  dir: 'default', format: 'png')
                  : FileUtil.getImagePath('ic_user_male',
                  dir: 'default', format: 'png')),
            fit: BoxFit.cover,
             )
              : (ObjectUtil.isNetUri(url)
              ? Image.network(
            url,
            fit: BoxFit.cover,
          )
              : Image.asset(url))),
    );
  }

  /*
  *  内容
  */
  Widget _contentWidget(Message entity,String tfSender) {
    Widget widget;
    if (entity.type == MessageType.MESSAGE_TEXT) {
      //文本
      if ((entity.content!['text'] != null && entity.content!['text'].contains('assets/images/face') )||
          (entity.content!['text'] != null && entity.content!['text'].contains('assets/images/figure'))) {
        widget = buildImageWidget(entity,tfSender);
      } else {
        if(entity.content!['text'] == null) {
          entity.content!['text'] ="err";
        }
        widget = buildTextWidget(entity,tfSender);
      }

    } else if (entity.type == MessageType.MESSAGE_IMAGE) {
      widget = buildImageWidget(entity,tfSender);
    }else if (entity.type == MessageType.MESSAGE_AUDIO) {
      widget = buildVoiceWidget(entity,tfSender);
    }else if (entity.type == MessageType.MESSAGE_REVOKE) {
      widget = buildRevokeWidget(entity,tfSender);
    } else {
      widget = ClipRRect(
        borderRadius: BorderRadius.circular(12.w),
        child: Container(
          padding: EdgeInsets.all(15.h),
          color: ObjectUtil.getThemeLightColor(),
          child: Text(
            '未知消息类型',
            style: TextStyle(fontSize: 30.sp, color: Colors.black),
          ),
        ),
      );
    }
    return widget;
  }
  Widget buildRevokeWidget(Message entity,String  tfSender) {
    var type = entity.content!['notificationType'];
    //var raw = json.decode(entity.content['raw']);
    String content ="";

   content = entity.sender == tfSender ?"你撤回了一条消息" : entity.sender + "撤回了一条消息";

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
        color:  Colors.transparent,
        child: Text(
          content,
          style: TextStyle(fontSize: 28.sp, color: Colors.black45),
        ),
      ),
    );
  }
  Widget buildTextWidget(Message entity,String  tfSender) {

    return Container(
      padding: EdgeInsets.only(top: 12.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.w),
        child: Container(
          padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
          color: entity.sender == tfSender
              ?const Color.fromARGB(255, 158, 234, 106)
              : Colors.white,
          child: Text(
            entity.content!['text'],
            style: TextStyle(fontSize: 32.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
  Widget buildGroupNotifitionWidget(Message entity,String  tfSender) {
    var type = entity.content!['notificationType'];
    //var raw = json.decode(entity.content['raw']);
    String content ="";
    if(type==7){
      if(entity.content!['mute']==1){
        content =entity.content!['member'].toString()+ "被管理员禁言";
      }else{
        content =entity.content!['member'].toString()+ "被管理员解除禁言";
      }


    }


    return ClipRRect(
      borderRadius: BorderRadius.circular(16.w),
      child: Container(
        padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 16.h, bottom: 16.h),
        color:  Colors.transparent,
        child: Text(
          content,
          style: TextStyle(fontSize: 28.sp, color: Colors.black45),
        ),
      ),
    );
  }
  Widget buildImageWidget(Message message,String  tfSender) {
    int isFace =0;
    //图像
    double width = ValueUtil.toDouble(message.content!['width']);
    double height = ValueUtil.toDouble(message.content!['height']);
    String imageURL = ValueUtil.toStr(message.content!['imageURL']);
    if (imageURL.isEmpty) {
      imageURL = ValueUtil.toStr(message.content!['url']);
    }
    double size = 240.w;
    Widget? image;
    if (message.type== MessageType.MESSAGE_TEXT&&
        message.content!['text'].contains('assets/images/face')) {
      //assets/images/face中的表情
      size = 50.w;
      image = Image.asset(message.content!['text'], width: size, height: size);
      isFace=1;
    } else if (message.type== MessageType.MESSAGE_TEXT &&
        message.content!['text'].contains('assets/images/figure')) {
      //assets/images/figure中的表情
      size = 240.w;
      image = Image.asset(message.content!['text'], width: size, height: size);
      isFace=1;
    }
    return _buildWrapper(
      isSelf: message.sender== tfSender,
      message: message,
      child: isFace==1?
      ClipRRect(
        borderRadius: BorderRadius.circular(8.w),
        child: Container(
          padding: EdgeInsets.all((message.content!['text'].isNotEmpty &&
              message.content!['text'].contains('assets/images/face'))
              ? 10.w
              : 0),
          color: message.sender == tfSender
              ? Colors.white
              : const Color.fromARGB(255, 158, 234, 106),
          child: image,
        ),
      ):

      Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
          ),
          width: 200.w,
          height: 200.h,
          child: GestureDetector(
            child: buildLocalImageWidget(imageURL),
            // Image.network(imageURL),
            onTap: () {
              try{
                ImagePreview.preview(
                  images: List.generate(1, (index) {
                    return ImageOptions(
                      url: imageURL,
                      tag: imageURL,
                    );
                  }),
                );
              }catch(e){
                debugPrint(e.toString());
              }

            },
            onLongPress: () {
              DialogUtil.buildToast('长按了消息');
            },
          )

      ),
    );
  }

  Widget buildLocalImageWidget(String imageURL) {
    if (imageURL.startsWith("http://localhost")) {
      return FutureBuilder(
        future: getLocalCacheImage(url: imageURL),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          if (snapshot.hasData) {
            return Image.memory(snapshot.data as Uint8List,fit: BoxFit.cover,);
          } else {
            if (imageURL.startsWith("http://localhost")) {
              return Container();
            } else if (imageURL.startsWith('file:/')) {
              return Image.file(File(imageURL),fit: BoxFit.cover,);
            }
            return Image.network(imageURL,fit: BoxFit.cover,);
          }
        },
      );
    } else if (imageURL.startsWith('file:/')) {
      return Image.file(File(imageURL.substring(6)),fit: BoxFit.cover,);
    }
    return getCacheImage(
      imageURL,
    );
  }

  Future<Uint8List> getLocalCacheImage({required String url}) async {

    Map? result = await im.getLocalCacheImage(url: url);
    NativeResponse response = NativeResponse.fromMap(result!);
    return response.data;
  }
  Future<Uint8List> getLocalMediaURL({required String url}) async {

    Map? result = await im.getLocalMediaURL(url: url);
    NativeResponse response = NativeResponse.fromMap(result!);
    return response.data;
  }



  // Future<File> _getLocalFile(String filename) async {
  //   String dir = (await getExternalStorageDirectory()).path;
  //   File f = new File('$dir/$filename');
  //   return f;
  // }
  _buildWrapper({required bool isSelf, required Message message, required Widget child}) {
    return Container(
      margin: EdgeInsets.all(1.w),
      child: Row(
        mainAxisAlignment: isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [

          Container(
            child: child,
          ),

        ],
      ),
    );
  }
  Widget buildVoiceWidget(Message entity,String  tfSender) {
    double width;
    if (entity.content!['duration'] < 5) {
      width = 160.w;
    } else if (entity.content!['duration'] < 10) {
      width = 240.w;
    } else if (entity.content!['duration'] < 20) {
      width = 280.w;
    } else {
      width = 300.w;
    }
    return Container(
      padding: EdgeInsets.only( top: 15.w),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 10.w),
                width: width,
                color: entity.sender == tfSender
                    ? Colors.white
                    : const Color.fromARGB(255, 158, 234, 106),
                child: Row(
                  mainAxisAlignment: entity.sender == tfSender
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: <Widget>[
                    entity.sender == tfSender
                        ? Text('')
                        : Text((entity.content!['duration']).toString() + 's',
                        style: TextStyle(fontSize: 32.sp, color: Colors.black)),
                    SizedBox(
                      width: 10.w,
                    ),
                    entity.playing == 1
                        ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 2.h, right: 2.h),
                      width: 36.w,
                      height: 60.w,
                      child: SizedBox(
                          width: 28.w,
                          height: 28.h,
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation(Colors.black),
                            strokeWidth: 4.w,
                          )),
                    )
                        : Image.asset(
                      FileUtil.getImagePath('audio_player_3',
                          dir: 'icon', format: 'png'),
                      width: 36.w,
                      height: 60.w,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    entity.sender == tfSender
                        ? Text((entity.content!['duration']).toString() + 's',
                        style: TextStyle(fontSize: 36.sp, color: Colors.black))
                        : Text(''),
                  ],
                )),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 60.h, bottom: 10.h),
          //   width: width,
          //   child: const LinearProgressIndicator(
          //     value: 0.3,
          //     valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          //     backgroundColor: Colors.transparent,
          //   ),
          // ),


        ],
      ),
    );
  }

  freshChatAck({required int status}) {
    setState(() {
      widget.entity.flags =2;
    });
  }

}
