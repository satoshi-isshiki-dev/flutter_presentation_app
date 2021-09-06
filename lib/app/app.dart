import 'package:flutter/material.dart';
import 'package:flutter_presentation_app/app/app_model.dart';
import 'package:flutter_presentation_app/navigation/main_navigation.dart';
import 'package:flutter_presentation_app/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PseudoApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();

  const PseudoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      create: (context) => AppModel(),
      child: Consumer<AppModel>(
        builder: (context, appModel, _) {
          return MaterialApp(
            title: 'Pseudo App',
            theme: appModel.darkMode ? AppTheme.dark() : AppTheme.light(),
            routes: mainNavigation.routes,
            initialRoute: mainNavigation.initRoute,
            onGenerateRoute: mainNavigation.onGenerateRoute,
          );
        },
      ),
    );
  }
}
