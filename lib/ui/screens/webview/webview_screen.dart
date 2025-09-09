import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'webview_wm.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebviewScreen extends ElementaryWidget<WebviewWidgetModel> {
  const WebviewScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultWebviewWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(WebviewWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview Test'),
      ),
      body: Column(
        children: [
          Expanded(child: InAppWebView(
            initialUrlRequest: 
            URLRequest(
              url: WebUri("https://github.com/flutter"),
            ),
            onLoadStart: (controller, url) => wm.onPageStarted(url.toString()), //это начинает загружать страницу
            onLoadStop: (controller, url) => wm.onPageFinished(url.toString()), //это загрузка заканчивается когда завершается загрузка страницы
          )),
          StateNotifierBuilder<bool>(
                    listenableState: wm.isLoading,
                    builder: (_, loading) {
                      if (loading !=true) return const SizedBox.shrink();
                      return const Center(child: CircularProgressIndicator());
                  },
                ),
        ],
      ),
    );
  }
}
