import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';
import './webview/LSWebView.dart';
import '../utils/DownloadFile.dart';

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
              downloadFile.load('http://127.0.0.1:8080/detail.html');
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
              // throw new StateError('This is a Dart exception.');
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
