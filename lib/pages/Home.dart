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
import 'package:qr_flutter/qr_flutter.dart';
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

  void _closeDialog() {
    Navigator.pop(context);
  }

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

  void _getMoreTap() {
    // _fetchData();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
            return new Container(
                height: 300.0,
                child: Center(
                  child: new QrImage(
                    data: "1234567890",
                    size: 200.0,
                  ),
                ),
            );
        },
    ).then((val) {
        print(val);
    });
    return;
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(14),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Text("data"),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: _closeDialog,
                  child: Icon(
                    Icons.clear,
                    color: Color(0x99999999),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ).then((val) {
        print(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: HeaderWidget(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffe64646), Color(0xffe43130)]),
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            height: 40,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TabBar(
                    labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                    labelColor: Color(0xffde4b4b),
                    unselectedLabelColor: Color(0xff999999),
                    indicatorColor: Color(0xffde4b4b),
                    isScrollable: true,
                    tabs: _getTabs(),
                    controller: _tabController,
                  ),
                ),
                InkWell(
                  onTap: _getMoreTap,
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
          ),
          preferredSize: Size(30, 50),
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
