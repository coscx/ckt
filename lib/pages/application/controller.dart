import 'dart:async';
import 'dart:io';

import 'package:flt_im_plugin/flt_im_plugin.dart';
import 'package:flt_im_plugin/value_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_ckt/common/apis/common.dart';
import 'package:flutter_ckt/common/routers/routes.dart';
import 'package:flutter_ckt/common/utils/utils.dart';
import 'package:flutter_ckt/common/values/values.dart';
import 'package:flutter_ckt/pages/conversion/logic.dart';
import 'package:flutter_ckt/pages/peer_chat/logic.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:umeng_analytics_with_push/umeng_analytics_with_push.dart';
import 'package:uni_links/uni_links.dart';

import '../../common/entities/im/Im_message.dart';
import '../../common/services/storage.dart';
import '../../common/values/key.dart';
import '../../common/widgets/xupdate.dart';
import '../calcucation/view.dart';
import '../channel/view.dart';
import '../conversion/view.dart';
import '../group_chat/logic.dart';
import '../mine/view.dart';
import '../total_user/view.dart';
import 'index.dart';

class ApplicationController extends GetxController {
  ApplicationController();

  /// 响应式成员变量

  final state = ApplicationState();

  /// 成员变量

  // tab 页标题
  List<String> tabTitles = <String>[];
  List<Widget> pages = <Widget>[];

  // 页控制器
  late final PageController pageController;
  late final FltImPlugin im;
  late final CheckUpdate checkUpdate;

  // 底部导航项目
  final List<BottomNavigationBarItem> bottomTabs = <BottomNavigationBarItem>[];
  String tfSender = "";

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
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey != "administration") {
      tabTitles = ['首页', '渠道', '计算器', '消息', '我的'];
      pages = [
        TotalUserPage(),
        ChannelPage(),
        CalcucationPage(),
        ConversionPage(),
        MinePage()
      ];
    } else {
      tabTitles = ['首页', '计算器', '消息', '我的'];
      pages = [
        TotalUserPage(),
        CalcucationPage(),
        ConversionPage(),
        MinePage()
      ];
    }
    pageController = PageController(initialPage: state.page);
    bottomTabs.add(const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.home,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.home,
        color: AppColors.secondaryElementText,
      ),
      label: '首页',
      backgroundColor: AppColors.primaryBackground,
    ));
    if (roleKey != "administration") {
      bottomTabs.add(const BottomNavigationBarItem(
        icon: Icon(
          Iconfont.tag,
          color: AppColors.tabBarElement,
        ),
        activeIcon: Icon(
          Iconfont.tag,
          color: AppColors.secondaryElementText,
        ),
        label: '渠道',
        backgroundColor: AppColors.primaryBackground,
      ));
    }

    bottomTabs.add(const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.grid,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.grid,
        color: AppColors.secondaryElementText,
      ),
      label: '计算器',
      backgroundColor: AppColors.primaryBackground,
    ));
    bottomTabs.add(const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.socialtwitter,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.socialtwitter,
        color: AppColors.secondaryElementText,
      ),
      label: '消息',
      backgroundColor: AppColors.primaryBackground,
    ));
    bottomTabs.add(const BottomNavigationBarItem(
      icon: Icon(
        Iconfont.me,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        Iconfont.me,
        color: AppColors.secondaryElementText,
      ),
      label: '我的',
      backgroundColor: AppColors.primaryBackground,
    ));

    Flutter2dAMap.updatePrivacy(true);
    await Flutter2dAMap.setApiKey(
      iOSKey: flutter2dAMapIOSKey,
      webKey: flutter2dAMapWebKey,
    );
    im = FltImPlugin();
    await im.init(host: IM_SERVER_HOST_URL, apiURL: IM_SERVER_API_URL);
    tfSender = ValueUtil.toStr(82);
    String imSender = StorageService.to.getString("memberId");
    if (imSender != "") {
      tfSender = imSender;
    }

    String imToken = StorageService.to.getString(STORAGE_IM_TOKEN);
    if (imToken == "") {
      login(tfSender, success: () {
        listenNative();
        //BlocProvider.of<ChatBloc>(context).add(EventNewMessage());
      });
    } else {
      loginByToken(imToken, tfSender, success: () {
        listenNative();
        //BlocProvider.of<ChatBloc>(context).add(EventNewMessage());
      });
    }
    Future.delayed(const Duration(seconds: 1)).then((e) async {
      _checkUpdateVersion();
    });
    // handleInitialUri();
    // handleIncomingLinks();
    // 准备一些静态数据
    await UmengAnalyticsWithPush.initialize(
        logEnabled: false, pushEnabled: true);
    try {
      final deviceToken = await UmengAnalyticsWithPush.deviceToken;
      print("push_token: " + deviceToken.toString());
    } catch (e) {
      print(e);
    }
    Future.delayed(const Duration(seconds: 5)).then((e) async {
      var result = await CommonAPI.getUserStatus();
      if (result.code == 402) {
        await StorageService.to.remove("im_token");
        await StorageService.to.remove("memberId");
        await StorageService.to.remove("token");
        await StorageService.to.remove("user_token");
        await StorageService.to.remove("user_profile");
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    uriSub?.cancel();
    pageController.dispose();
    super.dispose();
  }

  login(String tfSender, {void Function()? success}) async {
    if (tfSender == "") {
      debugPrint('发送用户id 必须填写');
      return;
    }
    final res = await FltImPlugin().login(uid: tfSender, token: "");
    debugPrint(res.toString());
    int code = ValueUtil.toInt(res!['code']);
    if (code == 0) {
      success?.call();
      tfSender = "";
    } else {
      String message = ValueUtil.toStr(res['message']);
      debugPrint(message);
    }
  }

  loginByToken(String token, String tfSender,
      {void Function()? success}) async {
    if (tfSender == "") {
      debugPrint('发送用户id 必须填写');
      return;
    }
    final res = await FltImPlugin().login(uid: tfSender, token: token);
    debugPrint(res.toString());
    int code = ValueUtil.toInt(res!['code']);
    if (code == 0) {
      success?.call();
      tfSender = "";
    } else {
      String message = ValueUtil.toStr(res['message']);
      debugPrint(message);
    }
  }

  listenNative() {
    im.onBroadcast.listen((event) {
      NativeResponse response = NativeResponse.fromMap(event);
      Map data = response.data;
      String type = ValueUtil.toStr(data['type']);
      var result = data['result'];
      if (response.code == 0) {
        if (type == 'onNewMessage') {
          //loadConversions();
          int error = ValueUtil.toInt(data['error']);
          onNewMessage(result, error);
        } else if (type == 'onNewGroupMessage') {
          //loadConversions();
          int error = ValueUtil.toInt(data['error']);
          onNewGroupMessage(result, error);
        } else if (type == 'onGroupNotification') {
          onGroupNotification(result);
        } else if (type == 'deletePeerMessageSuccess') {
          deletePeerMessageSuccess(result, data['id']);
        } else if (type == 'onSystemMessage') {
          //loadConversions();
        } else if (type == 'onPeerMessageACK') {
          int error = ValueUtil.toInt(data['error']);
          onPeerMessageACK(result, error);
        } else if (type == 'onPeerMessage') {
          onPeerMessage(result);
        } else if (type == 'onPeerSecretMessage') {
          onPeerSecretMessage(result);
        } else if (type == 'onGroupMessage') {
          onGroupMessage(result);
        } else if (type == 'onGroupMessageACK') {
          onGroupMessageACK(result);
        } else if (type == 'onImageUploadSuccess') {
          String url = ValueUtil.toStr(data['URL']);
          onImageUploadSuccess(result, url);
        } else if (type == 'onAudioDownloadSuccess') {
          onAudioDownloadSuccess(result);
        } else if (type == 'onAudioDownloadFail') {
          onAudioDownloadFail(result);
        } else if (type == 'onPeerMessageFailure') {
          onPeerMessageFailure(result);
        } else if (type == 'onAudioUploadSuccess') {
          String url = ValueUtil.toStr(data['URL']);
          onAudioUploadSuccess(result, url);
        } else if (type == 'onAudioUploadFail') {
          onAudioUploadFail(result);
        } else if (type == 'onImageUploadFail') {
          onImageUploadFail(result);
        } else if (type == 'onVideoUploadSuccess') {
          String url = ValueUtil.toStr(data['URL']);
          String thumbnailURL = ValueUtil.toStr(data['thumbnailURL']);
          onVideoUploadSuccess(result, url, thumbnailURL);
        } else if (type == 'onVideoUploadFail') {
          onVideoUploadFail(result);
        } else if (type == "clearReadCountSuccess") {
        } else {
          debugPrint("onConnect:" + result.toString());
        }
      } else {
        debugPrint(response.message);
      }
    });
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
    bool gg = Get.isRegistered<PeerChatLogic>();
    if (gg) {
      var peerChatLogic = Get.find<PeerChatLogic>();
      peerChatLogic.receiveMsgFresh();
    }

    //_showNotification(title,content);
    //BlocProvider.of<PeerBloc>(context).add(EventReceiveNewMessage(message));
  }

  void onPeerMessageACK(result, int error) {
    Map<String, dynamic> m = Map<String, dynamic>.from(result);
    bool gg = Get.isRegistered<PeerChatLogic>();
    if (gg) {
      var peerChatLogic = Get.find<PeerChatLogic>();
      peerChatLogic.receiveMsgAck(m);
    }
    //BlocProvider.of<PeerBloc>(context).add(EventReceiveNewMessageAck(m));
  }

  void onGroupMessage(result) {
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
    bool gg = Get.isRegistered<GroupChatLogic>();
    if (gg) {
      var groupChatLogic = Get.find<GroupChatLogic>();
      groupChatLogic.receiveMsgFresh();
    }
    //_showNotification(title,content);
    //BlocProvider.of<GroupBloc>(context)
    //    .add(EventGroupReceiveNewMessage(message));
  }

  void onGroupMessageACK(result) {
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
    bool gg = Get.isRegistered<GroupChatLogic>();
    if (gg) {
      var groupChatLogic = Get.find<GroupChatLogic>();
      groupChatLogic.receiveMsgAck(message);
    }
    //_showNotification(title,content);
    //BlocProvider.of<GroupBloc>(context)
    //    .add(EventGroupReceiveNewMessageAck(message));
  }

  void onPeerSecretMessage(result) {}

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
    //var count = 1;
    //debugPrint(result);
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
    // debugPrint(result);
    //Map<String, dynamic> message = Map<String, dynamic>.from(result);
    //BlocProvider.of<GroupBloc>(context)
    //    .add(EventGroupReceiveNewMessage(message));
    onNewGroupMessage(result, 0);
  }

  void deletePeerMessageSuccess(result, id) async {
    debugPrint(result);
    //BlocProvider.of<PeerBloc>(context).add(EventDeleteMessage(id));
    onNewMessage(result, 0);
  }

  // 检查是否需要版本更新
  void _checkUpdateVersion() async {
    try {
      var response = await CommonAPI.getVersion();
      if (response.code != 0) {
        Map<String, dynamic> versionData = {};
        versionData['isForce'] = response.data.isforce;
        versionData['hasUpdate'] = true;
        versionData['isIgnorable'] = false;
        versionData['versionCode'] = response.data.versioncode;
        versionData['versionName'] = response.data.versionname;
        versionData['updateLog'] = response.data.updatelog;
        versionData['apkUrl'] = response.data.apkurl;
        versionData['apkSize'] = response.data.apksize;
        // 后台返回的版本号是带小数点的（2.8.1）所以去除小数点用于做对比
        var targetVersion = response.data.versioncode.replaceAll(
            '.', ''); //response["data"]["versionCode"].replaceAll('.', '');
        var version = "120";
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String versions = packageInfo.version; //版本号
        var appVersion = versions.replaceAll('.', '');
        // 当前App运行版本
        var currentVersion = appVersion; //.replaceAll('.', '');
        if (int.parse(targetVersion) > int.parse(currentVersion)) {
          if (Platform.isAndroid) {
            // 安卓弹窗提示本地下载， 交由flutter_xupdate 处理，不用我们干嘛。
            await checkUpdate.initXUpdate();
            checkUpdate.checkUpdateByUpdateEntity(
                versionData); // flutter_xupdate 自定义JSON 方式，
          } else if (Platform.isIOS) {
            // IOS 跳转 AppStore
            //showIOSDialog(); // 弹出ios提示更新框
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
