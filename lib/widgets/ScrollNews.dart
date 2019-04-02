import 'package:flutter/material.dart';
import 'dart:async';

class ScrollNewsWidget extends StatefulWidget {
  final getMore;
  final goLink;
  List<dynamic> list;
  int seconds = 2;

  ScrollNewsWidget({
    Key key, 
    @required this.getMore,
    @required this.list,
    @required this.goLink,
    this.seconds,
  }) : super(key: key);

  _ScrollNewsWidgetState createState() => _ScrollNewsWidgetState();
}

class _ScrollNewsWidgetState extends State<ScrollNewsWidget> {
  Timer timer;
  Map<String, dynamic> showNews;
  int i = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      showNews = widget.list[0];
    });

    timer = new Timer.periodic(new Duration(seconds: widget.seconds), (timer) {
      if (i == widget.list.length - 1) {
        i = 0;
      } else {
        i++;
      }

      setState(() {
        showNews = widget.list[i];
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void _getMore() {
    print("more");
    widget.getMore();
  }

  void _goLink() {
    print("go link");
    widget.goLink(showNews);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 6, horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0x99000000), width: 1),
          bottom: BorderSide(color: Color(0x99000000), width: 1),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 4,
                ),
                child: Text(
                  showNews["type"],
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              InkWell(
                onTap: _goLink,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    showNews["text"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xee000000),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Color(0xff999999),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: _getMore,
              child: Text(
                "更多",
                style: TextStyle(
                  color: Color(0xff648EFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
