import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPrefernces appPrefernces = instance<AppPrefernces>();
  @override
  void didChangeDependencies() {
    appPrefernces.getLocal().then(
          (localValue) => context.setLocale(localValue),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
