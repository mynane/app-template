import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  SliverPage({Key key}) : super(key: key);

  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text("data"),
         ),
         body: Text("12312312"),
       ),
    );
  }
}
