import 'package:flutter/material.dart';


class PositionButton extends StatelessWidget {
  final onLeftTap;
  final onRightTap;
  final Widget lChild;
  final Widget rChild;
  final double barHeight;
  final bool isLoading;
  const PositionButton({
    Key key,
    this.onLeftTap,
    this.onRightTap,
    this.lChild,
    this.rChild,
    this.barHeight,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return new Positioned(
      right: 0,
      top: 0,
      left: 0,
      height: statusBarHeight + barHeight,
      child: Container(
        // margin: EdgeInsets.only(bottom: 5),
        color: isLoading ? Colors.transparent : Color(0xff222548),
        child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 100,
          height: 40,
          margin: EdgeInsets.only(bottom: 5, right: 5),
          decoration: BoxDecoration(
            color: isLoading ? Color.fromRGBO(255, 255, 255, 1.00) : Color.fromRGBO(30, 31, 61, 1.00),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLoading ? Color.fromRGBO(242, 242, 242, 1.00) : Color.fromRGBO(62, 64, 95, 1.00),
              width: 0.5
            ),
          ),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: onLeftTap,
                    child: lChild,
                  )
                )
              ),
              Container(
                width: 1,
                height: 22,
                color: isLoading ? Color.fromRGBO(225, 225, 225, 1.00) : Color.fromRGBO(62, 64, 95, 1.00),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: onRightTap,
                    child: rChild,
                  )
                )
              )
            ],
          ),
        )
      )
      )
    );
  }
}
