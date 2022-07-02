import 'dart:async';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_ckt/common/routers/routes.dart';
import 'package:flutter_ckt/common/utils/utils.dart';
import 'package:flutter_ckt/common/values/values.dart';
import 'package:flutter_ckt/pages/conversion/logic.dart';
import 'package:flutter_ckt/pages/peer_chat/logic.dart';
import 'package:get/get.dart';

import 'package:uni_links/uni_links.dart';

import 'index.dart';

class OAApplicationController extends GetxController {
  OAApplicationController();


  /// 响应式成员变量

  final state = ApplicationState();

  /// 成员变量

  // tab 页标题
  late final List<String> tabTitles;

  // 页控制器
  late final PageController pageController;

  // 底部导航项目
  late final List<BottomNavigationBarItem> bottomTabs;
  late String tfSender;

  /// 事件

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.jumpToPage(index);
    // pageController.animateToPage(index,
    //     duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page = page;
  }

  /// scheme 内部打开
  bool isInitialUriIsHandled = false;
  StreamSubscription? uriSub;

  // 第一次打开
  Future<void> handleInitialUri() async {
    if (!isInitialUriIsHandled) {
      isInitialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          debugPrint('no initial uri');
        } else {
          // 这里获取了 scheme 请求
          debugPrint('got initial uri: $uri');
        }
      } on PlatformException {
        debugPrint('falied to get initial uri');
      } on FormatException catch (err) {
        debugPrint('malformed initial uri, ' + err.toString());
      }
    }
  }

  // 程序打开时介入
  void handleIncomingLinks() {
    if (!kIsWeb) {
      uriSub = uriLinkStream.listen((Uri? uri) {
        // 这里获取了 scheme 请求
        debugPrint('got uri: $uri');

        // if (uri!.pathSegments[1].toLowerCase() == 'category') {
        if (uri != null && uri.path == '/notify/category') {
          Get.toNamed(AppRoutes.Category);
        }
      }, onError: (Object err) {
        debugPrint('got err: $err');
      });
    }
  }

  /// 生命周期

  @override
  Future<void> onInit() async {
    pageController = PageController(initialPage: state.page);
    tabTitles = ['我的', '工作', '个人中心'];
    bottomTabs = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.home,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.home,
          color: AppColors.secondaryElementText,
        ),
        label: '我的',
        backgroundColor: AppColors.primaryBackground,
      ),
      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.grid,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.grid,
          color: AppColors.secondaryElementText,
        ),
        label: '工作',
        backgroundColor: AppColors.primaryBackground,
      ),

      const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.me,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.me,
          color: AppColors.secondaryElementText,
        ),
        label: '个人中心',
        backgroundColor: AppColors.primaryBackground,
      ),
    ];

    super.onInit();


  }

  @override
  void dispose() {
    uriSub?.cancel();
    pageController.dispose();
    super.dispose();
  }



  onPeerMessageFailure(Map result) {
    // IMMessage
  }

  /// OutboxObserver
  onImageUploadSuccess(Map result, String url) {
    debugPrint(url);

    ///IMessage
  }

  onAudioUploadSuccess(Map result, String url) {
    /// IMessage
  }

  onAudioUploadFail(Map result) {
    //IMessage
  }

  onImageUploadFail(Map result) {
    // IMessage
  }

  onVideoUploadSuccess(Map result, url, thumbnailURL) {}

  onVideoUploadFail(Map result) {}

  /// AudioDownloaderObserver
  onAudioDownloadSuccess(Map result) {
    // IMessage
  }

  onAudioDownloadFail(Map result) {
    //IMessage
  }

  void onPeerMessage(result) {
    Map<String, dynamic> message = Map<String, dynamic>.from(result);
    String title = "通知";
    String content = "消息";
    var type = message['type'];
    if (type == "MESSAGE_TEXT") {
      title = "通知";
      content = message['content']['text'];
    } else {
      title = "通知";
      content = '聊天消息';
    }

    var conversionLogic = Get.find<ConversionLogic>();
    conversionLogic.receiveMsgFresh();
    bool gg =Get.isRegistered<PeerChatLogic>();
    if (gg){
      var peerChatLogic = Get.find<PeerChatLogic>();
        peerChatLogic.receiveMsgFresh();
    }


    //_showNotification(title,content);
    //BlocProvider.of<PeerBloc>(context).add(EventReceiveNewMessage(message));
  }
  void onPeerMessageACK(result, int error) {
    Map<String, dynamic> m = Map<String, dynamic>.from(result);
    bool gg =Get.isRegistered<PeerChatLogic>();
    if (gg){
      var peerChatLogic = Get.find<PeerChatLogic>();
      peerChatLogic.receiveMsgAck(m);
    }
    //BlocProvider.of<PeerBloc>(context).add(EventReceiveNewMessageAck(m));
  }


  void onPeerSecretMessage(result) {

  }

  void onNewMessage(result, int error) async {
    var count = 1;
    //Map response = await im.getConversations();
    //var  conversions = response["data"];
    // conversions.map((e) {
    //   if (e['unreadCount'] > 0){
    //     count=count+e['unreadCount'];
    //   }
    // }).toList();

    //BlocProvider.of<GlobalBloc>(context).add(EventSetBar3(count));
    //BlocProvider.of<ChatBloc>(context).add(EventNewMessage());
  }

  void onNewGroupMessage(result, int error) async {
    var count = 1;
    debugPrint(result);
    //Map response = await im.getConversations();
    //var  conversions = response["data"];
    // conversions.map((e) {
    //   if (e['unreadCount'] > 0){
    //     count=count+e['unreadCount'];
    //   }
    // }).toList();

    //BlocProvider.of<GlobalBloc>(context).add(EventSetBar3(count));
    //BlocProvider.of<ChatBloc>(context).add(EventNewMessage());
  }

  void onGroupNotification(result) async {
    debugPrint(result);
    Map<String, dynamic> message = Map<String, dynamic>.from(result);
    //BlocProvider.of<GroupBloc>(context)
    //    .add(EventGroupReceiveNewMessage(message));
    onNewGroupMessage(result, 0);
  }

  void deletePeerMessageSuccess(result, id) async {
    debugPrint(result);
    //BlocProvider.of<PeerBloc>(context).add(EventDeleteMessage(id));
    onNewMessage(result, 0);
  }


}
