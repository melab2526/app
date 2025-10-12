import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/step_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loading_page.dart'; // ← これを追加！

class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF1),
      body: Column(
        children: [
          MeLabHeader(
            onBack: () => Navigator.pop(context),
          ),
          const SizedBox(height: 24),
          const StepIndicator(step: 3),
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "実験研究ノート\nあなたならどうまとめる？",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFA0855E),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                _buildChoices(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoices(BuildContext context) {
    return Column(
      children: [
        _buildChoice(context, "A：図と色を多く使って直感的にまとめる", Colors.red, const Color(0xFFFFCDD2), "A"),
        _buildChoice(context, "B：整理された文字と項目ごとのメモ", Colors.blue, const Color(0xFFBBDEFB), "B"),
        _buildChoice(context, "C：思いついたことをどんどん書きなぐる", Colors.orange, const Color(0xFFFFE0B2), "C"),
      ],
    );
  }

  Widget _buildChoice(BuildContext context, String text, Color color, Color borderColor, String choice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('answer3', choice);

          // ✅ 修正済み：LoadingPageを呼び出す
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoadingPage()),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
