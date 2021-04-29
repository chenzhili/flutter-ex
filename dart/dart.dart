import 'dart:io';

void main() {
  // print(1);
  // test('123', p: 1, b: 1);
  // posTest('12');

  // var temp = 'why';
  // // var temp = null;
  // var name = temp ?? 'kobe';
  // print(name);

  // var name1 = 'coderwhy';
  // print(name1);
  // var name2 = 'kobe';
  // // var name2 = null;
  // name2 ??= 'james';
  // print(name2);

  // var a;
  // if (a == null) {
  //   print(1213);
  // }

  // print(new A('name', 23));
  // print(T.red);

  // print(2);
  // Future.value(2).then((value) {
  //   print(value);
  // });
  // print(3);

  // var a = new CO();
  // a.a();
  //
  // Aa abc = new Aa(1);
  // print(abc.aa);
  //
  // List TA = [];
  // TA.add(() => Test);
  // Test a;
  // TA.forEach((e) {
  //   a = e();
  //   print('sdfsdfsf${a.age}');
  // });
  // final ab = Tt(12);
  /* final child = Child();
  print('${child.a}${child.b}'); */
  var aa = Testa();
  print(aa.b);
  print(aa is Test);
}

abstract class Test {
  late String a;
  String b = '123';
  void Testaa();
}

class Testa extends Test {
  String a = '1';
  void Testaa() {
    print('12323');
  }
}

/* 函数 不能 承载 class */
/* class Tt {
  int b = 1;
  Tt(int v) : b = v {
    // b = v 表达式的 赋值 执行在 这个之前；
    print('实际的 b的值$b');
  }
}

class Parent {
  final b;
  Parent(this.b);
  Parent.a(this.b);
}

class Child extends Parent {
  final a = 2;
  Child() : super(null);
} */

// /* 函数 的 测试 */
// // 命名可选
// test(String a, {int? b, double? p}) {
//   print('$a, $b, $p');
// }

// // 位置可选
// posTest(String a, [int? c = 1, double? d = 2]) {
//   print('$a,$c,$d');
// }

// var a = null ?? 1;

// /* 类和 对象 */
// class A {
//   String name;
//   int age;
//   // 构造函数 赋值的 语法糖
//   A(this.name, this.age);
// }

// Set<String> aaa = {'1', '2'};
// var ab = {'a': 1, 'c': 2};

// enum T { red, green }

// abstract class AB<T> {
//   T a(T a) {
//     return a;
//   }
// }

// class O {
//   void a() {
//     print('aaaa');
//   }
// }

// class CO extends O {
//   @override
//   void a() {
//     print('bbbb');
//   }
// }

// T test_a<T>(T a) {
//   return a;
// }
// class Test {
//   static const name = 'test';
//   int age = 11;
// }
