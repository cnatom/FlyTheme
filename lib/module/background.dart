import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class FlyBackground extends StatefulWidget {
  final Widget child;
  Color color;
  FlyBackground({Key key, @required this.child,this.color}) : super(key: key);

  @override
  _FlyBackgroundState createState() => _FlyBackgroundState();
}

class _FlyBackgroundState extends State<FlyBackground> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: [
        FlyImage(backColor: widget.color,),//背景图片
        themeProvider.whiteMode?BackdropFilter(
            filter: ImageFilter.blur(sigmaX: themeProvider.blurBack,sigmaY: themeProvider.blurBack),
            child: Container(color: Colors.white.withOpacity(themeProvider.transBack),)):ClipRect(
          //背景过滤器
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: themeProvider.blurBack,sigmaY: themeProvider.blurBack),
            child: Container(
              color: Colors.black.withOpacity(themeProvider.transBack),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
class FlyImage extends StatefulWidget {
  Color backColor;
  FlyImage(
  {this.backColor = Colors.lightGreen});
  @override
  _FlyImageState createState() => _FlyImageState();
}

class _FlyImageState extends State<FlyImage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    debugPrint(themeProvider.imgPath);
    return themeProvider.imgPath==null?Positioned.fill(
      child: Container(
        color: widget.backColor,
      ),
    ):Positioned.fill(
      child: Image.file(File(themeProvider.imgPath),fit: BoxFit.cover,),
    );
  }
}
