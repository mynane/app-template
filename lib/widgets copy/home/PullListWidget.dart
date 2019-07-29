import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullListWidget extends StatefulWidget {
  PullListWidget({Key key}) : super(key: key);

  _PullListWidgetState createState() => _PullListWidgetState();
}

class _PullListWidgetState extends State<PullListWidget> {
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  void _onRefresh(bool){
     _refreshController.sendBack(true, RefreshStatus.completed);
    /*.  after the data return,
          use _refreshController.refreshComplete() or refreshFailed() to end refreshing
    */
  }

  void _onLoading(){
    _refreshController.isRefresh(false);
    /*
          use _refreshController.loadComplete() or loadNoData() to end loading
    */
  }

  @override
  void dispose() {
    super.dispose();
    // _refreshController.dispose();
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://iph.href.lu/350x150?text=图片轮播",
      fit: BoxFit.fitWidth,
    ));
  }

  Widget _renderSwiper() {
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
       child: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          shrinkWrap: true,
          // 内容
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.all(0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    _renderSwiper(),
                    const Text('B'),
                    const Text('C'),
                    const Text('D'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
