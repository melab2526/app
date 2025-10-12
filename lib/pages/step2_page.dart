import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/step_indicator.dart';
import 'step3_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Step2Page extends StatelessWidget {
  const Step2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF1),
      body: Column(
        children: [
          // ヘッダー
          MeLabHeader(
            onBack: () => Navigator.pop(context),
          ),

          // ステップインジケーター
          const SizedBox(height: 24),
          const StepIndicator(step: 2),
          const SizedBox(height: 40),

          // 質問内容
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "研究発表の準備が近づいてきました。\nあなたはどのように進めますか？",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFA0855E),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),
                // 🔵 ここに「質問カード」呼び出し
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
        _buildChoice(context, "A：スライドの構成をしっかり練ってから資料を作る", Colors.red, const Color(0xFFFFCDD2), "A"),
        _buildChoice(context, "B：まず図表など視覚的な部分を作りながら考える", Colors.blue, const Color(0xFFBBDEFB), "B"),
        _buildChoice(context, "C：ぶっつけ本番でもなんとかなると思って進める", Colors.orange, const Color(0xFFFFE0B2), "C"),
      ],
    );
  }

  Widget _buildChoice(BuildContext context, String text, Color color, Color borderColor, String choice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('answer2', choice);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step3Page()));
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
