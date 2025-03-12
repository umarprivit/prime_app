import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/controllers/dashboard_controller.dart';
import 'package:prime_app/routes.dart';
import 'package:prime_app/service/shared_preferences.dart';
import 'package:prime_app/widgets/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen(); // Start async operations immediately
  }

  Future<void> _navigateToNextScreen() async {
    bool isLoggedIn = await SharedPrefService().getIsLoggedIn() ?? false;
    print("IS LOGGED IN");
    print(isLoggedIn);

    if (isLoggedIn) {
      DashboardController con = Get.put(DashboardController());

      // Await all async operations before navigating
      await con.getHomePageSkills();


      if (mounted) {
        await Get.offAllNamed(Routes.DASHBOARD_SCREEN_ROUTE);
      }
    } else {
      if (mounted) {
        await Get.offAllNamed(Routes.INTRO_SCREEN_ROUTE);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Logo
          Center(
            child: Image.asset("assets/images/prime_logo.png"),
          ),

          // Loading Indicator
          Positioned(
            bottom: 100,
            left: 115,
            right: 115,
            child: BarLoading(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
