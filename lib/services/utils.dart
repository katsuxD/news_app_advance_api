import 'package:flutter/material.dart';
import 'package:flutter_news_api_advance/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size get getScreenSize => MediaQuery.of(context).size;
  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;

  Color get getColor => getTheme ? Colors.white : Colors.black;
  Color get getColorIcon => getTheme ? Colors.white : Colors.grey.shade600;
  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;

  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;
}
