import 'package:flutter/material.dart';

class NoWhiteFlashTransition extends PageTransitionsBuilder {

  const NoWhiteFlashTransition();

  @override
  Widget buildTransitions<T extends Object?>(

      PageRoute<T> route,

      BuildContext context,

      Animation<double> animation,

      Animation<double> secondaryAnimation,

      Widget child,

      ) {

    return Container(

      color: const Color(0xFF001A2A),

      child: FadeTransition(

        opacity: animation,

        child: Container(color: const Color(0xFF001A2A), child: child),

      ),

    );

  }

}