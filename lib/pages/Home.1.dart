import 'package:flutter/material.dart';
import 'dart:convert';
import './Setting.dart';
import '../widgets/Header.dart';
import '../pages/Search.dart';
import '../widgets/FloatActionButton.dart';
// import '../widgets/floor/FloorMulti.dart';
// import '../widgets/webview/LSWebView.dart';
import '../widgets//webview/LSWebViewNoBar.dart';
import '../widgets//webview/LSWebViewLocalNoBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class Home extends StatelessWidget {
  final onGenerateRoute;
  Home({Key key, this.onGenerateRoute});

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      title: 'flutter demo',
      onGenerateRoute: this.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // routes: this.onGenerateRoute,
      // <String, WidgetBuilder> {
      //   '/router/setting': (_) => new SettingPage(),
      //   '/puter/search': (_) => new SearchPage(),
      //   // '/puter/sliver': (_) => new SliverPage(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List lists = new List();

  void initState() { 
    super.initState();
    _tabController = new TabController(vsync: this, length: 13);
    _fetchData();
  }

  void _fetchData() async{
    Response response = await dio.get("http://127.0.0.1:7001/api/user");
    setState(() {
      lists = response.data["data"];
    });
  }

  @override
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

  // _goSettingPage() {
  //   Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
  //     return new SettingPage(id: 23423423423423);
  //   }));
  // }

  List<Widget> _getTabs() {
    List<Widget> res = new List();
    res.add(new Tab(text: '首页'));
    for (var item in lists) {
      if (item['enabled']) {
        res.add(new Tab(text: item['label']));
      }
    }
    return res;
  }

  List<Widget> _getTabBarView() {
    List<Widget> res = new List();
    res.add(new Center(
      child: new LSWebViewLocalNoBar(
        url: 'lib/htmls/home.html',
      ),
    ));
    for (var item in lists) {
      if (item['enabled']) {
        res.add(new Center(
          child: new LSWebViewNoBar(
          url: item['url']
        )));
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          decoration: BoxDecoration(
            // color: Colors.white,
            border: Border(bottom: BorderSide(
              color: Color(0xff999999),
              width: 0.5
            ))
          ),
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
                  tabs: _getTabs(),
                  controller: _tabController,
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
          // HeaderWidget(),
        ),
        flexibleSpace: Container(
          color: Color(0xff151924),
          // decoration: BoxDecoration(
          //   gradient: const LinearGradient(
          //     colors: [Color(0xffe64646), Color(0xffe43130)]),
          // ),
        ),
        bottom: PreferredSize(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 36,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 5
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff5a5e67),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.search, color: Colors.white),
                          Text("六朝旧事", style: TextStyle(color: Colors.white),)
                        ],
                      )
                      // child: Text("六朝旧事", style: TextStyle(color: Colors.white),)
                    )
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 36,
                    margin: EdgeInsets.only(
                      left: 5,
                      right: 10
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff5a5e67),
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(right: 6),
                              child: Text("六朝旧事", style: TextStyle(color: Colors.white),),
                            )
                          ),
                          InkWell(
                            child: Container(
                              child: Text("六朝旧事", style: TextStyle(color: Colors.white),),
                            )
                          )
                        ],
                      ),
                      // child: Text("六朝旧事", style: TextStyle(color: Colors.white),)
                    )
                  ),
                )
              ],
            )
          ),
          preferredSize: Size(20, 40),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: _getTabBarView(),
      ),
      floatingActionButton: FloatActionButtonWidget(),
    );
  }
}
