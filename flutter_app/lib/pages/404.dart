import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  // 必填
  static const name = 'notFound';
  const NotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('404'),
    );
  }
}
