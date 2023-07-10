import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/authentication/presentation/widgets/landing_page.dart';
import 'package:ability/user_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? initScreen;

  @override
  void initState() {
    oneTimeOnBoarding();
    navToOnboarding();
    super.initState();
  }

  /// oneTimeOneOnBoarding method is used with SharedPreferences to show the Onboarding view only once.
  void oneTimeOnBoarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    initScreen = preferences.getInt("initScreen");
    await preferences.setInt("initScreen", 1);
  }

  navToOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    initScreen == 0 || initScreen == null

        // ignore: use_build_context_synchronously
        ? Future.delayed(const Duration(seconds: 3), () {
            PageNavigator(ctx: context).nextPageOnly(page: const LandingPage());
          })

        // ignore: use_build_context_synchronously
        : Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const UserState()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Center(
          child: SizedBox(
              width: 155,
              height: 148.39,
              child: Image.asset('assets/icons/app_logo.png')),
        ),
      ),
    );
  }
}
