import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

class FlyContainer extends StatefulWidget {

  FlyContainer(
      {this.child,
        this.alignment,
        this.margin,
        this.padding,
        this.decoration,
        this.key,
        this.width,
        this.height,
        this.transValue,
        this.borderRadiusValue = 10,
        this.shadowBox}){
    if(shadowBox==null){
      shadowBox = BoxShadow(
          blurRadius: 10,
          spreadRadius: 0.05,
          color: Colors.black12.withAlpha(10)
      );
    }
  }

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Decoration decoration;
  final double height;
  final double width;
  final Key key;
  final double transValue;
  final double borderRadiusValue;
  final AlignmentGeometry alignment;
  BoxShadow shadowBox;

  @override
  _FlyContainerState createState() => _FlyContainerState();
}

class _FlyContainerState extends State<FlyContainer>{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      key: widget.key,
      margin: widget.margin,
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      decoration: widget.decoration??BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadiusValue),
          color: Theme.of(context)
              .cardColor
              .withOpacity(widget.transValue??themeProvider.transCard),
          boxShadow: [
            widget.shadowBox
          ]),
      child: widget.child,
    );
  }
}