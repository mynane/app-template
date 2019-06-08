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
      child: Scaffold(
        appBar: AppBar(
          title: Text("data"),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Text("data")
          ],
        ),
        body: Text("data"),
      ),
    );
  }
}
