import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {


  //主题模式，用于在MaterialApp入口处设置主题模式
  static ThemeMode _themeMode = ThemeMode.light;

  //基础变量
  static bool _blackMode;//黑色模式
  static bool _whiteMode;//白色模式
  static double _transBack; //背景透明度
  static double _blurBack; //背景模糊度
  static double _transCard; //卡片透明度 最大0.5
  static Color _colorMain;//主题色
  static Color _colorText;///文字色彩；黑色模式:变白|白色模式：变黑|透明模式：变白
  static final int _colorDefaultValue = 4278240425;//默认的主题色

  //get方法
  bool get whiteMode => _whiteMode;
  ThemeMode get themeMode => _themeMode;
  bool get blackMode => _blackMode;
  double get transBack => _transBack;
  double get blurBack => _blurBack;
  double get transCard => _transCard;
  Color get colorMain => _colorMain;
  Color get colorText => _colorText;

  //本地化存储实例
  static SharedPreferences _prefs;

  //透明默认主题配置
  static Map _transDefault = {
    "darkMode": false,
    "simpleMode":false,
    "transBack": 0.25,
    "blurBack": 8.0,
    "transCard": 0.1,
    "colorMain": _colorDefaultValue
  };
  //白色默认主题配置
  static Map _whiteDefault = {
    "darkMode": false,
    "simpleMode":true,
    "transBack": 0.85,
    "blurBack": 20.0,
    "transCard": 0.8,
    "colorMain": _colorDefaultValue
  };
  //黑色默认主题配置
  static Map _blackDefault = {
    "darkMode": true,
    "simpleMode":false,
    "transBack": 1.0,
    "blurBack": 8.0,
    "transCard": 0.8,
    "colorMain": _colorDefaultValue
  };
  ///初始化主题数据
  static Future<bool> init() async{
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("themeData_Fly") == null) {
      _initFromJson(_transDefault);
      _savePrefs();
    } else {
      _initFromJson(jsonDecode(_prefs.getString("themeData_Fly")));
    }
    return true;

  }
  //恢复默认配置
  _restore(){
    debugPrint("@restore");
    _jsonToTheme(_transDefault);
  }
  ///本地化持久存储
  static _savePrefs() {
    _prefs.setString("themeData_Fly",jsonEncode(_toJson()));
  }
  //切换主题
  static _jsonToTheme(dynamic json){
    _blackMode = json["darkMode"];
    _whiteMode = json["simpleMode"];
    _blurBack = json["blurBack"];
    _transCard = json["transCard"];
    _transBack = json["transBack"];
    _colorText = _whiteMode?Colors.black:Colors.white;
    _themeMode = _blackMode ? ThemeMode.dark : ThemeMode.light;

  }
  ///Json->类对象
  static _initFromJson(dynamic json) {
    _jsonToTheme(json);
    _colorMain = Color(json['colorMain']);

  }

  ///将主题数据打包成Json
  static Map<String, dynamic> _toJson() {
    var map = <String, dynamic>{};
    map["darkMode"] = _blackMode;
    map["simpleMode"] = _whiteMode;
    map["transBack"] = _transBack;
    map["blurBack"] = _blurBack;
    map["transCard"] = _transCard;
    map['colorMain'] = _colorToHex(_colorMain);
    return map;
  }
  //true : 白色模式
  //false : 透明模式
  set whiteMode(bool value) {
    _whiteMode = value;
    if(_whiteMode){
      _jsonToTheme(_whiteDefault);
    }else{
      _restore();
    }
    notifyListeners();
    _savePrefs();
  }
  //true : 黑色模式
  //false : 透明模式
  set blackMode(bool value) {
    _blackMode = value;
    if (blackMode) {
      _jsonToTheme(_blackDefault);
    } else {
      _restore();
    }
    notifyListeners();
    _savePrefs();
  }

  //设置背景的透明度
  set transBack(double value) {
    if (value > 0 && value < 1) {
      _transBack = value;
      notifyListeners();
      _savePrefs();
    }
  }

  //设置背景的模糊度
  set blurBack(double value) {
    _blurBack = value;
    notifyListeners();
    _savePrefs();
  }

  //设置卡片的透明度
  set transCard(double value) {
    _transCard = value;
    notifyListeners();
    _savePrefs();
  }

  //设置主题色
  set colorMain(Color color) {
    _colorMain = color;
    notifyListeners();
    _savePrefs();
  }
  //将Color变成int值，方便本地化存储
  static int _colorToHex(Color color){
    int result;
    try{
      result = int.parse('0x${color.value.toRadixString(16).padLeft(8, '0')}');
    }catch(e){
      debugPrint(e.toString());
      result = 0x00bafd;
    }
    return result;
  }

}