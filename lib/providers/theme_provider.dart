import '../exports.dart';

enum ThemeModeType {
  light,
  dark,
}

class ThemeProvider with ChangeNotifier {
  ThemeModeType _themeModeType = ThemeModeType.light;

  ThemeMode get themeMode {
    return _themeModeType == ThemeModeType.light
        ? ThemeMode.light
        : ThemeMode.dark;
  }

  void toggleTheme() {
    _themeModeType = _themeModeType == ThemeModeType.light
        ? ThemeModeType.dark
        : ThemeModeType.light;
    notifyListeners();
  }
}
