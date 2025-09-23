import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/water_entry.dart';

final waterProvider = StateNotifierProvider<WaterNotifier, List<WaterEntry>>((
  ref,
) {
  return WaterNotifier();
});

class WaterNotifier extends StateNotifier<List<WaterEntry>> {
  WaterNotifier() : super([]);

  void addEntry(WaterEntry entry) {
    state = [...state, entry];
  }

  void resetToday(DateTime today) {
    state = state.where((e) => !isSameDay(e.date, today)).toList();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

/// Провайдер для підрахунку сьогоднішньої кількості води
final todayWaterProvider = Provider<int>((ref) {
  final entries = ref.watch(waterProvider);
  final today = DateTime.now();

  return entries
      .where(
        (e) =>
            e.date.year == today.year &&
            e.date.month == today.month &&
            e.date.day == today.day,
      )
      .fold(0, (sum, e) => sum + e.amount);
});
