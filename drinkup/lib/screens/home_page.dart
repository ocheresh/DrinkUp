import 'package:drinkup/widgets/water_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/water_entry.dart';
import '../providers/water_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAmount = ref.watch(todayWaterProvider);
    const dailyGoal = 2000; // мл

    return Scaffold(
      appBar: AppBar(title: const Text("DrinkUp")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ви випили сьогодні:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          WaterProgress(total: todayAmount, goal: dailyGoal),
          Text(
            "$todayAmount мл",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: todayAmount / dailyGoal,
            minHeight: 10,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(waterProvider.notifier)
                  .addEntry(WaterEntry(date: DateTime.now(), amount: 200));
            },
            child: const Text("Випити 200 мл"),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(waterProvider.notifier).resetToday(DateTime.now());
            },
            child: const Text("Скинути за сьогодні"),
          ),
        ],
      ),
    );
  }
}
