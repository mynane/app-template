import 'package:flutter/material.dart';

class FloorMultiWidget extends StatefulWidget {
  final List<dynamic> list;
  final linkTo;

  FloorMultiWidget({
    Key key,
    @required this.list,
    @required this.linkTo,
  }) : super(key: key);

  _FloorMultiWidgetState createState() => _FloorMultiWidgetState();
}

class _FloorMultiWidgetState extends State<FloorMultiWidget> {

  List<Widget> _render() {
    List<Widget> result = [];
    for (int i = 0; i < widget.list.length; i++) {
      Map<String, dynamic> item = widget.list[i];

      result.add(Expanded(
        flex: item['flex'],
        child: InkWell(
          onTap: () { widget.linkTo(item); },
          child: Image.network(item["url"]),
        ),
      ));

    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
       children: _render(),
    );
  }
}
