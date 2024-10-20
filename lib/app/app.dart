import 'package:vision_board/app/ui/routes/routes.dart';
import 'package:vision_board/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      routes: AppRoutes.routes,
    );
  }
}
