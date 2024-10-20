import 'package:flutter/material.dart';
import 'package:vision_board/app/ui/screens/add/add_screen.dart';
import 'package:vision_board/app/ui/screens/edit/edit_screen.dart';
import 'package:vision_board/app/ui/screens/home/home_screen.dart';
import 'package:vision_board/app/ui/screens/onboard/onboard_screen.dart';
import 'package:vision_board/app/ui/screens/splash/splash_screen.dart';

abstract class RoutesName {
  static const String splash = '/';
  static const String home = '/home';
  static const String add = '/home/add';
  static const String edit = '/home/edit';
  static const String onboard = '/onboard';
  static const String settings = '/home/settings';
}

class AppRoutes {
  static const initalRoute = RoutesName.splash;
  static final routes = <String, Widget Function(BuildContext contex)>{
    RoutesName.splash: (contex) => const SplashScreen(),
    RoutesName.onboard: (contex) => const OnboardScreen(),
    RoutesName.home: (contex) => const HomeScreen(),
    RoutesName.add: (contex) => const AddScreen(),
    RoutesName.edit: (contex) => const EditScreen(),
  };
}
