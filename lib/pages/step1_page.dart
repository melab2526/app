import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/step_indicator.dart';
import 'step2_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Step1Page extends StatelessWidget {
  const Step1Page({super.key});
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
            const StepIndicator(step: 1),
            const SizedBox(height: 40),

            // 質問内容
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "実験装置が突然止まった！\nどうやらトラブルが起きたようです。\nあなたはどうする？",
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



  // 🟠 「質問カード」をここに定義する！
  Widget _buildChoices(BuildContext context) {
    return Column(
      children: [
        _buildChoice(context, "A：すぐに周囲の研究者に相談する", Colors.red, const Color(0xFFFFCDD2), "A"),
        _buildChoice(context, "B：マニュアルを見ながら自分で原因を探す", Colors.blue, const Color(0xFFBBDEFB), "B"),
        _buildChoice(context, "C：まず装置をリセットして、様子をみる", Colors.orange, const Color(0xFFFFE0B2), "C"),
      ],
    );
  }

  // 🟢 個々のボタンUI
  Widget _buildChoice(BuildContext context, String text, Color color, Color borderColor, String choice) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          // クリック時にローカル保存して次へ
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('answer1', choice);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const Step2Page()));
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
