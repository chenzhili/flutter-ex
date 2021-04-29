# 自动生成 readme 的 插件 readme-md-generator

# flutter

# 插件 安装 vscode 中 
flutter 和 dart
Code Runner

# 20210413 

## flutter 的 相关调试相关；
Dart DevTools 工具 类似于 chrome 的 开发者工具

1、对于 layout 的 调试 ---- flutter inspect 的 tabs

2、时间线图 --- 就是 从dart 代码到实际渲染 到页面的时间；

I、在 调试阶段一定要将 mode 调为 profile,两种方式：
一、在 vscode 的 launch.json 文件 
```json
"configurations": [
  {
    "name": "Flutter",
    "request": "launch",
    "type": "dart",
    "flutterMode": "profile"
  }
]
```

二、在 cmd 中 用 flutter run --profile


相关性能分析官网：https://flutter.cn/docs/development/tools/devtools/memory



# 20210427
## Future 的 基本理解 ，就是 js中的 Promise 一样；异步的处理

## 对于 dart 语言 写法的 优化 总结： https://www.dartcn.com/guides/language/effective-dart/usage#%E4%B8%8D%E8%A6%81-%E4%BD%BF%E7%94%A8-lambda-%E8%A1%A8%E8%BE%BE%E5%BC%8F%E6%9D%A5%E6%9B%BF%E4%BB%A3-tear-off

1、对于 函数的 默认值 赋值 用 = 不要用 : 
1、不要 显示的为参数初始化 null 值，dart 语言 不存在 “未初始化内存”