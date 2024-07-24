import 'package:app_vm/preferences/user.preferences.dart';
import 'package:app_vm/routing/routes.config.dart';
import 'package:app_vm/theme/theme.config.dart';
import 'package:app_vm/utils/permission.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await requestInitialPermission();
  runApp(VMApp());
}

class VMApp extends StatelessWidget {
  const VMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (_, orientation, screenType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        darkTheme: darkThemeData,
        title: "Test App",
        initialRoute: '/',
        getPages: appRoutes(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
      );
    });
  }
}
