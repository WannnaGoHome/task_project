import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'webview_model.dart';
import 'webview_screen.dart';

//TODO flutter_inappwebview
class WebviewWidgetModel extends WidgetModel<WebviewScreen, WebviewModel> {
  WebviewWidgetModel(WebviewModel model) : super(model);

  final StateNotifier<bool> isLoading = StateNotifier<bool>(initValue: true);
  InAppWebViewController? webViewController;

  void onPageStarted(String url) => isLoading.accept(true);

  void onPageFinished(String url) => isLoading.accept(false);
}

WebviewWidgetModel defaultWebviewWidgetModelFactory(BuildContext context) {
  return WebviewWidgetModel(WebviewModel());
}