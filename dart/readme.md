# 20210330 初始 dart

## dart 的 变量 声明

### 明确声明 
变量类型 变量名称 = 赋值;
```dart
int str = '11'
```

### 类型推导
var 
dynamic 
final const
重点：final 和 const 的 区别：

const在赋值时, 赋值的内容必须是在编译期间就确定下来的
final在赋值时, 可以动态获取, 比如赋值一个函数

const放在赋值语句的右边，可以共享对象，提高性能

## 数据类型
1、数字类型
2、字符类型
3、bool类型
4、集合类型
list，set， map

## 函数 --- 跟 js 一样的 是 一等公民，一切皆对象
必选参数
可选参数
  命名可选 {}
  位置可选 []


## 特殊运算符
??= 等价于  a = c || d
?? 等价于 js的 ||

级联语法：..  就是 链式 调用
```dart
  class A {
    String name;
    a() {}
    b() {}
    c() {}
  }
  final a = new A();
  a.a();
  a.name = '1';
  a.b();
  a.c();

  const b = new A();
  b.a()
  ..name = '1'
  ..b()
  ..c();
```

## ** 类 和对象 重点 **##

### 常量构造方法
如果将构造方法前加const进行修饰，那么可以保证同一个参数，创建出来的对象是相同的

这样的构造方法就称之为常量构造方法。


注意一：拥有常量构造方法的类中，所有的成员变量必须是final修饰的.
注意二: 为了可以通过常量构造方法，创建出相同的对象，不再使用 new关键字，而是使用const关键字
如果是将结果赋值给const修饰的标识符时，const可以省略.

```dart
  main(List<String> args) {
    var p1 = const Person('why');
    var p2 = const Person('why');
    print(identical(p1, p2)); // true
  }

  class Person {
    final String name;

    const Person(this.name);
  }

```

### 类中的 关键字
extends ----- 只能单继承
abstract ----- 方法的抽象，只有型没有具体实现
implements ---- 必须把 对应的 方法 都必须 全部实现
mixin ---- 解决 extends 单继承，可以 同时混入 多个 （等同于 继承） 混入 方式：只是通过mixin定义的类用于被其他类混入使用，通过with关键字来进行混入


## 泛型 


## 引入第三方包 ---引出 pub 包管理 （跟 npm 有点像）

# 202010331 

## 异步模型