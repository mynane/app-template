import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:my_app/utils/Routes.dart';
import 'package:unicorndial/unicorndial.dart';
import './webview/LSWebView.dart';
import '../utils/DownloadFile.dart';
import '../pages/Sliver.dart';
// import '../pages/Detail.dart';
import '../utils/Routes.dart';
import 'package:fluro/fluro.dart';

var downloadFile = DownloadFile();

class FloatActionButtonWidget extends StatefulWidget {
  FloatActionButtonWidget({Key key}) : super(key: key);

  _FloatActionButtonWidgetState createState() => _FloatActionButtonWidgetState();
}

class _FloatActionButtonWidgetState extends State<FloatActionButtonWidget> {
  void _goLSWebView() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new LSWebView();
    }));
  }
  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();
    childButtons.add(UnicornButton(
        // hasLabel: true,
        // labelText: "设置",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.hotel),
          onPressed: () {
            _goLSWebView();
          },
        )));

    childButtons.add(UnicornButton(
        // hasLabel: true,
        // labelText: "设置",
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                // return new SearchPage();
                return new SliverPage();
                // return StaggeredAnimationReplication();
                // return new SliverPage();
              }));
            },
        )));

    childButtons.add(UnicornButton(
        // hasLabel: true,
        // labelText: "设置",
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.settings),
            onPressed: () {
              // Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              //   // return new SearchPage();
              //   return new DetailPage();
              //   // return StaggeredAnimationReplication();
              //   // return new SliverPage();
              // }));
              // throw new StateError('This is a Dart exception.');
              intentTo(context);
            },
        )));

    return UnicornDialer(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
      parentButtonBackground: Colors.redAccent,
      orientation: UnicornOrientation.VERTICAL,
      parentButton: Icon(Icons.add),
      childButtons: childButtons
    );
  }
}

///跳转到第二个界面
intentTo(BuildContext context) {
  ///字符串编码
  var json = jsonEncode(Utf8Encoder().convert('来自第一个界面'));
  Routes.router.navigateTo(
      context, '${Routes.detailPage}?message=$json', //跳转路径
  ).then((result) {//回传值
    if (result != null) {
      print(result);
    }
  });
  // Routes.router.pop(context);
}

