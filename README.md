# flytheme

快速实现三种主题效果。

本插件是从矿小助App中拆分出来的，优化了很多细节，更加简单易用。

内置持久化存储（使用share_preference实现）

矿小助App：https://kxz.atcumt.com/

pub插件地址：https://pub.dev/packages/flytheme

github仓库地址：https://github.com/cnatom/flytheme

## 快速上手

首先，导入fly_theme到pubspec.yaml文件

```dart
flytheme: ^x.x.x
```

## 初始化

使用了`share_preference`对主题配置进行持久化存储，所以要在`runApp()`前进行初始化

```dart
void main() async{
  await FlyApp.init();//必须要添加
  runApp(MyApp());
}
```

## 使用

在入口处添加`FlyApp`

```dart
class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return FlyApp(
      showBackgroundImg: true,//显示背景图片
      child: Scaffold(
        …………………………
      ),
    );
  }
}
```

> `FlyApp`内置了`MaterialApp`，因此不需要再重复添加。

## 组件

所有的组件都需要在`FlyApp`的子树内使用。

| 组件          | 功能                                           | 主要包含组件             |
| ------------- | ---------------------------------------------- | ------------------------ |
| FlyApp        | 最上层组件，内置MaterialApp用于配置ThemeMode   | FlyTheme                 |
| FlyContainer  | 一个容器，能够自动根据主题配置改变外观。       | FlyBackground、Container |
| FlyText       | 文字组件                                       | Text                     |
| FlyBackground | 放在FlyImage上层，用于为背景图添加模糊透明效果 | FlyImage                 |
| FlyImage      | 背景图                                         | Image                    |
| ThemeProvider | 核心组件，用于跨组件共享，使用Provider实现     | Provider                 |
| FlyTheme      | 主题配置                                       | ThemeData                |




## 例子

样例视频：https://www.bilibili.com/video/BV13f4y137Kx?spm_id_from=333.999.0.0

```dart
import 'package:flutter/material.dart';
import 'package:flytheme/app.dart';
import 'package:flytheme/module/container.dart';
import 'package:flytheme/module/text.dart';
import 'package:flytheme/provider.dart';

void main() async {
  //必须要添加
  await FlyApp.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FlyApp(
      showBackgroundImg: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: FlyText("FlyTheme插件示例"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),

          child: Column(
            children: [

              _buildButton("白色主题", onTap: () {
                //切换 白色主题/透明主题
                FlyApp.setThemeWhite();
              }),
              _buildButton("黑色主题", onTap: () {
                //切换 黑色主题/透明主题
                FlyApp.setThemeBlack();
              }),
              _buildButton("修改背景图片", onTap: () {
                FlyApp.setBackImage();
              }),
              //修改主题色
              FlyContainer(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: _buildColorSelector(),
              ),
              _buildSliver("卡片透明",
                  value: FlyApp.transCard,//获取透明度
                  onChanged: (value) {
                setState(() {
                  FlyApp.transCard = value;//设置卡片透明度
                });
              }),
              _buildSliver("背景模糊",
                  value: FlyApp.blurBack,//获取透明度
                  max: 20,
                  onChanged: (value) {
                    setState(() {
                      FlyApp.blurBack = value;//设置卡片透明度
                    });
                  }),
              _buildSliver("背景透明",
                  value: FlyApp.transBack,//获取透明度
                  onChanged: (value) {
                    setState(() {
                      FlyApp.transBack = value;//设置卡片透明度
                    });
                  }),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildColorCir(Color color){
    return InkWell(
      onTap: (){
        //更改主题色
        setState(() {
          FlyApp.colorMain = color;
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color
        ),
      ),
    );
  }
  Widget _buildButton(String text, {GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      //FlyContainer会根据主题配置变换
      child: FlyContainer(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            //FlyText会根据主题配置变换
            FlyText(
              text,
              fontSize: 17,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContainer(String title,
      {@required Widget child, GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      //FlyContainer作为背景板
      child: FlyContainer(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              //FlyText
              child: FlyText(
                title,
                fontSize: 17,
              ),
            ),
            Expanded(
              flex: 5,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildColorSelector(){
    List<Color> themeColors = [
      Color.fromARGB(255, 0, 196, 169),
      Color.fromARGB(255, 0, 186, 253),
      Color.fromARGB(255, 255, 64, 58),
      Color.fromARGB(255, 255, 116, 152),
      Color.fromARGB(255, 0, 109, 252),
      Color.fromARGB(255, 255, 206, 38),
      Color.fromARGB(255, 48, 54, 56),
      Color.fromARGB(255, 200, 200, 200),

    ];
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: themeColors.map((item){
          return _buildColorCir(item);
        }).toList(),
      ),
    );
  }

  Widget _buildSliver(String title,
      {@required double value,
      double max = 1.0,
      double min = 0.0,
      @required ValueChanged<double> onChanged}) {
    return _buildTitleContainer(title,
        child: Slider(
          activeColor: ThemeProvider().colorMain,//这里的主题色需要手动setState
          inactiveColor: Colors.black12,
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ));
  }
}

```

