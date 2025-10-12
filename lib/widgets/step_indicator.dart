import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int step; // 現在のステップ番号（0〜3）

  const StepIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    double progress = 0.0;
    Color progressColor = const Color(0xFFC1F2A5); // デフォルト色（STEP1と同じ）

    switch (step) {
      case 0:
        progress = 0.0;
        break;
      case 1:
        progress = 0.33;
        progressColor = const Color(0xFFC1F2A5);
        break;
      case 2:
        progress = 0.66;
        progressColor = const Color(0xFFF4E796);
        break;
      case 3:
        progress = 1.0;
        progressColor = const Color(0xFFEDBC9C);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "STEP$step",
            style: const TextStyle(
              color: Color(0xFF69C14D),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 130,
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEDED),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress, // ← 進捗に応じて幅を変える
                child: Container(
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
