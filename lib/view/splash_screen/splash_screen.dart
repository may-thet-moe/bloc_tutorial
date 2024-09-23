import 'package:bloc_tutorial/service/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServie splashServie = SplashServie();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServie.doSplash(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.movie_filter, size: 100, color: Colors.blue,),
      ),
    );
  }
}