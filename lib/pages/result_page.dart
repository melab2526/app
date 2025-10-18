import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/header.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String resultTitle = "";
  String resultType = "";
  String resultText = "";
  Color resultColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _loadResult();
  }

  Future<void> _loadResult() async {
    final prefs = await SharedPreferences.getInstance();
    final a1 = prefs.getString('answer1') ?? '';
    final a2 = prefs.getString('answer2') ?? '';
    final a3 = prefs.getString('answer3') ?? '';
    final key = a1 + a2 + a3;

    final result = _resultsMap[key] ?? _resultsMap['default']!;
    

    setState(() {
      resultTitle = result['title']!;
      resultType = result['type']!;
      resultText = result['text']!;
      resultColor = result['color'] as Color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🧭 ヘッダー
            MeLabHeader(onBack: () => Navigator.pop(context)),
            const SizedBox(height: 60), // ← あなたの余白はそのまま！Good！

            // 🧫 タイトルの上にアイコンを追加
          if ((_resultsMap.entries.firstWhere(
                (e) => e.value['title'] == resultTitle,
                orElse: () => MapEntry('default', _resultsMap['default']!)
              ).value['icon'] ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 12),
              child: Image.asset(
                _resultsMap.entries.firstWhere(
                  (e) => e.value['title'] == resultTitle,
                  orElse: () => MapEntry('default', _resultsMap['default']!)
                ).value['icon'],
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),


            // 🧫 タイトル
            Text(
              resultTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: resultColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              resultType,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFA0855E),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // 📄 本文
            Flexible( // ← Expandedよりも自然に広がる
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  resultText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF6E5C3E),
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🧪 ボタン
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                style: ElevatedButton.styleFrom(
                  backgroundColor: resultColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "もう一度診断する",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// 🎯 27通り＋3タイプ（A/B/C）をここに定義
  /// 🎯 27通り＋3タイプの診断結果マップ
  final Map<String, Map<String, dynamic>> _resultsMap = {
    // === 🩷 Aタイプ：みんなでワイワイ型（#FF8888） ===
    "AAA": {"title": "みんなでワイワイ型", "type": "共創研究者", "text": "チームの空気をやわらげる触媒。あなたがいるとラボが明るくなります。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "AAB": {"title": "みんなでワイワイ型", "type": "観察共感タイプ", "text": "他の人の意見を取り入れながら、自分なりの整理もできるタイプ。人と理論のバランスが絶妙。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "AAC": {"title": "みんなでワイワイ型", "type": "直感共鳴タイプ", "text": "感覚的に人の気持ちを読むのが得意。柔軟な発想で研究を前に進めます。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ABA": {"title": "みんなでワイワイ型", "type": "調整型リーダー", "text": "場の流れを読みながら方向性を決めるリーダー。空気を動かす力があります。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ABB": {"title": "みんなでワイワイ型", "type": "穏やか戦略家", "text": "考えすぎず、感じすぎず、ちょうどいい判断ができる人。研究室の潤滑油的存在。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ABC": {"title": "みんなでワイワイ型", "type": "柔軟調和型", "text": "状況に合わせて役割を変えられるマルチプレイヤー。あなたがいると実験がスムーズに進みます。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ACA": {"title": "みんなでワイワイ型", "type": "行動共創タイプ", "text": "手を動かしながら考えるタイプ。行動を通じてチームを動かします。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ACB": {"title": "みんなでワイワイ型", "type": "行動共感ハイブリッド", "text": "感覚と分析、両方を大切にできるタイプ。アイデアを現実に変える推進力を持つ人。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},
    "ACC": {"title": "みんなでワイワイ型", "type": "共感×行動ハイブリッド", "text": "思いやりのある行動派。人を巻き込みながら実験を楽しむタイプです。", "color": const Color(0xFFFF8888), "icon": "assets/icons/waiwai.png",},

    // === 💙 Bタイプ：コツコツ研究型（#7596EA） ===
    "BAA": {"title": "コツコツ研究型", "type": "分析×共感タイプ", "text": "人の動きや気持ちを分析的に捉えるタイプ。チームに安心感を与える観察者。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BAB": {"title": "コツコツ研究型", "type": "慎重観察者", "text": "計画を立ててから行動するタイプ。データに裏付けられた安心感があります。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BAC": {"title": "コツコツ研究型", "type": "分析×行動ハイブリッド", "text": "理論と感覚のバランスを取りながら行動できる、柔軟な分析者。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BBA": {"title": "コツコツ研究型", "type": "分析リーダータイプ", "text": "冷静で穏やかな指導者。周囲を見ながら正確に判断できます。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BBB": {"title": "コツコツ研究型", "type": "仮説検証のエンジン", "text": "整然としたノートと分析力で、安定した成果を出すタイプです。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BBC": {"title": "コツコツ研究型", "type": "理論×直感タイプ", "text": "論理の中にひらめきを持ち込める、柔軟な分析者。", "color": const Color(0xFF7596EA),"icon": "assets/icons/kotsukotsu.png",},
    "BCA": {"title": "コツコツ研究型", "type": "計画型リーダー", "text": "整理と計画の達人。誰よりも安定感のあるリサーチマネージャーです。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BCB": {"title": "コツコツ研究型", "type": "構築派アーティスト", "text": "ロジカルに整えながら、美学を感じさせる研究を進めます。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},
    "BCC": {"title": "コツコツ研究型", "type": "理論的アクション派", "text": "考えて動く挑戦者。実験の中で答えを導くタイプです。", "color": const Color(0xFF7596EA), "icon": "assets/icons/kotsukotsu.png",},

    // === 💛 Cタイプ：とりあえずやってみる型（#ECC880） ===
    "CAA": {"title": "とりあえずやってみる型", "type": "ムードメーカー研究者", "text": "行動から始まるリーダーシップ。明るさが研究所のエネルギー源です。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CAB": {"title": "とりあえずやってみる型", "type": "柔軟直感タイプ", "text": "人との関わりを楽しみながら、インスピレーションを広げる協調者。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CAC": {"title": "とりあえずやってみる型", "type": "ひらめき派研究者", "text": "思いついたら即行動！あなたのスピード感が新しい現象を生み出します。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CBA": {"title": "とりあえずやってみる型", "type": "勢い×バランス型", "text": "状況に応じて自在に動けるタイプ。あなたがいるとチームが前を向きます。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CBB": {"title": "とりあえずやってみる型", "type": "現場型観察者", "text": "頭で考えたことをすぐ試せるタイプ。行動と洞察のバランスが絶妙です。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CBC": {"title": "とりあえずやってみる型", "type": "好奇心ハンター", "text": "何にでも手を出してみる柔軟な研究者。あなたの“まずやってみる”が世界を変えます。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CCA": {"title": "とりあえずやってみる型", "type": "感覚リーダー", "text": "人を動かす情熱と勢い。直感で場を引っ張るカリスマ型。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CCB": {"title": "とりあえずやってみる型", "type": "直感リアリスト", "text": "感覚的に動きつつも、必要な分析は忘れない、行動派の中の冷静者。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},
    "CCC": {"title": "とりあえずやってみる型", "type": "自由研究者", "text": "思い立ったらすぐ実験！失敗もデータのうち。ひらめきが次の発見を生み出します。", "color": const Color(0xFF9DDE94), "icon": "assets/icons/try.png",},

    // 🪶 フォールバック（エラー時など）
    "default": {
      "title": "未知の研究者",
      "type": "まだ観測されていないタイプ",
      "text": "あなたの研究スタイルは新しい分類を生み出すかもしれません。",
      "color": Colors.grey,
    },
  };

}
