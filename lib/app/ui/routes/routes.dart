import 'package:vision_board/app/ui/screens/settings/settings_screen.dart';
import 'package:vision_board/app/ui/screens/onboard/onboard_screen.dart';
import 'package:vision_board/app/ui/screens/splash/splash_screen.dart';
import 'package:vision_board/app/ui/screens/add/add_screen.dart';
import 'package:vision_board/app/domain/states/add_state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

abstract class RoutesName {
  static const String splash = '/';
  static const String add = '/add';
  static const String settings = '/settings';
  static const String onboard = '/onboard';
}

class AppRoutes {
  static const initalRoute = RoutesName.splash;
  static final routes = <String, Widget Function(BuildContext contex)>{
    RoutesName.settings: (contex) => const SettingsScreen(),
    RoutesName.onboard: (contex) => const OnboardScreen(),
    RoutesName.splash: (contex) => const SplashScreen(),
    RoutesName.add: (contex) => ChangeNotifierProvider(
        create: (context) => AddState(), child: const AddScreen()),
  };
}
