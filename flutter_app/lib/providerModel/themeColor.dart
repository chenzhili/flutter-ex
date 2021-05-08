import 'package:flutter/cupertino.dart';

import '../theme.dart';

/// 用于全局更新 主题的 model
class ThemeColorModel extends ChangeNotifier {
  Color _mainTheme = themeColorMap['blue'];
  Color get theme => _mainTheme;
  void changeTheme(theme) {
    _mainTheme = themeColorMap[theme];
    notifyListeners();
  }
}
