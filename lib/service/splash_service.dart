import 'dart:async';

import 'package:bloc_tutorial/config/route/route_name.dart';
import 'package:flutter/material.dart';

class SplashServie{
  void doSplash(BuildContext context){
    Timer(const Duration(seconds: 1), () => 
    Navigator.pushNamedAndRemoveUntil(context, RouteName.homeScreen, (route) => false));
  }
}