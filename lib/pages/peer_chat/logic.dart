import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:get/get.dart';

import 'state.dart';

class PeerChatLogic extends GetxController {
  final PeerChatState state = PeerChatState();
  FltImPlugin im = FltImPlugin();
  Conversion model = Get.arguments;
  String memId = "";
  List<Message> messageList = <Message>[];

  @override
  void onInit() {
    eventFirstLoadMessage();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> receiveMsgFresh() async {
    try {
      Map<String, dynamic> messageMap = {};
      FltImPlugin im = FltImPlugin();
      var res = await im.createConversion(
        currentUID: model.memId!,
        peerUID: model.cid!,
      );
      Map? response = await im.loadData(messageID: '0');
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList()
          .reversed
          .toList();
      messages.map((e) {
        e.content!['text'] = (e.content!['text']);
        return e;
      }).toList();
      messageList.clear();
      messageList.addAll(messages);
      update();
    } catch (err) {
      print(err);
    }
  }

  Future<void> receiveMsgAck(Map<String, dynamic> m) async {
    try {
      messageList = messageList.map((item) {
        if (item.msgLocalID == m['msgLocalID']) {
          item.flags = 2;
          return item;
        } else {
          return item;
        }
      }).toList();
      //messageList.clear();
      //messageList.addAll(messages);
      update();
    } catch (err) {
      print(err);
    }
  }

  Future<void> eventFirstLoadMessage() async {
    try {
      Map<String, dynamic> messageMap = {};
      FltImPlugin im = FltImPlugin();
      var res = await im.createConversion(
        currentUID: model.memId!,
        peerUID: model.cid!,
      );
      Map? response = await im.loadData(messageID: '0');
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList()
          .reversed
          .toList();
      messages.map((e) {
        e.content!['text'] = (e.content!['text']);
        return e;
      }).toList();
      messageList.addAll(messages);
      update();
    } catch (err) {
      print(err);
    }
  }

  void sendTextMessage(String content) async {
    Map? result = await im.sendTextMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      rawContent: content,
    );
    setMessageFlag(result!);
  }

  void sendImgMessage(Uint8List content) async {
    Map? result = await im.sendImageMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      image: content,
    );
    setMessageFlag(result!);
  }

  sendVoiceMessage(File file, int length) async {
    Map? result = await im.sendAudioMessage(
        secret: false,
        sender: model.memId!,
        receiver: model.cid!,
        path: file.path,
        second: length);
    setMessageFlag(result!);
  }
  void sendRevokeMessage(Message entity) async {
    String uuid ;
    uuid =entity.content!['uuid'];
    Map? result = await im.sendRevokeMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      uuid: uuid,
    );

    revokeMessageLocalDelete(uuid,result!);
    update();
  }
  setMessageFlag(Map result){

    var message = Message.fromMap(ValueUtil.toMap(result['data']));
    messageList.insert(0, message);
    for (var i = 0; i < messageList.length; i++) {
      if (i == 0) {
        messageList[i].flags = 1;
      }
    }

    update();
  }
  revokeMessageLocalDelete(String uuid, Map result){

    var message = Message.fromMap(ValueUtil.toMap(result['data']));
    for (var i = 0; i < messageList.length; i++) {
      String uuids ;
      uuids =messageList[i].content!['uuid'];
      if (uuids == uuid) {
        var f = messageList[i];
        message.timestamp = f.timestamp;
        messageList[i] = message;
      }
    }
    update();
  }
}
