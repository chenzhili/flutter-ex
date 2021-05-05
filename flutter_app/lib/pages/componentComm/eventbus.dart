import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/componentComm/User_Bean.dart';

EventBus eventBus = EventBus();

class EventBusWidget extends StatefulWidget {
  EventBusWidget({Key key}) : super(key: key);

  @override
  _EventBusWidgetState createState() => _EventBusWidgetState();
}

class _EventBusWidgetState extends State<EventBusWidget> {
  StreamSubscription streamData;
  UserBean userbean = UserBean(name: 'init', address: 'init_address');
  @override
  void initState() {
    super.initState();
    streamData = eventBus.on<UserBean>().listen((event) {
      setState(() {
        userbean = event;
      });
    });
  }

  @override
  void dispose() {
    streamData.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('event_bus')),
        body: Column(
          children: [
            RaisedButton(
                onPressed: () {
                  eventBus.fire(
                      UserBean(name: 'change', address: 'change_address'));
                },
                child: Text('event触发')),
            Text('名字${userbean.name}====地址${userbean.address}')
          ],
        ));
  }
}
