import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class FloatActionButtonWidget extends StatefulWidget {
  FloatActionButtonWidget({Key key}) : super(key: key);

  _FloatActionButtonWidgetState createState() => _FloatActionButtonWidgetState();
}

class _FloatActionButtonWidgetState extends State<FloatActionButtonWidget> {
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
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        // hasLabel: true,
        // labelText: "设置",
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.home),
            onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        // hasLabel: true,
        // labelText: "设置",
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.settings),
            onPressed: () {},
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
