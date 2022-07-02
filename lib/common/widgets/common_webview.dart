import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common_fresh.dart';


class CommonWebViewPage extends StatefulWidget {
  final String htmlUrl;
  final String pageTitle;

  CommonWebViewPage({required this.htmlUrl, this.pageTitle = ""});

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  double  lineProgress =1.0;
  GlobalKey<PartRefreshWidgetState> globalKey = GlobalKey();
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pageTitle}"),
        actions: [
          NavigationControls(_controller.future),
        ],
        bottom: PreferredSize(
          child: _progressBar(context),
          preferredSize: Size.fromHeight(10.h),
        ),
      ),
      backgroundColor: Colors.white,
      body: WebView(
        javascriptMode : JavascriptMode.unrestricted,
        initialUrl: widget.htmlUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onProgress: (progress){
          setState(() {
            lineProgress =progress /100.0;
          });
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('zhihu://')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
  _progressBar(BuildContext context) {
    return  LinearProgressIndicator(
        backgroundColor: Colors.white70.withOpacity(0),
        value: lineProgress == 1.0 ? 0 : lineProgress,
        valueColor:  const AlwaysStoppedAnimation<Color>(Colors.blue),
      );
  }
}
class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture, {Key? key})
      : assert(_webViewControllerFuture != null),
        super(key: key);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController? controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('没有更多啦')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller!.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('没有更多啦')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller!.reload();
              },
            ),
          ],
        );
      },
    );
  }
}