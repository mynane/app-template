import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../configs/LS_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/webview/LSWebViewLocalNoBar.dart';
import '../widgets/common/PositionButton.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewPage extends StatefulWidget {
  final Widget child;

  WebViewPage({Key key, this.child}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  int bgColor = 0xffffffff;
  double barHeight = 50;
  bool isLoading = true;
  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            height: 200.0,
            child: Center(
              child: new QrImage(
                data: "1234567890",
                size: 100.0,
              ),
            ),
            
          );
        },
    ).then((val) {
        print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: isLoading ? 0 : barHeight),
                  child: LSWebViewLocalNoBar(
                    url: 'lib/htmls/home.html',
                    changeHeader: (isLoad) {
                      setState(() {
                        isLoading = isLoad == 'true';
                      });
                      print(isLoad);
                    },
                    initialization: (data) {
                      setState(() {
                        bgColor = int.parse(data["bgColor"]);
                      });
                      print(data);
                    },
                  ),
                ),
              ),
            ),
            PositionButton(
              isLoading: isLoading,
              barHeight: barHeight,
              onLeftTap: _showModalBottomSheet,
              onRightTap: () {
                Navigator.of(context).pop();
              },
              lChild: Icon(LS.ellipsis, color: isLoading ? Color.fromRGBO(4, 4, 4, 1) : Color.fromRGBO(251, 252, 248, 1.00)),
              rChild: Icon(LS.icon_quanquan, size: 30, color: isLoading ? Color.fromRGBO(4, 4, 4, 1) : Color.fromRGBO(251, 252, 248, 1.00)),
            ),
          ],
        ),
      )
    );
  }
}
