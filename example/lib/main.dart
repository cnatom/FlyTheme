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
