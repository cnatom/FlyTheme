import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytheme/module/background.dart';
import 'package:flytheme/provider.dart';
import 'package:flytheme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlyApp extends StatefulWidget {
  Widget child;
  bool showBackgroundImg;
  Color color;
  FlyApp(
      {
        @required this.child,
        this.showBackgroundImg = true,
        this.color = Colors.lightGreen
      }
      );

  //初始化一些数据，该函数必须写在runApp之前，如：
  //void main() async{
  //   await FlyApp.init();
  //   runApp(MyApp());
  // }
  static init()async{
    WidgetsFlutterBinding.ensureInitialized();
    FlyTheme.init(); //初始化色彩数据
    await ThemeProvider.init();// 初始化Provider
    return true;
  }

  //在黑色模式&透明模式之间切换
  static setThemeBlack(){
    _FlyAppState.themeProvider.blackMode = !_FlyAppState.themeProvider.blackMode;
  }
  //在白色模式&透明模式之间切换
  static setThemeWhite(){
    _FlyAppState.themeProvider.whiteMode = !_FlyAppState.themeProvider.whiteMode;
  }
  //修改背景图片
  static setBackImage(){
    _FlyAppState.themeProvider.changeBackImg();
  }
  //修改卡片透明度
  static set transCard(double value){
    _FlyAppState.themeProvider.transCard = value;
  }
  //获取卡片透明度
  static get transCard => _FlyAppState.themeProvider.transCard;
  //修改背景透明度
  static set transBack(double value){
    _FlyAppState.themeProvider.transBack = value;
  }
  //获取背景透明度
  static get transBack => _FlyAppState.themeProvider.transBack;
  //修改背景模糊度
  static set blurBack(double value){
    _FlyAppState.themeProvider.blurBack = value;
  }
  //获取背景模糊度
  static get blurBack => _FlyAppState.themeProvider.blurBack;
  //设置主题色
  static set colorMain(Color color){
    _FlyAppState.themeProvider.colorMain = color;
  }
  @override
  _FlyAppState createState() => _FlyAppState();
}

class _FlyAppState extends State<FlyApp> {
  static ThemeProvider themeProvider;

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
          home: widget.showBackgroundImg?FlyBackground(
            child: widget.child,
          ):widget.child,
        );
      },
    );
  }
}
