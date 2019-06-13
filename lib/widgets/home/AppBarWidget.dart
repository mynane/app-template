import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key key,
    this.controller
  }) : super(key: key);

  final controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 40,
            child: TabBar(
              labelStyle: TextStyle(
                color: Color(0xfffcfdfd),
                fontWeight: FontWeight.normal,
                fontSize: 18
              ),
              unselectedLabelStyle: TextStyle(
                color: Color(0xffcfd1d6),
                fontWeight: FontWeight.w300,
                fontSize: 14
              ),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color(0xfff19f0d),
              indicatorWeight: 0.001,
              indicatorPadding: EdgeInsets.all(0),
              isScrollable: true,
              tabs: [
                new Tab(text: "首页"),
                new Tab(text: "美食"),
                new Tab(text: "电影")
              ],
              controller: controller,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Color(0x99999999), width: 1)),
              ),
              child: Icon(
                Icons.add,
                color: Color(0x99666666),
              ),
            ),
          ),
        ],
      ),
    );
  }
}