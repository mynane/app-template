import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/webview/LSWebViewLocalNoBar.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
 
  final double minHeight;
  final double maxHeight;
  final Widget child;
 
  @override
  double get minExtent => minHeight;
 
  @override
  double get maxExtent => max(maxHeight, minHeight);
 
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }
 
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}


class SliverPage extends StatefulWidget {
  SliverPage({Key key}) : super(key: key);

  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  double webviewHeight = 100;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // timer = Timer.periodic(
    //   const Duration(milliseconds: 8000), (a) {
    //     setState(() {
    //       webviewHeight = 1000;
    //     });
    //     timer.cancel();
    //     timer = null;
    //   }
    // );
  }

  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: false,
            // expandedHeight: 250.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: false,
            //   title: const Text('Demo'),
            //   background: Image.asset(
            //     "./images/avatar.png", fit: BoxFit.cover,),
            // ),
          ),
          // SliverPersistentHeader(
          //   pinned: true,
          //   floating: true,
          //   delegate: SliverAppBarDelegate(
          //     minHeight: 60.0,
          //     maxHeight: 180.0,
          //     child: Container(),
          //   ),
          // ),
          SliverPersistentHeader(
            pinned: false,
            floating: false,
            delegate: _SliverAppBarDelegate(
              minHeight: 0.0,
              maxHeight: 100.0,
              child: Container(
                color: Colors.lightBlue[100 * (2 % 9)],
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("data")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: new Container(
              height: webviewHeight,
              // margin: EdgeInsets.only(bottom: 20),
              child: LSWebViewLocalNoBar(
                url: "lib/htmls/index.html",
                changeHeight: (height) {
                  setState(() {
                    print("setstate $height ${window.physicalSize} ${MediaQuery.of(context).size}");
                    webviewHeight = double.parse(height) + MediaQuery.of(context).padding.top - 20;
                  });
                }
              ),
            )
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.all(8.0),
          //   sliver: new SliverGrid( //Grid
          //     gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, //Grid按两列显示
          //       mainAxisSpacing: 10.0,
          //       crossAxisSpacing: 10.0,
          //       childAspectRatio: 4.0,
          //     ),
          //     delegate: new SliverChildBuilderDelegate(
          //           (BuildContext context, int index) {
          //         //创建子widget      
          //         return new Container(
          //           alignment: Alignment.center,
          //           color: Colors.cyan[100 * (index % 9)],
          //           child: new Text('grid item $index'),
          //         );
          //       },
          //       childCount: 20,
          //     ),
          //   ),
          // ),
          // //List
          // new SliverFixedExtentList(
          //   itemExtent: 100.0,
          //   delegate: new SliverChildBuilderDelegate(
          //           (BuildContext context, int index) {
          //         //创建列表项      
          //         return new Container(
          //           alignment: Alignment.center,
          //           color: Colors.lightBlue[100 * (index % 9)],
          //           child: new Text('list item $index'),
          //         );
          //       },
          //       childCount: 50 //50个列表项
          //   ),
          // ),
        ],
      ),
    );
  }
}
