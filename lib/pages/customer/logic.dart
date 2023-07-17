import 'dart:io';

import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../common/apis/common.dart';
import '../../common/utils/chat_util.dart';
import 'state.dart';

class CustomerLogic extends GetxController {
  final CustomerState state = CustomerState();

  FltImPlugin im = FltImPlugin();
  Conversion model = Get.arguments;
  String memId = "";
  bool finish = false;
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
      var res = await im.createCustomerConversion(
        currentUID: model.memId!,
        peerUID: model.cid!,
      );
      Map? response = await im.loadCustomerData(appId:model.appid!,uid:model.cid!,messageID: '0');
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
      var res = await im.createCustomerConversion(
        currentUID: model.memId!,
        peerUID: model.cid!,
      );
      Map? response = await im.loadCustomerData(appId:model.appid!,uid:model.cid!,messageID: '0');
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList()
          .reversed
          .toList();
      messages.map((e) {
        e.content!['text'] = (e.content!['text']);
        return e;
      }).toList();
      messageList.addAll(removeElement(messages));
      update();
    } catch (err) {
      print(err);
    }
  }

  Future<void> eventLoadMoreMessage() async {
    try {
      Map<String, dynamic> messageMap = {};
      FltImPlugin im = FltImPlugin();
      var res = await im.createCustomerConversion(
        currentUID: model.memId!,
        peerUID: model.cid!,
      );
      var localId = messageList.last.msgLocalID.toString();
      Map? response = await im.loadCustomerEarlierData(appId:model.appid!,uid:model.cid!,messageID: localId);
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList();
      messages.map((e) {
        e.content!['text'] = (e.content!['text']);
        return e;
      }).toList();
      if (messages.length == 0) {
        finish = true;
      }
      messages.addAll(messageList.reversed.toList());
      messageList = removeElement(messages.reversed.toList());
      update();
    } catch (err) {
      print(err);
    }
  }

  void sendTextMessage(String content) async {
    Map? result = await im.sendFlutterCustomerTextMessage(
      secret: false,
      sender_appid: "1",
      sender: model.memId!,
      receiver_appid: model.appid!,
      receiver: model.cid!,
      rawContent: content,
    );
    setMessageFlag(result!);
  }

  void sendImgMessage(String path) async {
    EasyLoading.show(status: "上传中", maskType: EasyLoadingMaskType.none);
    var uuids = Uuid();
    var uuid = uuids.v4();
    var url = await CommonAPI.uploadAppFile(1, path,uuid+".jpg");
    Map? result = await im.sendFlutterCustomerImageMessage(
        secret: false,
        sender_appid: "1",
        sender: model.memId!,
        receiver_appid: model.appid!,
        receiver: model.cid!,
        path: url.data!,
        thumbPath: url.data!);
    setMessageFlag(result!);
  }

  sendVoiceMessage(File file, int length) async {
    var uuids = Uuid();
    var uuid = uuids.v4();
    //EasyLoading.show(status: "上传中",maskType: EasyLoadingMaskType.none);
    var url = await CommonAPI.uploadAppFile(1, file.path,uuid+".mp3");
    Map? result = await im.sendFlutterCustomerAudioMessage(
        secret: false,
        sender_appid: "1",
        sender: model.memId!,
        receiver_appid: model.appid!,
        receiver: model.cid!,
        path: url.data!,
        second: length);
    setMessageFlag(result!);
  }

  void sendRevokeMessage(Message entity) async {
    String uuid;
    uuid = entity.content!['uuid'];
    Map? result = await im.sendCustomerRevokeMessage(
      sender_appid: "1",
      sender: model.memId!,
      receiver_appid: model.appid!,
      receiver: model.cid!,
      uuid: uuid,
    );
    revokeMessageLocalDelete(uuid, result!);
    update();
  }

  setMessageFlag(Map result) {
    var message = Message.fromMap(ValueUtil.toMap(result['data']));
    messageList.insert(0, message);
    for (var i = 0; i < messageList.length; i++) {
      if (i == 0) {
        messageList[i].flags = 1;
      }
    }
    update();
  }

  revokeMessageLocalDelete(String uuid, Map result) {
    var message = Message.fromMap(ValueUtil.toMap(result['data']));
    for (var i = 0; i < messageList.length; i++) {
      String uuids;
      if(messageList[i].content!['uuid'] ==null){
        continue;
      }
      uuids = messageList[i].content!['uuid'];
      if (uuids == uuid) {
        var f = messageList[i];
        message.timestamp = f.timestamp;
        messageList[i] = message;
      }
    }
    update();
  }

}
