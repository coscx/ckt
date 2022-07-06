import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ckt/common/langs/translation_service.dart';
import 'package:flutter_ckt/common/routers/pages.dart';
import 'package:flutter_ckt/common/store/store.dart';
import 'package:flutter_ckt/common/style/style.dart';
import 'package:flutter_ckt/common/utils/utils.dart';
import 'package:flutter_ckt/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
  if (Platform.isAndroid) {
     // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
     SystemUiOverlayStyle systemUiOverlayStyle =
     SystemUiOverlayStyle(statusBarColor: Colors.transparent);
     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),
      builder: (c,w) => RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(),
        footerBuilder: () => const ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: '财客通',
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder:EasyLoading.init(builder: BotToastInit()),
          translations: TranslationService(),
          navigatorObservers: [AppPages.observer],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: ConfigStore.to.languages,
          locale: ConfigStore.to.locale,
          fallbackLocale: const Locale('en', 'US'),
          enableLog: false,
          logWriterCallback: Logger.write,
        ),
      ),
    );
  }
}
