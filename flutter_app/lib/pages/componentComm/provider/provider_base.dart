///
///   简单 实现 Provider 这种 跨足间 状态共享(前端就是 跟 有状态的 redux 或者说 vuex这种 类似)
///   1、优点：比起 event_bus 这种 通过发布订阅模式，只需要统一 管理 组件model 就好，而 event_bus 在 每个 页面都会 写相同的代码，api 发生变化或者 有修改都不利于维护
///
///   实现：
///     1、基于 InheritWidget 类，实现 数据 的共享；
///     2、数据共享，当 数据发生变化 需要使用 StateFulWidget 来 更新 对应的 Widget
///     3、建立上面 两者 的关系，还是需要 订阅发布模式实现，需要 用到 ChangeNotifier 来实现(当然还有其他的方式 event_bus)
///
import 'package:flutter/cupertino.dart';

/// 这个 例子 充分 理解泛型，在 dart 语言中的意义

///这里的 T 的 泛型是指 model  继承自 ChangeNotifier，用于存储共享数据的
class InheritProvider<T> extends InheritedWidget {
  final T data;
  InheritProvider({@required this.data, @required Widget child})
      : super(child: child);
  @override
  bool updateShouldNotify(InheritProvider<T> old) {
    return true;
  }
}

/// 这里 是更新 Widget 的关键类
class NotifyInheritProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T data;
  final Widget child;
  NotifyInheritProvider({Key key, this.data, this.child}) : super(key: key);
  // 提供个 静态 of 方法 拿到 InheritProvider 的实例
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritProvider<T>>()
            ?.widget as InheritProvider<T>;

    /// 这个 会 更新 依赖列表，这样 在调用 of 方法，会将 调用的 Widget 放入到更新依赖中，导致 button一直在更新，实际没有必要
    /* final provider =
        context.dependOnInheritedWidgetOfExactType<InheritProvider<T>>(); */
    /// 不会更新 依赖列表
    /* final provider = context
        .getElementForInheritedWidgetOfExactType<InheritProvider<T>>()
        ?.widget as InheritProvider<T>; */
    return provider?.data;
  }

  // 这里 也要加上 对应的 泛型
  @override
  _NotifyInheritProviderState<T> createState() =>
      _NotifyInheritProviderState<T>();
}

class _NotifyInheritProviderState<T extends ChangeNotifier>
    extends State<NotifyInheritProvider<T>> {
  @override
  void initState() {
    widget.data.addListener(_update);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NotifyInheritProvider<T> oldWidget) {
    if (oldWidget.data != widget.data) {
      oldWidget.data.removeListener(_update);
      widget.data.addListener(_update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.data.removeListener(_update);
    super.dispose();
  }

  /// 用于 更新 Widget
  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InheritProvider<T>(
        data: widget.data, // 从 statefulWidget 中 获取 当前 实例
        child: widget.child);
  }
}

/// 定义一个 consumer 组件，用于 统一封装 获取 InheritWidget的 实例
/// 增加 订阅和 消费 的 分离
class Consumer<T> extends StatelessWidget {
  const Consumer({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext context, T value) builder;
  @override
  Widget build(BuildContext context, {listen = true}) {
    return builder(
        context, NotifyInheritProvider.of<T>(context, listen: listen));
  }
}
