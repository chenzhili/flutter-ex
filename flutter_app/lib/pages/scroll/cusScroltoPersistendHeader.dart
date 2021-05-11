import 'package:flutter/material.dart';

class SliverPersistentHeaderPage extends StatelessWidget {
  const SliverPersistentHeaderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StickyHeader(),
    );
  }
}

class StickyHeader extends StatefulWidget {
  StickyHeader({Key key}) : super(key: key);

  @override
  _StickyHeaderState createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              title: Text('SliverPersistentHeader'),
              background: Image.asset('images/lake.jpg')),
        ),
        SliverPersistentHeader(
          // 可以吸顶的TabBar
          pinned: true,
          delegate: CusDelegate(
            child: TabBar(
              labelColor: Colors.black,
              controller: _tabController,
              tabs: <Widget>[
                Tab(text: 'Home'),
                Tab(text: 'Profile'),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          // 补充剩余的空间，但是 补充看到的是 整个 page的 高度
          // 剩余补充内容TabBarView
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(child: Text('Content of Home')),
              Center(child: Text('Content of Profile')),
            ],
          ),
        ),
      ],
    );
  }
}

class CusDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  CusDelegate({@required this.child});
  @override
  Widget build(
      // The `shrinkOffset` is a distance from [maxExtent] towards [minExtent]
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent) {
    print(shrinkOffset);
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
