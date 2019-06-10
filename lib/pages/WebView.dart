import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../configs/LS_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/webview/LSWebViewLocalNoBar.dart';



class WebViewPage extends StatefulWidget {
  final Widget child;

  WebViewPage({Key key, this.child}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  int headerBgColor = 0xffffffff;
  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 300.0,
              child: Center(
                child: new QrImage(
                  data: "1234567890",
                  size: 200.0,
                ),
              ),
          );
        },
    ).then((val) {
        print(val);
    });
  }

  Widget _appBar() {
    return AppBar(
      title: Text("data"),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(this.headerBgColor),
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Center(
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xfff3f3f3), width: 1)
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _showModalBottomSheet();
                        },
                        child: Icon(LS.ellipsis, color: Color(0xff333333)),
                      )
                    )
                  ),
                  Container(
                    width: 1,
                    height: 22,
                    color: Color(0xffe2e2e2),
                  ),
                  Expanded(
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(LS.icon_quanquan, color: Color(0xff333333)),
                      )
                    )
                  )
                ],
              )
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: LSWebViewLocalNoBar(
            url: 'lib/htmls/home.html',
            initialization: (data) {
              setState(() {
                print(data["headerBgColor"]);
                headerBgColor = int.parse(data["headerBgColor"]);
              });
              print(data);
            },
          ),
        ),
      ),
    );
  }
}
