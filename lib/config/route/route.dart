import 'package:bloc_tutorial/config/route/route_name.dart';
import 'package:flutter/material.dart';

import '../../view/view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      // case RouteName.homeScreen: return MaterialPageRoute(builder: (context) => HomeScreen());
      case RouteName.homeScreen:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // const begin = Offset(1.0, 0.0);
            // const end = Offset.zero;
            // const curve = Curves.decelerate;

            // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            // return SlideTransition(
            //   position: animation.drive(tween),
            //   child: child,
            // );

            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      case RouteName.detailScreen:
        final movieName = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DetailScreen(
                  movieName: movieName,
                ));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No Route Generate'),
            ),
          );
        });
    }
  }
}
