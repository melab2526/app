import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/header.dart'; // ← widgets → widget に注意！
import 'result_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late Timer _timer;
  int _imageIndex = 0;
  final List<String> _flaskImages = [
    'assets/Group1.png',
    'assets/Group2.png',
  ];

  @override
  void initState() {
    super.initState();

    // 🧪 フラスコ画像を1秒ごとに切り替え
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _imageIndex = (_imageIndex + 1) % _flaskImages.length;
      });
    });

    // ⏳ 4秒後に結果ページへ遷移
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResultPage()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF1),
      body: Column(
        children: [
          // 🟢 上部ヘッダー
          MeLabHeader(
            onBack: () => Navigator.pop(context),
          ),

          // 🧪 残りを中央に
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _flaskImages[_imageIndex],
                    width: MediaQuery.of(context).size.width * 0.25,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  const _AnimatedDotsText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔵 診断中... のドットアニメーション
class _AnimatedDotsText extends StatefulWidget {
  const _AnimatedDotsText();

  @override
  State<_AnimatedDotsText> createState() => _AnimatedDotsTextState();
}

class _AnimatedDotsTextState extends State<_AnimatedDotsText> {
  int dotCount = 0;
  late Timer _dotTimer;

  @override
  void initState() {
    super.initState();
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        dotCount = (dotCount + 1) % 4;
      });
    });
  }

  @override
  void dispose() {
    _dotTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '診断中${'.' * dotCount}',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
