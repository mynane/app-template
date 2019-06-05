import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/Header.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentTab = 0;
  int _index = 0;
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 2000), (a) {
        // print(a.tick);
        setState(() {
          _index += 1;
        });
      }
    );
    _tabController = new TabController(vsync: this, length: 13);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _getTabs() {
    return [
      new Tab(child: Container(
        // width: 40,
        child: Center(
          child: Text('推荐'),
        ),
      ),),
      new Tab(child: Container(
        // width: 60,
        child: Center(
          child: Text('电视剧'),
        ),
      ),),
      new Tab(child: Container(
        // width: 60,
        child: Center(
          child: Text("创造营"),
        ),
      ),),
      new Tab(child: Container(
        // width: 40,
        child: Center(
          child: Text("创造营"),
        ),
      ),),
      new Tab(child: Container(
        // width: 40,
        child: Center(
          child: Image.asset("lib/images/placeholder.png"),
        ),
      ),)
    ];
  }

  List<Widget> _getTabBarView() {
    return [
      InkWell(
        onTap: () {
          Navigator.of(context).pop("nihaozhongwen");
        },
        child: Text("data"),
      ), InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text("data"),
      ), InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text("data"),
      ), InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text("data"),
      )];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.cyan[100 * (_index % 9)],
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top
              ),
              child: Column(
                children: <Widget>[
                  Container(
                      // height: 40,
                      // color: Colors.white,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xffcccccc), width: 0.5))
                              // borderRadius: BorderRadius.circular(3.0)
                            ),
                            child: TabBar(
                              labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                              labelColor: Colors.red, // Color(0xffde4b4b),
                              unselectedLabelColor: Color(0xffffffff), // Color(0xff999999),
                              indicatorColor: Colors.blue, // Color(0xffde4b4b),
                              indicatorWeight: 0.01,
                              isScrollable: true,
                              tabs: _getTabs(),
                              indicatorSize: TabBarIndicatorSize.label,
                              controller: _tabController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 20,
                              right: 20
                            ),
                            child: Text("data"),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.cyan[100 * (_index % 9)],
            width: MediaQuery.of(context).size.width,
            child: Container(
              height: 100,
              child: TabBarView(
                controller: _tabController,
                children: _getTabBarView(),
              )
            )
          ),
        ],
      ),
    );
  }
}
