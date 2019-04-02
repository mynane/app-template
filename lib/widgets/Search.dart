import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatefulWidget {
  final searchChange;

  SearchWidget({Key key, this.searchChange}) : super(key: key);

  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  void _textFieldChanged(String str) {
    widget.searchChange(str);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
