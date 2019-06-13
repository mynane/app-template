import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:juanjuan/widgets/home/AppBarWidget.dart';
import 'package:juanjuan/widgets/home/BodyWidget.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: 3
    ); 
  }

  @override
  void dispose() {
    _tabController .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: AppBarWidget(
          controller: _tabController,
        )
      ),
      body: BodyWidget(
        controller: _tabController,
      ),
    );
  }
}
