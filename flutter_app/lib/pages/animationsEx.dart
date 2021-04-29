import 'dart:math';
import 'package:flutter/physics.dart';

import 'package:flutter/material.dart';

class AnimationEX extends StatefulWidget {
  AnimationEX({Key key}) : super(key: key);

  @override
  _AnimationEXState createState() => _AnimationEXState();
}

class _AnimationEXState extends State<AnimationEX>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        // 这里有个问题目前， (当 animation的value 用在 fontSize上时,是那个logo内部有 延时)就是forward 的ui动画显示未完，就 complete了
        // print('状态$status');
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    // 用 AnimatedWidget 简化 分离 动画 和 ui
    /* ..addListener(() {
        // 这个语法意思是使用 animate() 的返回值调用 addListener() 方法。
        setState(() {
          // print('参数的值${animation.value}');
        });
      }); */
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('动画练习')),
        /* body: Container(
          margin: EdgeInsets.all(10),
          child: Center(child: FlutterLogo(size: animation.value))), */
        // 改版
        body: UiBox(
          animation: animation,
        ));
  }
}

/* 分离 动画 层 和 ui 组件 层 */
class UiBox extends AnimatedWidget {
  UiBox({Key key, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    // print('animation$animation');
    return Center(
        child: Container(
            margin: EdgeInsets.all(10),
            // width: animation.value,
            // height: animation.value,
            child: Center(
                child: FlutterLogo(
              size: animation.value,
              duration: const Duration(seconds: 0),
            ))));
  }
}

/* 
  不需要再去 实现；
  AnimatedBuilder 是 对于 AnimatedWidget 的 二次 封装；
  AnimatedBuilder(
    animation: animation,
    builder: (context, child) => Container(
          height: animation.value,
          width: animation.value,
          child: child,
        ),
    child: child),
  )
  这层的好处：
  1、在 animation 和 ui 分离的 情况下，更加细分 ui 上 静态部分(child) 和 动态部分(builder的 返回)；防止 静态部分的 再次渲染；只是 让 动态 部分 变化；
 */

// 复合动画
class AnimationExComplex extends StatefulWidget {
  AnimationExComplex({Key key}) : super(key: key);

  @override
  _AnimationComplexState createState() => _AnimationComplexState();
}

class _AnimationComplexState extends State<AnimationExComplex>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    /* controller 控制 动画的 执行事件 */
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    /* animation 控制 执行曲线 */
    animation = CurvedAnimation(parent: controller, curve: Curves.ease)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('动画练习')),
        /* body: Container(
          margin: EdgeInsets.all(10),
          child: Center(child: FlutterLogo(size: animation.value))), */
        // 改版
        body: PhysicsCardDragDemo()
        /* body: ListView(
          children: [
            // UiBoxComp(
            //   animation: animation,
            // ),
            FadeIn(),
            ConAni(),
            
          ],
        ) */
        );
  }
}

class UiBoxComp extends AnimatedWidget {
  /// 定义 复合动画
  static final _fistAnimation = Tween<double>(begin: 0.1, end: 1);
  static final _secAnimation = Tween<double>(begin: 0, end: 300);

  /// 看看 这里的 animation 并没有声明 属性，最后传给了 super中进行运用；
  UiBoxComp({Key key, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
        child: Opacity(
            opacity: _fistAnimation.evaluate(animation),
            child: Container(
                margin: EdgeInsets.all(10),
                // width: animation.value,
                // height: animation.value,
                child: Center(
                    child: FlutterLogo(
                  size: _secAnimation.evaluate(animation),
                  duration: const Duration(seconds: 0),
                )))));
  }
}

/* ==========================以上是 自实现 动画 曲线 ===================  */
// flutter 内部其实 也 内置了 很多 相关的 简单动画 基本 都是 集成自 AnimatedWidget
// 这里这些 内置的 都是 隐式动画

// 淡入
class FadeIn extends StatefulWidget {
  FadeIn({Key key}) : super(key: key);

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  double opacity = 0;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        AnimatedOpacity(
            opacity: opacity,
            duration: Duration(seconds: 2),
            child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: Center(child: Text('淡入文字')))),
        RaisedButton(
          onPressed: () {
            setState(() {
              opacity = 1;
            });
          },
          child: Text('发生渐变'),
        )
      ],
    );
  }
}

// container 统一 变化
class ConAni extends StatefulWidget {
  ConAni({Key key}) : super(key: key);

  @override
  _ConAniState createState() => _ConAniState();
}

class _ConAniState extends State<ConAni> {
  Color color;
  double margin;
  @override
  void initState() {
    super.initState();
    color = Colors.deepPurple;
    margin = _randomeMargin();
  }

  _randomeColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }

  _randomeMargin() {
    return Random().nextDouble() * 64;
  }

  @override
  Widget build(BuildContext context) {
    print('context${MediaQuery.of(context).size}');
    return Wrap(
      children: [
        AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            margin: EdgeInsets.all(margin),
            color: color,
            child: Container(
                width: 100,
                height: 100,
                child: Center(child: Text('1232323')))),
        ElevatedButton(
            onPressed: () {
              setState(() {
                color = this._randomeColor();
                margin = this._randomeMargin();
                // print('color$color,margin$margin');
                // print('Random()${Color(0xFFFFFFFF)}');
              });
            },
            child: Text('盒模型的变化'))
      ],
    );
  }
}

/* 物理动画 */
///  很多 参数 理解不了
class PhysicsCardDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableCard(
      child: FlutterLogo(
        size: 128,
      ),
    );
  }
}

/// A draggable card that moves back to [Alignment.center] when it's
/// released.
class DraggableCard extends StatefulWidget {
  final Widget child;
  DraggableCard({this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  /// The alignment of the card as it is dragged or being animated.
  ///
  /// While the card is being dragged, this value is set to the values computed
  /// in the GestureDetector onPanUpdate callback. If the animation is running,
  /// this value is set to the value of the [_animation].
  Alignment _dragAlignment = Alignment.center;

  Animation<Alignment> _animation;

  /// Calculates and runs a [SpringSimulation].
  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    // Calculate the velocity relative to the unit interval, [0,1],
    // used by the animation controller.
    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      setState(() {
        _dragAlignment = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) {
        _controller.stop();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2),
          );
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
