import 'package:flutter/cupertino.dart';

class Dimensions {

  static const double designWidth = 393;
  static const double designHeight = 873;


 static double calculateHeight(double size,BuildContext context){
        return size * MediaQuery.of(context).size.height /designHeight;
  }
 static double calculateWidth(double size, BuildContext context){
    return size * MediaQuery.of(context).size.width / designWidth;
  }
}