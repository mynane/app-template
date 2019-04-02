import 'package:flutter/material.dart';
import './Setting.dart';
// import '../utils/Routes.dart';
import '../widgets/Header.dart';
import '../pages/Search.dart';
import '../widgets/FloatActionButton.dart';
import '../widgets/floor/FloorMulti.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder> {
        '/router/setting': (_) => new SettingPage(),
        '/puter/search': (_) => new SearchPage(),
      },
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

  void initState() { 
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
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

  void _getMoreTap() {
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
              colors: [Color(0xffe64646), Color(0xFFe43130)]),
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            height: 40,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TabBar(
                    labelColor: Color(0xffde4b4b),
                    // unselectedLabelStyle: TextStyle(
                    //   fontSize: 12,
                    //   color: Color(0xff999999),
                    // ),
                    unselectedLabelColor: Color(0xff999999),
                    indicatorColor: Color(0xffde4b4b),
                    isScrollable: true,
                    tabs: <Widget>[
                      new Tab(text: "推荐",),
                      new Tab(text: "前端"),
                      new Tab(text: "后端"),
                    ],
                    controller: _tabController,
                  ),
                ),
                InkWell(
                  onTap: _getMoreTap,
                  child: Container(
                    width: 40,
                    // padding: EdgeInsets.symmetric(horizontal: 10),
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
        children: <Widget>[
          SafeArea(
            child: ListView(
              children: <Widget>[
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/1125x345/eee/ccc'
                    "url": "http://localhost:1234/5ad1e648799a5a85.1018e2db.gif"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 2,
                    // "url": 'http://temp.im/561x360/eec/ccc'
                    "url": "http://localhost:1234/001.9c0161ba.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/279x360/eec/ccc'
                    "url": "http://localhost:1234/002.39df02f2.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/279x360/eec/ccc'
                    "url": "http://localhost:1234/003.6d591184.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
                FloorMultiWidget(
                  linkTo: (Map<String, dynamic> data) {
                    print(data);
                  },
                  list: [{
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/004.fc7b6682.jpg"
                  }, {
                    "flex": 1,
                    // "url": 'http://temp.im/372x372/eef/ccc'
                    "url": "http://localhost:1234/005.19faff92.jpg"
                  }],
                ),
              ],
            ),
          ),
          new Center(child: new Text('船')),
          new Center(child: new Text('巴士')),
        ],
      ),
      floatingActionButton: FloatActionButtonWidget(),
    );
  }
}
