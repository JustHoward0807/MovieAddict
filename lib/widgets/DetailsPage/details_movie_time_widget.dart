// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class DetailsMovieTimeWidget extends StatefulWidget {
  final String movie_id;
  const DetailsMovieTimeWidget({Key key, @required this.movie_id})
      : super(key: key);
  @override
  _DetailsMovieTimeWidgetState createState() => _DetailsMovieTimeWidgetState();
}

class _DetailsMovieTimeWidgetState extends State<DetailsMovieTimeWidget> {
  WebViewController controller;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        child: WebView(
          // ignore: prefer_collection_literals
          gestureRecognizers: Set()
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
          initialUrl: 'https://movies.yahoo.com.tw/movietime_result.html/id=' +
              widget.movie_id,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;
          },
          onPageStarted: (url) {
            if (url.contains('https://movies.yahoo.com.tw/')) {
              Future.delayed(const Duration(milliseconds: 300), () {
                
                controller.runJavascript(
                    "document.getElementsByTagName('header')[0].style.display='none'");
                
                controller.runJavascript(
                    "document.getElementsByTagName('ul')[0].style.display='none'");
              });
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('yahoo.com')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.prevent;
          },
        ));
  }
}
