import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/HttpUtil.dart';
import '../utils/Api.dart';
import '../widgets/Header.dart';

class SettingPage extends StatefulWidget {
  final int id;

  SettingPage({Key key, this.id}) : super(key: key);

  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool loading = false;

  // 返回首页
  void _goHome() {
    Navigator.pop(context);
  }

  @override
  void initState() { 
    super.initState();
    _getInitData();
  }

  Future<Map> _getInitData() async {
    setState(() {
      loading = true;
    });
    final _param  = {'page': 1,'pageSize': 20,'sort': 'rankIndex'};
    try {
      var response = await HttpUtil.get(Api.uri, params: _param);
      print(response);
    } catch (e) {
    }
    setState(() {
      loading = false;
    });

    Map<String, dynamic> result = {};

    return result;
  }

  Widget buildText() {
    return loading ? Text("data") : Container(height:0.0,width:0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         child: GestureDetector(
          onTap: _goHome,
          child: Column(
            children: <Widget>[
              HeaderWidget(),
              buildText(),
            ],
          ),
       ),
      ),
    );
  }
}