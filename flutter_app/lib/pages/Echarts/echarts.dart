import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'indicator.dart';
// import 'package:flutter_echarts/flutter_echarts.dart'; // 模拟器上支持性不好

class EchartsPage extends StatelessWidget {
  const EchartsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Echarts页面')),
        body: Column(
          children: [PieChartSample2(), AspectTest()],
        ));
  }
}

class AspectTest extends StatelessWidget {
  const AspectTest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // height: 300,
      color: Colors.blue,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            width: 100,
            child: AspectRatio(
              // 宽高比 组件
              aspectRatio: 3 / 1,
              child: Container(
                color: Colors.red,
              ),
            )),
      ),
    );
  }
}

/* 支持性不好 */
/* class PieCom extends StatefulWidget {
  PieCom({Key key}) : super(key: key);

  @override
  _PieComState createState() => _PieComState();
}

class _PieComState extends State<PieCom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Echarts(option: '''{
    tooltip: {
        trigger: 'item'
    },
    legend: {
        top: '5%',
        left: 'center'
    },
    series: [
        {
            name: '访问来源',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
                borderRadius: 10,
                borderColor: '#fff',
                borderWidth: 2
            },
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '40',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
                {value: 1048, name: '搜索引擎'},
                {value: 735, name: '直接访问'},
                {value: 580, name: '邮件营销'},
                {value: 484, name: '联盟广告'},
                {value: 300, name: '视频广告'}
            ]
        }
    ]
}'''),
      width: 300,
      height: 250,
    );
  }
} */
class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        // pieTouchResponse.touchedSection 触发的 内容相关信息
                        // pieTouchResponse.touchInput 触发的 指针 事件 相关信息
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (pieTouchResponse.touchedSection != null &&
                              touchedIndex ==
                                  pieTouchResponse
                                      .touchedSection.touchedSectionIndex) {
                            return;
                          }
                          print(
                              '1=========${pieTouchResponse.touchInput is! PointerExitEvent}');
                          print(
                              '2=========${pieTouchResponse.touchInput is! PointerUpEvent}');
                          print('3=========${pieTouchResponse.touchedSection}');
                          // print(
                          //     'clickHappened${pieTouchResponse.clickHappened}'); // 目前没看到他的作用

                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          }
                          /*  else {
                            touchedIndex = -1;
                          } */
                        });
                      }),
                      borderData: FlBorderData(
                        show: false, // 绘制 区域的 border
                      ),
                      sectionsSpace: 0, // 每个 section 之间的 距离
                      centerSpaceRadius: 50, // 是 两个圆环 中间的 半径
                      sections: showingSections()), // 数据 层
                ),
              ),
            ) /* ,
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'First',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Second',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Third',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Fourth',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ) */
            ,
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final list = List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 80 : 60;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee), // 颜色的 控制
            value: 40, // 占据的 弧度
            title: '40%', // 显示的 数据
            radius: radius, // 半径的 控制
            titleStyle: TextStyle(
                // 颜色 的 style 配置
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
    return list;
  }
}
