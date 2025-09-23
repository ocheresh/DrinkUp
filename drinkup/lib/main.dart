import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_page.dart';
import 'screens/user_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // final seenOnboarding = prefs.getBool("seenOnboarding") ?? false;

  final seenOnboarding = false; // тимчасово потрібно видалити

  runApp(ProviderScope(child: DrinkUpApp(seenOnboarding: seenOnboarding)));
}

class DrinkUpApp extends StatelessWidget {
  final bool seenOnboarding;

  const DrinkUpApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrinkUp',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: seenOnboarding ? "/home" : "/onboarding",
      routes: {
        "/onboarding": (context) => const OnboardingScreen(),
        "/user_info": (context) => const UserInfoScreen(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}
