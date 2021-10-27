import 'package:flutter/material.dart';

class FlyTheme {
  static  ThemeData darkTheme;
  static  ThemeData lightTheme;
  static init(){
    darkTheme = ThemeData(
        brightness: Brightness.dark,
        buttonColor: Color(0xff00c5a8).withOpacity(0.8),
        //弹窗背景色
        dialogBackgroundColor: Color(0xff1c1c1e),
        //按钮按下的色彩
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //文字主色
        primaryColor: Colors.white,
        //AppBar的文本色
        accentColor: Colors.white,
        //子页面背景色
        scaffoldBackgroundColor: Colors.black,
        //主页面背景色
        backgroundColor: Colors.black.withOpacity(0.9),
        //输入框色彩
        disabledColor: Color(0xff6C6C6C).withOpacity(0.7),
        //未选中项色彩
        unselectedWidgetColor: Color(0xff6C6C6C).withOpacity(0.5),
        //卡片色彩
        cardColor: Color(0xff151517),
        //指示器色彩
        indicatorColor: Colors.white,
        //输入指示器颜色
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white
        ),
        //Chip未选中色彩
        canvasColor: Color(0xff6C6C6C).withOpacity(0.5),
        appBarTheme: AppBarTheme(
          //控制系统顶栏文字色
          brightness: Brightness.dark,
          //AppBar阴影大小
          elevation: 0,
          color: Colors.black,
        ),
        //chip按钮主题
        chipTheme: ChipThemeData(
          //选中项背景色彩，两个最好是一样
          selectedColor: Color(0xff00c5a8),
          secondarySelectedColor: Color(0xff00c5a8),
          //选中项文字色彩
          labelStyle: TextStyle(color: Colors.white54),
          //未选中项背景色彩
          disabledColor: Color(0xff6C6C6C).withOpacity(0.5),
          //未选中项文字色彩
          secondaryLabelStyle: TextStyle(color: Colors.white),
          //暂时没啥用的参数，但不能没有
          brightness: Brightness.dark,
          padding: EdgeInsets.all(4.0),
          shape: StadiumBorder(),
          backgroundColor: Colors.transparent,
        ));
    lightTheme = ThemeData(
        buttonColor: Color(0xff00c5a8),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //子页面背景色
        scaffoldBackgroundColor: Color(0xfff2f5f7),
        //主页面背景色
        backgroundColor: Color(0xfff2f5f7).withOpacity(0),
        //文字主色
        primaryColor: Colors.black,
        //AppBar文字
        accentColor: Colors.white,
        //输入框色彩
        disabledColor: Color(0xffecedef),
        //未选中项色彩
        unselectedWidgetColor: Color(0xff6C6C6C).withOpacity(0.5),
        //底部导航栏
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            unselectedItemColor: Colors.white.withOpacity(0.5), //底部导航蓝未选中色
            selectedItemColor: Colors.white),
        appBarTheme: AppBarTheme(
          //控制系统顶栏文字色
          brightness: Brightness.light,
          //AppBar阴影大小
          elevation: 0,
          color: Colors.transparent,
        ),
        //卡片背景
        cardColor: Colors.white,
        //指示器颜色
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black
        )
    );
  }

}