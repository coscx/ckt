import 'package:flt_im_plugin/conversion.dart';
import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter_ckt/common/routers/names.dart';
import 'package:flutter_ckt/common/services/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/apis/common.dart';
import '../../common/utils/chat_util.dart';
import 'state.dart';

class ConversionLogic extends GetxController {
  final ConversionState state = ConversionState();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var popString = ['清空记录', '删除好友', '加入黑名单'];
  int offset = 0;
  int limit = 10; //一次加载10条数据,不建议加载太多。
  String memberId = StorageService.to.getString("im_sender");

  void onRefresh() async {
    FltImPlugin im = FltImPlugin();
    Map? response = await im.getConversations();
    var conversions = ValueUtil.toArr(response!["data"])
        .map((e) => Conversion.fromMap(ValueUtil.toMap(e)))
        .toList();
    conversions.map((e) {
      e.detail = (e.detail);
      return e;
    }).toList();
    state.conversion.clear();
    state.conversion.addAll(conversions);
    offset = 0;
    refreshController.refreshCompleted();
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  @override
  void onReady() {
    //init();
    super.onReady();
  }

  void onTapDeleteConversion(String rowid,String cid,ConversionType? type,String appid) {
    FltImPlugin im = FltImPlugin();
    if (type == ConversionType.CONVERSATION_GROUP) {
      im.deleteConversation(rowid: rowid,cid: cid,appid: "0");
    } else if (type == ConversionType.CONVERSATION_PEER) {
      im.deleteConversation(rowid: rowid,cid: cid,appid: "0");
    }
    else if (type == ConversionType.CONVERSATION_CUSTOMER_SERVICE) {
      im.deleteConversation(rowid: rowid,cid: cid,appid: appid);
    }
  }

  Future<void> receiveMsgFresh() async {
    FltImPlugin im = FltImPlugin();
    Map? response = await im.getConversations();
    var conversions = ValueUtil.toArr(response!["data"])
        .map((e) => Conversion.fromMap(ValueUtil.toMap(e)))
        .toList();
    conversions.map((e) async {
      if (e.type == ConversionType.CONVERSATION_GROUP) {
        if (e.cid! !=""){
          e.name =await getGroupName(e.cid!);
        }
        if (e.message?.sender != "") {
          e.memId = await getPeerName(e.message!.sender);
          e.sex = getPeerSex(e.message!.sender);
        }
      } else if (e.type == ConversionType.CONVERSATION_PEER) {
        if (e.cid! !=""){
          e.name =await getPeerName(e.cid!);
          e.sex = getPeerSex(e.cid!);
        }
      }
      return e;
    }).toList();

    state.conversion.clear();
    state.conversion.addAll(conversions);
  }

  void onTap(Conversion msg) {
    FltImPlugin im = FltImPlugin();
    List<Conversion> messages;
    if (msg.type == ConversionType.CONVERSATION_GROUP) {
      im.clearGroupReadCount(cid: msg.cid!);
      var message = state.conversion.map((e) {
        if (e.type == ConversionType.CONVERSATION_GROUP) {
          e.newMsgCount = 0;
          return e;
        } else {
          return e;
        }
      }).toList();
      //state.conversion.addAll(message);
    }

    if (msg.type == ConversionType.CONVERSATION_PEER) {
      im.clearReadCount(cid: msg.cid!);
      var message = state.conversion.map((e) {
        if (e.type == ConversionType.CONVERSATION_PEER) {
          e.newMsgCount = 0;
          return e;
        } else {
          return e;
        }
      }).toList();
      // state.conversion.addAll(message);
    }
    if (msg.type == ConversionType.CONVERSATION_CUSTOMER_SERVICE) {
      im.clearCustomerReadCount(appid:msg.appid!,cid: msg.cid!);
      var message = state.conversion.map((e) {
        if (e.type == ConversionType.CONVERSATION_CUSTOMER_SERVICE) {
          e.newMsgCount = 0;
          return e;
        } else {
          return e;
        }
      }).toList();
      // state.conversion.addAll(message);
    }
    var count = 0;
    state.conversion.map((e) {
      count += e.newMsgCount!;
    }).toList();
    if (count == 0) {
      //BlocProvider.of<GlobalBloc>(context).add(EventSetBar3(0));
    }
    var memberId = StorageService.to.getString("memberId");
    if (memberId != "") {
      memberId = memberId.toString();
    }

    final Conversion model = Conversion.fromMap(
        {"memId": memberId, "cid": msg.cid, "name": msg.name,"appid":msg.appid});
    if (msg.type == ConversionType.CONVERSATION_GROUP) {
      receiveMsgFresh();
      var name = StorageService.to.getString("group_" + msg.cid.toString());
      if (name != "") {
        model.name = name;
      }
      Get.toNamed(AppRoutes.GroupChat, arguments: model);
    }
    if (msg.type == ConversionType.CONVERSATION_PEER) {
      receiveMsgFresh();
      var name = StorageService.to.getString("peer_" + msg.cid.toString());
      if (name != "") {
        model.name = name;
      }
      Get.toNamed(AppRoutes.Peer, arguments: model);
    }
    if (msg.type == ConversionType.CONVERSATION_CUSTOMER_SERVICE) {
      receiveMsgFresh();
      var name = StorageService.to.getString("peer_" + msg.cid.toString());
      if (name != "") {
        model.name = name;
      }
      Get.toNamed(AppRoutes.Customer, arguments: model);
    }
  }

  Future<void> init() async {
    FltImPlugin im = FltImPlugin();
    Map? response = await im.getConversations();
    var conversions = ValueUtil.toArr(response!["data"])
        .map((e) => Conversion.fromMap(ValueUtil.toMap(e)))
        .toList();
    conversions.map((e) async {
      if (e.type == ConversionType.CONVERSATION_GROUP) {
        if (e.cid! !=""){
          e.name =await getGroupName(e.cid!);
        }
        if (e.message?.sender != "") {
          e.memId = await getPeerName(e.message!.sender);
          e.sex = getPeerSex(e.message!.sender);
        }
      } else if (e.type == ConversionType.CONVERSATION_PEER) {
        if (e.cid! !=""){
          e.name =await getPeerName(e.cid!);
          e.sex = getPeerSex(e.cid!);
        }
      }
      return e;
    }).toList();

    state.conversion.clear();
    state.conversion.addAll(conversions);
  }

  Future<void> _init() async {
    FltImPlugin im = FltImPlugin();
    Map? response = await im.getConversations();
    var conversions = ValueUtil.toArr(response!["data"])
        .map((e) => Conversion.fromMap(ValueUtil.toMap(e)))
        .toList();
    for (int i = 0; i < conversions.length; i++) {
      var e = conversions[i];
      if (e.type == ConversionType.CONVERSATION_GROUP) {
        if (e.cid! !=""){
          e.name =await getGroupName(e.cid!);
        }
        if (e.message?.sender != "") {
          e.memId = await getPeerName(e.message!.sender);
          e.sex = getPeerSex(e.message!.sender);
        }
      } else if (e.type == ConversionType.CONVERSATION_PEER) {
        if (e.cid! !=""){
          e.name = await getPeerName(e.cid!);
          e.sex = getPeerSex(e.cid!);
        }
      }
    }
    state.conversion.clear();
    state.conversion.addAll(conversions);
  }


}
