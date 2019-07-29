import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/Search.dart';
import '../widgets/ScrollNews.dart';

class SearchPage extends StatefulWidget {
  final Widget child;

  SearchPage({Key key, this.child}) : super(key: key);

  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> list = [
    { "type": "HOT", "text": "你好高飞机刷卡缴费静安寺开了房间爱离开你好高飞机刷卡缴费静安寺开了房间爱离开" },
    { "type": "最新", "text": "了房间爱离开你好高你好高飞机刷卡缴费静安寺开飞机刷卡缴费静安寺开了房间爱离开" },
    { "type": "最热", "text": "安你好高飞机刷卡缴费静寺开了房间爱离开你好高飞机刷卡缴费静安寺开了房间爱离开" },
    { "type": "推荐", "text": "刷卡缴费静安寺你好高飞机开了房间爱离开你好高飞机刷卡缴费静安寺开了房间爱离开" },
    { "type": "热门", "text": "好高飞机刷卡缴费你好高飞机刷卡缴费静安寺开了房间爱离开你静安寺开了房间爱离开" },
  ];

  void _searchChange(String str) {
    print('你好$str');
  }

  void _getMore() {
    print("getMore");
  }

  void _goLink(Map<String, dynamic> data) {
    print(data);
  }

  void _textFieldChanged(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // width: ScreenUtil.screenWidth,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Color(0xff666666),
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                left: -10, top: 6,
                right: 10, bottom: 6,
              ),
              border: InputBorder.none,
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.grey,
                size: 14,
              ),
              hintText: '输入商家、商品名称',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            onChanged: _textFieldChanged,
            autofocus: true,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xffe64646), Color(0xFFe43130)]),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // SearchWidget(
            //   searchChange: _searchChange
            // ),
            ScrollNewsWidget(
              list: list,
              getMore: _getMore,
              goLink: _goLink,
              seconds: 3,
            ),
          ],
        )
      ),
    );
  }
}