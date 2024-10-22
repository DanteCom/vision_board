import 'package:vision_board/app/domain/states/home_state.dart';
import 'package:vision_board/app/ui/theme/app_theme.dart';
import 'package:vision_board/app/ui/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeState(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initalRoute,
          theme: AppTheme.appTheme,
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
