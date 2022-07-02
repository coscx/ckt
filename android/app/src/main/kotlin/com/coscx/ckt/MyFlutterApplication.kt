package com.coscx.ckt
import com.auwx.umeng_analytics_with_push.UmengAnalyticsWithPush
import io.flutter.app.FlutterApplication

class MyFlutterApplication: FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        UmengAnalyticsWithPush.preinitial(
            this,
            // AppKey, secret, channel 也可配置在 AndroidManifest 中
            // Required here or AndroidManifest.application
            //   <meta-data android:name="UMENG_APPKEY" android:value="aaaaaaaaaaaaaaaaaa" />
            //   <meta-data android:name="UMENG_SECRET" android:value="aaaaaaaaaaaaaaaaaa" />
            //   <meta-data android:name="UMENG_CHANNEL" android:value="${CHANNEL}" />
            appKey="625cbfde10fad5015d8e76f1",
            secret = "1bef9ca99f1ea5011e53b33f6a491a54",
            channel = "default",
            enableLog = BuildConfig.DEBUG,
            resourcePackageName="com.coscx.ckt"
            // ... other arguments
        )
    }
}
