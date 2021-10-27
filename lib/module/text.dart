import 'package:flutter/cupertino.dart';
import 'package:flytheme/provider.dart';
import 'package:provider/provider.dart';

class FlyText extends StatelessWidget {
  final TextAlign textAlign;
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final int letterSpacing;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  ThemeProvider themeProvider;

  FlyText(this.text,
      {Key key,
      this.textAlign,
      this.fontSize,
      this.color,
      this.maxLine,
      this.letterSpacing,
      this.fontWeight,
      this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Text(
      text,
      style: TextStyle(
          decoration: textDecoration ?? TextDecoration.none,
          color: color??themeProvider.colorText,
          fontSize: fontSize,
          fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLine,
    );
  }
}
