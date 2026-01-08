import 'package:lottie/lottie.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:prj_genesis/providers/locale_provider.dart';
import '../../utilities/app_prefs.dart';
import '../auth/login_screen.dart';

import '../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../providers/locale_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  // Onbording page data
  final _pages = const [
    OnboardingPageData(
      titleKey: "onboarding_main",
      subtitleKey: "onboarding_main_sub",
      //icon: Icons.auto_awesome,
      lottieAsset: 'assets/lottie/twinkle_loading.json',
      bg: Color(0xFF1D1E3A),
    ),
    OnboardingPageData(
      titleKey: "onboarding_light_main",
      subtitleKey: "onboarding_light_sub",
      //icon: Icons.palette_outlined,
      lottieAsset: 'assets/lottie/light.json',
      bg: Color(0xFF1D1E3A),
    ),
    OnboardingPageData(
      titleKey: "onboarding_humi_main",
      subtitleKey: "onboarding_humi_sub",
      //icon: Icons.water_drop_outlined,
      lottieAsset: 'assets/lottie/water.json',
      bg: Color(0xFF1D1E3A),
    ),
    OnboardingPageData(
      titleKey: "onboarding_rotate_main",
      subtitleKey: "onboarding_rotate_sub",
      //icon: Icons.threesixty_outlined,
      lottieAsset: 'assets/lottie/gears.json',
      bg: Color(0xFF1D1E3A),
    ),
    OnboardingPageData(
      titleKey: "onboarding_start_main",
      subtitleKey: "onboarding_start_sub",
      //icon: Icons.rocket_launch_outlined,
      lottieAsset: 'assets/lottie/start.json',
      bg: Color(0xFF1D1E3A),
    ),
  ];

  bool get _isLast => _index == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await AppPrefs.setOnboardingDone(true);
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _next() {
    if (_isLast) return;
    _controller.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _skipToLast() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  String _resolve(AppLocalizations t, String key) {
    switch (key) {
      case 'onboarding_main':
        return t.onboarding_main;
      case 'onboarding_main_sub':
        return t.onboarding_main_sub;
      case 'onboarding_light_main':
        return t.onboarding_light_main;
      case 'onboarding_light_sub':
        return t.onboarding_light_sub;
      case 'onboarding_humi_main':
        return t.onboarding_humi_main;
      case 'onboarding_humi_sub':
        return t.onboarding_humi_sub;
      case 'onboarding_rotate_main':
        return t.onboarding_rotate_main;
      case 'onboarding_rotate_sub':
        return t.onboarding_rotate_sub;
      case 'onboarding_start_main':
        return t.onboarding_start_main;
      case 'onboarding_start_sub':
        return t.onboarding_start_sub;
      default:
        return '';
    }
  }

  void _showLanguageSheet(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: const Color(0xFF1D1E3A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Text(
                //'Language',
                t.language,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),

              ListTile(
                leading: const Text('🇰🇷', style: TextStyle(fontSize: 18)),
                title: const Text('한국어', style: TextStyle(color: Colors.white)),
                onTap: () {
                  context.read<LocaleProvider>().setLocale(const Locale('ko'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 18)),
                title: const Text('English', style: TextStyle(color: Colors.white)),
                onTap: () {
                  context.read<LocaleProvider>().setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 8),

              // (선택) 시스템 언어로 돌아가기
              ListTile(
                leading: const Icon(Icons.settings_backup_restore, color: Colors.white70),
                title: const Text('System default', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  context.read<LocaleProvider>().clearLocale();
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 배경색은 현재 페이지 기준으로 바뀌게 (하단 고정 영역 포함)
    final t = AppLocalizations.of(context)!;
    final bg = _pages[_index].bg;

    return Scaffold(
      backgroundColor: bg,

      // PageView는 콘텐츠만 이동

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              // 상단 skip은 고정
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //mainAxisSize: MainAxisSize.min
                  children: [
                    IconButton(
                      tooltip: t.language,
                      onPressed: () => _showLanguageSheet(context),
                      icon: Icon(
                        Icons.language,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    TextButton(
                      onPressed: _isLast ? null : _skipToLast,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white.withOpacity(_isLast ? 0.4 : 0.9),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), 
                  ],
                ),
              ),


              // 스와이프 되는 영역
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final p = _pages[i];
                    return Column(
                      children: [
                        const Spacer(),

                        Center(
                          child: Container(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              p.lottieAsset,
                              fit: BoxFit.contain,
                              // 애니메이션이 반복되도록 설정
                              repeat: true,
                              // 앱이 무거워지지 않게 프레임 조절 가능
                              frameRate: FrameRate.composition,
                              // 파일이 없을 때 에러 방지
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error_outline, color: Colors.white);
                              }
                            )
                            /*
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            
                            child: Icon(
                              p.icon,
                              size: 100,
                              color: Colors.amberAccent.withOpacity(0.95),
                            ),
                            */
                          ),
                        ),

                        const Spacer(),

                        /*
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            p.title, 
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14, 
                              height: 1.05,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),
                        */

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //p.title, 
                            _resolve(t, p.titleKey),
                            style: const TextStyle(
                              color: Colors.white, 
                              fontSize: 34,
                              height: 1.05,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //p.subtitle, 
                            _resolve(t, p.subtitleKey),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.78), 
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),

                        // 하단 고정 영역과 겹치지 않도록 여유 공간 확보
                        const SizedBox(height: 120),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // 하단 컨트롤은 고정
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 10, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Dots(count: _pages.length, index: _index),
              const SizedBox(height: 16),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: _isLast
                  ? SizedBox(
                    key: const ValueKey('start_only'),
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _finish, 
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1D1E3A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text("Start"),
                    )
                  )
                : Row(
                    key: const ValueKey("next_and_start"),
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          //onPressed: _isLast? null : _next, 
                          onPressed: _next,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white.withOpacity(0.7)),
                            foregroundColor: Colors.white, 
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          //child: Text(_isLast? 'Next' : 'Next'),
                          child: const Text("Next")
                        ),
                      ),

                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          //onPressed: _isLast? _finish : null,
                          onPressed: null, // 마지막 전까지 비할성화
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white, 
                            disabledBackgroundColor: Colors.white.withOpacity(0.35),
                            foregroundColor: const Color(0xFF1D1E3A),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          child: const Text('Start'),
                        ),
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;

  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final selected = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.only(right: 8),
          width: selected ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(selected ? 0.95 : 0.45),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

class OnboardingPageData {
  final String titleKey;
  final String subtitleKey;
  //final IconData icon;
  final String lottieAsset;
  final Color bg;

  const OnboardingPageData({
    required this.titleKey,
    required this.subtitleKey,
    //required this.icon,
    required this.lottieAsset,
    required this.bg,
  });
}