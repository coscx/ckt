import 'dart:io';
import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/message.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../common/apis/common.dart';
import '../../common/utils/chat_util.dart';
import 'state.dart';

class GroupChatLogic extends GetxController {
  final GroupChatState state = GroupChatState();
  FltImPlugin im = FltImPlugin();
  Conversion model = Get.arguments;
  String memId = "";
  List<Message> messageList = <Message>[];
  bool finish = false;
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
      var res = await im.createGroupConversion(
        currentUID: model.memId!,
        groupUID: model.cid!,
      );
      Map? response = await im.loadData(messageID: '0');
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList()
          .reversed
          .toList();
      messages.map((e) async {
        e.content!['text'] = (e.content!['text']);
        e.sendInfo?.name = await getPeerName(e.sender);
        e.sendInfo?.identifier= getPeerSex(e.sender).toString();
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
      var res = await im.createGroupConversion(
        currentUID: model.memId!,
        groupUID: model.cid!,
      );
      Map? response = await im.loadData(messageID: '0');
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList()
          .reversed
          .toList();
      messages.map((e) async {
        e.content!['text'] = (e.content!['text']);
        e.sendInfo?.name = await getPeerName(e.sender);
        e.sendInfo?.identifier= getPeerSex(e.sender).toString();
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
      var res = await im.createGroupConversion(
        currentUID: model.memId!,
        groupUID: model.cid!,
      );
      var localId = messageList.last.msgLocalID.toString();
      Map? response = await im.loadEarlierData(messageID: localId);
      var messages = ValueUtil.toArr(response!["data"])
          .map((e) => Message.fromMap(ValueUtil.toMap(e)))
          .toList();
      messages.map((e) {
        e.content!['text'] = (e.content!['text']);
        return e;
      }).toList();
      if (messages.length == 0) {
        finish = true;
        return;
      }
      messages.addAll(messageList.reversed.toList());
      messageList = removeElement(messages.reversed.toList());
      update();
    } catch (err) {
      print(err);
    }
  }

  void sendTextMessage(String content) async {
    Map? result = await im.sendGroupTextMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      rawContent: content,
    );
    setMessageFlag(result!);
  }
  void sendRevokeMessage(Message entity) async {
    String uuid ;
    uuid =entity.content!['uuid'];
    Map? result = await im.sendGroupRevokeMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      uuid: uuid,
    );
    revokeMessageLocalDelete(uuid,result!);
    update();
  }
  void sendImgMessage(String path) async {
    var uuids = Uuid();
    var uuid = uuids.v4();
    var url = await CommonAPI.uploadAppFile(1, path,uuid+".jpg");
    Map? result = await im.sendFlutterGroupImageMessage(
      secret: false,
      sender: model.memId!,
      receiver: model.cid!,
      path: url.data!,
      thumbPath: url.data!,
    );
    setMessageFlag(result!);
  }

  sendVoiceMessage(File file, int length) async {
    Map? result = await im.sendGroupAudioMessage(
        secret: false,
        sender: model.memId!,
        receiver: model.cid!,
        path: file.path,
        second: length);
    setMessageFlag(result!);
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
