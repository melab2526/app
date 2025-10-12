import 'package:flutter/material.dart';
import 'package:melab_app/pages/step0_page.dart';
import 'package:melab_app/pages/step1_page.dart';
import 'package:melab_app/pages/step2_page.dart';
import 'package:melab_app/pages/step3_page.dart';
import 'package:melab_app/pages/loading_page.dart';
import 'package:melab_app/pages/result_page.dart';

void main() {
  runApp(const MeLabApp());
}

class MeLabApp extends StatelessWidget {
  const MeLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeLAB 診断',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Hiragino Kaku Gothic ProN',
        scaffoldBackgroundColor: const Color(0xFFFFF8E7),
      ),
      initialRoute: '/step0',
      routes: {
        '/step0': (_) => const Step0Page(),
        '/step1': (_) => const Step1Page(),
        '/step2': (_) => const Step2Page(),
        '/step3': (_) => const Step3Page(),
        '/loading': (_) => const LoadingPage(),
        '/result': (_) => const ResultPage(),
      },
    );
  }
}
