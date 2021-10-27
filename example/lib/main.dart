import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flytheme/app.dart';
import 'package:flytheme/module/container.dart';
import 'package:flytheme/theme.dart';
import 'package:flytheme/provider.dart';
import 'package:flytheme/test.dart';
import 'package:flytheme/module/text.dart';
void main() async{
  //必须要添加
  WidgetsFlutterBinding.ensureInitialized();
  await FlyApp.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FlyApp(
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: FlyText("FlyTheme插件"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildButton("白",onTap: (){
                FlyApp.changeToWhite();
                // themeProvider.darkMode = !themeProvider.darkMode;
              }),
              _buildButton("黑",onTap: (){
                FlyApp.changeToBlack();
                // themeProvider.darkMode = !themeProvider.darkMode;
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildButton(String text,{GestureTapCallback onTap}){
    return InkWell(
      onTap: onTap,
      child: FlyContainer(
        padding: EdgeInsets.all(20),
        child: FlyText(text),
      ),
    );
  }
}

