
import 'package:flutter/material.dart';

/// HTML/CSSの .container 相当：
/// - max-width: 420px で中央寄せ
/// - min-height: 100dvh 相当
/// - 下余白: 24px + セーフエリア
/// - 背景イラストを右下に表示（幅＝コンテナ幅の38%）
class ScreenFrame extends StatelessWidget {
  final Widget child;
  final bool showBackground;
  final Color backgroundColor;

  const ScreenFrame({
    super.key,
    required this.child,
    this.showBackground = true,
    this.backgroundColor = const Color(0xFFFFFAF1), // #fffaf1
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth; // <= 420
            final bgWidth = containerWidth * 0.38;       // CSS: background-size: 38%

            return Container(
              color: backgroundColor,
              constraints: BoxConstraints(
                // min-height: 100dvh 相当
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // 🟡 背景イラスト（最背面）
                  if (showBackground)
                    Positioned(
                      right: 0,
                      bottom: 24 + bottomInset,
                      child: IgnorePointer(
                        child: Image.asset(
                          'assets/melab_background.png',
                          width: bgWidth,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                  // 🟢 メイン内容（前面）
                  Padding(
                    padding: EdgeInsets.only(bottom: 24 + bottomInset),
                    child: child,
                  ),
                ],
              ),

            );
          },
        ),
      ),
    );
  }
}
