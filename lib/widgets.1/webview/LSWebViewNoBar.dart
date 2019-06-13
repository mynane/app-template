// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LSWebViewNoBar extends StatefulWidget {
  final String url;
  LSWebViewNoBar({Key key, this.url}) : super(key: key);

  @override
  _LSWebViewNoBarState createState() => _LSWebViewNoBarState();
}

class _LSWebViewNoBarState extends State<LSWebViewNoBar> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _webViewController;
  String title = '';
  num _stackToView = 1;
  Timer timer;

  void _setTimer() {
    if (timer != null) {
      _clearTimer();
    }
    timer = Timer.periodic(
      const Duration(milliseconds: 8000), (a) {
        if (_stackToView == 1) {
          print('Duration timeout');
          setState(() {
            _stackToView = 2;
          });
          throw FlutterError("url:${widget.url}, timeout");
        }
        _clearTimer();
      }
    );
  }

  void _clearTimer() {
    print("clear timer");
    timer?.cancel();
    timer = null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _clearTimer();
  }

  void _handleLoad() {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: < Widget > [
                Expanded(
                  child: WebView(
                    initialUrl: widget.url, // 'http://127.0.0.1:8080/detail.html',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                      _webViewController = webViewController;
                    },
                    javascriptChannels: <JavascriptChannel>[
                      _toasterJavascriptChannel(context),
                      _jsBridgeJavascriptChannel(context)
                    ].toSet(),
                    navigationDelegate: (NavigationRequest request) {
                      // if (request.url.startsWith('js://webview')) {
                      //   print('blocking navigation to $request}');
                      //   return NavigationDecision.prevent;
                      // }
                      print("navigationDelegate start timer");
                      _setTimer();
                      setState(() {
                        _stackToView = 1;
                      });
                      return NavigationDecision.navigate;
                    },
                    onPageFinished: (String url) {
                      _clearTimer();
                      print('Page finished loading: $url');
                      _handleLoad();
                    },
                  )
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: Image(
                  image: AssetImage("lib/images/loading02.jpg"),
                  width: 160,
                ),
                // CircularProgressIndicator(),
              ),
            ),
             Container(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  print("object");
                  _webViewController.loadUrl(widget.url);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage("lib/images/placeholder.png"),
                          width: 160,
                        ),
                        Text("点击空白区域刷新", style: TextStyle(color: Color(0x99999999)),)
                      ],
                    )
                  ),
                )
              ),
            ),
          ],
        );
      })
      // floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  JavascriptChannel _jsBridgeJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'JSBridge', 
        onMessageReceived: (JavascriptMessage message) {
          final parsed = json.decode(message.message);
          switch (parsed['type']) {
            case 'setTitle':
              setState(() {
                title = parsed['data'];
              });
            break;
            case 'goto':
              _webViewController.loadUrl(parsed['data']);
            break;
            default:
            break;
          }
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}

enum MenuOptions {
  reload,
  showToast,
  showNotify
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller);

  final Future<WebViewController> controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.reload:
                controller.data.clearCache();
                controller.data.reload();
                break;
              case MenuOptions.showToast:
                controller.data.evaluateJavascript("LS.toast('这是toast')");
                break;
              case MenuOptions.showNotify:
                controller.data.evaluateJavascript("LS.notify('这是notify')");
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
                PopupMenuItem<MenuOptions>(
                  value: MenuOptions.reload,
                  child: const Text('重新加载'),
                ),
                PopupMenuItem<MenuOptions>(
                  value: MenuOptions.showToast,
                  child: const Text('显示toast'),
                ),
                PopupMenuItem<MenuOptions>(
                  value: MenuOptions.showNotify,
                  child: const Text('显示notify'),
                ),
              ],
        );
      },
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(content: Text("No back history item")),
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
                      if (await controller.canGoForward()) {
                        controller.goForward();
                      } else {
                        Scaffold.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("No forward history item")),
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
                      controller.reload();
                    },
            ),
          ],
        );
      },
    );
  }
}
