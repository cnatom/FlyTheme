import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytheme/provider.dart';
import 'package:flytheme/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlyApp extends StatefulWidget {
  Widget child;
  FlyApp(
      {@required this.child}
      );

  //初始化一些数据，该函数必须写在runApp之前，如：
  //void main() async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await FlyApp.init();
  //   runApp(MyApp());
  // }
  static init()async{
    FlyTheme.init(); //初始化色彩数据
    await ThemeProvider.init();// 初始化Provider
    return true;
  }

  //在黑色模式&透明模式之间切换
  static changeToBlack(){
    _FlyAppState.themeProvider.blackMode = !_FlyAppState.themeProvider.blackMode;
  }
  //在白色模式&透明模式之间切换
  static changeToWhite(){
    _FlyAppState.themeProvider.whiteMode = !_FlyAppState.themeProvider.whiteMode;
  }
  @override
  _FlyAppState createState() => _FlyAppState();
}

class _FlyAppState extends State<FlyApp> {
  static ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ThemeProvider())],
      builder: (context, _) {
        themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: FlyTheme.lightTheme,
          darkTheme: FlyTheme.darkTheme,
          home: widget.child,
        );
      },
    );
  }
}
