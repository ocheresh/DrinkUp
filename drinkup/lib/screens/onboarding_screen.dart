import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drinkup/constans/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _onIntroEnd(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);
    Navigator.of(context).pushReplacementNamed("/user_info");
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: AppColors.backgroundcolor,
      pages: [
        buildPage(
          title: "Легко слідкуй за водою",
          body: "DrinkUp допоможе контролювати кількість випитої води щодня.",
          icon: Icons.water_drop,
          color: AppColors.blue,
        ),
        buildPage(
          title: "Статистика",
          body: "Переглядай свою щоденну статистику та став цілі.",
          icon: Icons.bar_chart,
          color: AppColors.blue,
        ),
        buildPage(
          title: "Почни прямо зараз!",
          body: "Натисни кнопку нижче та зроби перший ковток 😉",
          icon: Icons.thumb_up,
          color: AppColors.blue,
        ),
      ],

      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text(
        "Пропустити",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      next: const Icon(Icons.arrow_forward, color: AppColors.blue),
      done: const Text("Почати", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

PageViewModel buildPage({
  required String title,
  required String body,
  required IconData icon,
  required Color color,
}) {
  return PageViewModel(
    title: title,
    body: body,
    image: Center(child: Icon(icon, size: 100, color: color)),
    decoration: PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      bodyTextStyle: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    ),
  );
}
