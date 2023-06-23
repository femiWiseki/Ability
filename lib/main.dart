// ignore_for_file: depend_on_referenced_packages

// import 'package:ability/splash_screen.dart'
import 'package:ability/splash_screen.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AgentPreference.init();
  await AggregatorPreference.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final indexNumber = StateProvider<int>((ref) => 0);
    return MaterialApp(
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: navigatorKey,
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 852,
          minWidth: 393,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(393, name: MOBILE),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      // supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
      // localizationsDelegates: const [
      //   flc.CountryLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      home: const SplashScreen(),
      // home: AggregatorLoginScreen(ValidationHelper(), AggregatorController()),
      // home: AgentLoginScreen(ValidationHelper(), AgentController()),
      // home: BottomNavBar(indexProvider: indexNumber),
    );
  }
}
