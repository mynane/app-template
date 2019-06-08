import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final Widget child;

  WebViewPage({Key key, this.child}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: WebviewScaffold(
        url: "http://127.0.0.1:8080/index.html",
        appBar: new AppBar(
          // title: const Text('Widget webview'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffe64646), Color(0xFFe43130)]),
            ),
          ),
        ),
        withZoom: true,
        enableAppScheme: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: Image(
              image: AssetImage("lib/images/loading02.jpg"),
              width: 160,
            ),
          ),
        ),
      ),
    );
  }
}
