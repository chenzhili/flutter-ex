import 'package:flutter/material.dart';
import 'package:flutter_app/pages/componentComm/provider/provider_base.dart';

import 'models/test.dart';

class ProviderBasePage extends StatefulWidget {
  ProviderBasePage({Key key}) : super(key: key);

  @override
  _ProviderBasePageState createState() => _ProviderBasePageState();
}

class _ProviderBasePageState extends State<ProviderBasePage> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    print('=======');
    return Scaffold(
        appBar: AppBar(title: Text('测试 cus_provider')),
        body: NotifyInheritProvider<TestModel>(
          data: TestModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    print('dfsdfsf=======');
                    return RaisedButton(
                      child: Text("添加商品"),
                      onPressed: () {
                        //给购物车中添加商品，添加后总价会更新
                        NotifyInheritProvider.of<TestModel>(context,
                                listen: false)
                            .addItem(
                                GoldItem(name: '商品${index++}', price: index));
                      },
                    );
                  },
                ),
                // 优化
                Consumer<TestModel>(builder: (context, value) {
                  print('consumer=====');
                  return Text('价格：${value.totalPrice}');
                }),
                // 老的
                /* Builder(builder: (context) {
                  final totalPrice =
                      NotifyInheritProvider.of<TestModel>(context).totalPrice;
                  return Text('价格：$totalPrice');
                }), */
                Expanded(child: Builder(builder: (context) {
                  List<GoldItem> list =
                      NotifyInheritProvider.of<TestModel>(context).items;
                  final widgets = list
                      .map((e) => Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(e.name),
                          ))
                      .toList();
                  return ListView(
                    children: widgets,
                  );
                }))
              ],
            );
          }),
        ));
  }
}
