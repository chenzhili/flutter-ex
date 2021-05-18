import 'package:flutter/material.dart';

class AssociationPage extends StatefulWidget {
  AssociationPage({Key key}) : super(key: key);

  @override
  _AssociationPageState createState() => _AssociationPageState();
}

class _AssociationPageState extends State<AssociationPage>
    with SingleTickerProviderStateMixin {
  final List tabs = ['推荐', '置顶', '基金', '话题', '分类 ', '股票'];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        //  这里可能会用到 PageStorage 来保留滚动位置
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomTabs(
                child: TabBar(
                    labelColor: Colors.black,
                    controller: _tabController,
                    tabs: tabs.map((t) => Tab(child: Text('$t'))).toList())),
          ),
          SliverFillRemaining(
              child: TabBarView(
                  controller: _tabController,
                  children: tabs
                      .map((e) => Column(
                            children: [CusPane()],
                            mainAxisSize: MainAxisSize.min,
                          ))
                      .toList()))
        ],
      ),
    );
  }
}

class CustomTabs extends SliverPersistentHeaderDelegate {
  final TabBar child;
  CustomTabs({@required this.child});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CusPane extends StatelessWidget {
  const CusPane({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 22, 15, 18),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black12,
                    style: BorderStyle.solid,
                    width: 1))),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // 由于 Column 是 继承自 flex，默认 是 按照可视区域最大显示，用这个属性，可以 根据内容来 定义高度
          ///[mainAxisSize] property is [MainAxisSize.min], then the height of the
          ///    [Column] is the sum of heights of the children (subject to the incoming
          ///    constraints).
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(22)),
                          image: DecorationImage(
                              image: AssetImage('images/lake.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 18),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(12)),
                          image: DecorationImage(
                              image: AssetImage('images/lake.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(12)),
                          image: DecorationImage(
                              image: AssetImage('images/lake.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 8),
                    Container(
                        width: 24,
                        height: 24,
                        child: Image.asset('images/lake.jpg'))
                  ],
                ),
                SizedBox(width: 15),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('#米粉社区',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('破设计耽误的段子手  刚刚',
                        style: TextStyle(color: Color(0xFF93A2BE))),
                    SizedBox(height: 25),
                    Text('小米发布新logo~原研哉大师亲自操刀！！',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        InkWell(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 8),
                                height: 18,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 7),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF2199FF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(18)),
                                ),
                                child: Text('#求安慰',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10)))),
                        InkWell(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                                alignment: Alignment.center,
                                height: 18,
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 7),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF2199FF),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(18)),
                                ),
                                child: Text('#小米',
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10))))
                      ],
                    )
                  ],
                ))
              ],
            )
          ],
        ));
  }
}
