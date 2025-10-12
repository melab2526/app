import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/header.dart';
import '../widgets/step_indicator.dart';
import 'step1_page.dart';
import '../widgets/screen_frame.dart';


class Step0Page extends StatefulWidget {
  const Step0Page({super.key});

  @override
  State<Step0Page> createState() => _Step0PageState();
}

class _Step0PageState extends State<Step0Page> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _nextStep() async {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ソウルナンバーを入力してください")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("answer0", _controller.text);

    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Step1Page()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF1),
      body: Column(
        children: [
          // 🟢 ヘッダー
          MeLabHeader(
            onBack: () => Navigator.pop(context),
          ),

          const SizedBox(height: 24),

          // 🟡 ステップバー
          const StepIndicator(step: 0),

          const SizedBox(height: 40),

          // 🟣 メイン内容（←ここをExpandedで包む）
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Q1で選んだソウルナンバー",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFA0855E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      width: 250,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFFEAFFEA),
                        border: Border.all(color: Color(0xFFCFECCD)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "入力",
                          hintStyle: TextStyle(color: Color(0xFF9BD19A)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFAECDF7),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        shadowColor: const Color.fromRGBO(80, 140, 200, 0.25),
                        elevation: 6,
                      ),
                      onPressed: _nextStep,
                      child: const Text(
                        "次へ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
