# 20210413

## crossAxisAlignment 和 mainAxisAlignment 的区别

mainAxisAlignment： 是指 在 主轴方向的对齐方式
crossAxisAlignment：是在 跟主轴 垂直的 方向的 对齐 方式

如： Column 上 交叉轴就是 x 轴， y 为 主轴

## class 和 Map 不是 同一种 类型，不能 相互声明

# 20210416

1、相对的 100% 的表示方式 width: double.infinity, height: double.infinity, color: Colors.red);
未探索：
1、router 和 navigator
2、网络请求交互
3、图表的支持性：
fcharts flutter_circular_chart flutter_charts
flutter_charts 可能更接近 echarts 的 所有交互，想实现 对应的 交易 交互；需要用到对应的 custom 方式

# 20210425

## 命名式路由；

1、命名式路由，管理 需要 在 同一个 materialApp 下 声明的 才行；
2、路由中，目前 在整个项目 中 目前看来 只能出现 一个 MaterialApp 这个 组件来承载 整个项目

# 20210426

## 问题： 对于 list 中 放入 class 出问题 了??????????????；

在 dart 中， 感觉 class 不能当做一等公民 在 函数中 传值(javascript 中 可以 进行 传值，class 是 模拟的 function)； 遍历中 直接 将她 转换成了 实例；

```dart
  class T {
    static const name = 'name';
  }
  print('这里取值就是对的${T.name}');
  final List l = [T]
  l.forEach((e){
    print('这里要报错${e.name}');
  })
```

## 问题，在 Navigator 中 对于 context 的重要切换 问题；URL： https://blog.csdn.net/chunqiuwei/article/details/106680763

MaterialApp 和 Navigator 会生成 对应的 routes 相关的内容，进行做 页面导航

```dart
  // 路由 跳转中
  Navigator.of(context).pushNamed(context, 'name'); // 这里 的 context 要看 是 哪个  Navigator 实例；
```

# 20210428

## 隐式动画 和 显式动画的区别

隐式动画和显示动画的区别？
1，隐式动画是一次性的，单方向的，由某个属性值的变化驱动，例如透明度从 0 到 1 的变化，无法实现动画效果从 0 到 1 再到 0 的自动重复，且动画一旦开始就无法停止，直到动画完成。
2，隐式动画只能控制 duration 和 curve，不需要创建控制器 controller，只需几行代码就可实现简单的动画效果，显式动画则有更多的控制权，比如可以随时控制动画的开始和暂停，并且可以实现循环的，交错的变化效果。
3，隐式动画可以做的，显式动画都可以实现，只是实现起来相对比较麻烦一些，下一章我们将具体讲解显式动画。

## flutter 中的 色系

1、Color c1 = Color(0xFF3CAAFA);
2、Color c2 = Color.fromRGBO(60, 170, 250, 1);
3、Color c3 = Color.fromARGB(255, 60, 170, 250);
4、Color c5 = Colors.blue;

1、Color(int value)
Color(0xFF3CAAFA),value 接收的是一个十六进制（0x 开头),FF 表示的是十六进制透明度(00-FF),3CAAFA 是十六进制色值。

2、Color.fromRGBO(int r, int g, int b, double opacity)
Color.fromRGBO(60, 170, 250, 1)，r、g、b 分别表示 red、green、blue，常规的红绿蓝三色，取值范围为 0-255，opacity 表示透明度，取值 0.0-1.0。

3、Color.fromARGB(int a, int r, int g, int b)
Color.fromARGB(255, 60, 170, 250),a 表示透明度，取值 0-255，rgb 同上一样。

4、Colors.\_()
Colors 类定义了很多颜色，可以直接使用，例如 Colors.blue,其实就是第一种 Color(int value)的封装。

## flutter 总的 setState 进行 更新 视图 的优化 理解 ===== https://www.jianshu.com/p/24018d234210

# 20210429

## 夜神模拟器 不支持 GL_OES_EGL_image_external ，导致 flutter_echarts 不能正常使用

## 在 夜神模拟器中没有问题的，在 网易的 mumu 模拟器会显示白屏

报错： [ERROR:flutter/shell/gpu/gpu_surface_gl.cc(58)] Failed to setup Skia Gr context
解决： flutter run --enable-software-rendering ---- 这样跑项目 (还是跑不起来 flutter_echarts，在 android 自带的 simulate 中 可以跑)

## 对于 图库 的 集成，在 github 上 ，start 多的 是 fl_chart

# 20210430

## 如果链接 不上 mumu 模拟器，用 adb 强行链接：adb connect 127.0.0.1:7555

## 需要解决的 问题

1、对于 整个项目 需要 引入 统一 共享的 仓库 ===》 实践：实现 动态主题切换；
2、绘制 图形，并且 交互的 实现；（走势图感觉 可以使用 f_chart 实现）
3、了解 CustomPainter 实现 自定义 ，用于实现 k 线 和 走势图
url: https://github.com/GitHubYhb/HBLineChart

# 20210503

## fl_chart 不能满足 需求，需要用 canvas 自定义；

## 做组件的 通信

1、InheritedWidget
2、Notification
3、event_bus // 这是 一个 用 StreamController 进行 二次封装的库
4、provider // 使用 inhertedWidget 二次封装的库

# 20210508

## 解决 了 tab 中的 子路由 在 物理返回中不能返回的问题（主要是 拿不到子 Navigator 的 实例）；

## 添加 flutter 的 工具库 ---- flustars

## 加入 主题，用 provider 实现，并且 用 flustars的spUtils 实现 持久化
