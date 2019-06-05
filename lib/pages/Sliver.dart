import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/webview/LSWebViewLocalNoBar.dart';
import './Home.dart';

Dio dio = new Dio();

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
  double webviewHeight = 0;
  List lists = new List();
  Color _color = Colors.black;
  int index = 0;
  ScrollController _scrollController = ScrollController();
  // Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // timer = Timer.periodic(
    //   const Duration(milliseconds: 2000), (a) {
    //     // print(a.tick);
    //     setState(() {
    //       index += 1;
    //     });
    //   }
    // );

    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset > 100) {
        if (_color != Colors.amberAccent) {
          setState(() {
            _color = Colors.amberAccent;
          });
        }
      } else {
        if (_color != Colors.black) {
          setState(() {
            _color = Colors.black;
          });
        }
      }
    });
    // _fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
    // timer.cancel();
  }

  // void _fetchData() async{
  //   Response response = await dio.get("http://127.0.0.1:7001/api/navigator");
  //   setState(() {
  //     lists = response.data["data"];
  //   });
  // }

  void _goJumpTo() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      // return new SearchPage();
      return new Home();
      // return StaggeredAnimationReplication();
      // return new SliverPage();
    }));
  }

  Widget _row(url, label) {
    return InkWell(
      onTap: () => {
        _goJumpTo()
      },
      child: Column(
        children: <Widget>[
          new Image(image: new NetworkImage(url), width: 70, height: 70,),
          Center(child: Text(label),)
        ],
      ),
    );
  }

  Widget _renderNavigator() {
    List<Widget> row1 = new List();
    List<Widget> row2 = new List();
    int i = 0;
    lists.forEach((k) {
      if (k["enabled"]) {
        if (i < 5) {
          row1.add(_row(k["url"], k["label"],));
        } else {
          row2.add(_row(k["url"], k["label"],));
        }
        i++;
      }
    });
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row2,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      color: Colors.white,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            floating: true,
            title: Text("分类页", style: TextStyle(
              fontWeight: FontWeight.w300,
              // fontSize: 12
            )),
            flexibleSpace: Container(
              // color: _color,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffe64646), Color(0xFFe43130)]),
              ),
            ),
            // expandedHeight: 250.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: false,
            //   title: const Text('Demo'),
            //   background: Image.asset(
            //     "./images/avatar.png", fit: BoxFit.cover,),
            // ),
          ),
          // SliverPersistentHeader(
          //   pinned: false,
          //   floating: false,
          //   delegate: _SliverAppBarDelegate(
          //     minHeight: 60.0,
          //     maxHeight: 200.0,
          //     child: Container(
          //       color: Colors.white,
          //       child: _renderNavigator(),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: _renderNavigator(),
            ),
          ),
          SliverToBoxAdapter(
            child: new Container(
              height: webviewHeight,
              child: LSWebViewLocalNoBar(
                url: "lib/htmls/index.html",
                initialization: (initData) {
                  setState(() {
                    lists = initData["navigator"];
                  });
                  print(initData);
                },
                changeHeight: (height) {
                  setState(() {
                    print("setstate $height ${window.physicalSize} ${MediaQuery.of(context).size}");
                    webviewHeight = double.parse(height) + MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
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
