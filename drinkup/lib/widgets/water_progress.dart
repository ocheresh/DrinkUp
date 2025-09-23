import 'package:flutter/material.dart';

class WaterProgress extends StatelessWidget {
  final int total;
  final int goal;

  const WaterProgress({Key? key, required this.total, required this.goal})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percent = (total / goal).clamp(0, 1.0);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.blue.shade50,
                ),
              ),
              Container(
                width: 150,
                height: (150 * percent).toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: Colors.lightBlueAccent,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text('$total / $goal ml'),
      ],
    );
  }
}
