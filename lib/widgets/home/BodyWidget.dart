import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:juanjuan/widgets/home/PullListWidget.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
    this.controller
  }) : super(key: key);
  final controller;

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://iph.href.lu/350x150?text=图片轮播",
      fit: BoxFit.fitWidth,
    ));
  }

  Widget _renderSwiper(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Container(
        height: 150,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: 3,
          // pagination: new SwiperPagination(
          //   builder: DotSwiperPaginationBuilder(
          //     color: Colors.black54,
          //     activeColor: Colors.white,
          // )),
          // control: new SwiperControl(),
          scrollDirection: Axis.horizontal,
          autoplay: true,
          onTap: (index) => print('点击了第$index个'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          new TabBarView(
            controller: controller,
            children: [
              _renderSwiper(context),
              PullListWidget(),
              Text("data3"),
            ],
          ),
          Positioned(
            right: 10,
            bottom: 200,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.network("https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1049110283,2367054080&fm=27&gp=0.jpg"),
              ),
            )
          )
        ],
      )
    );
  }
}
