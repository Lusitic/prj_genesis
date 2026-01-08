import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

// screens 폴더에 있는 home.dart를 import
import 'screens/home/home.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'utilities/app_prefs.dart';
import 'providers/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Firebase 같은 초기화가 필요하면 여기서
  // await Firebase.initializeApp();

  await resetOnboardingForDebug(); // Only use in Debug!!
  runApp(const MyApp());
}

/// 앱 전체 설정(테마, 라우팅, 로케일 등)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRJ_GENESIS',
      debugShowCheckedModeBanner: false,

      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // 앱 공통 테마
      theme: ThemeData(
        useMaterial3: true,
        // brightness: Brightness.dark, // 취향껏
      ),

      home: const AppGate(),
    );
  }
}

// 앱 시작 시 분기만 담당하는 화면
class AppGate extends StatelessWidget {
  const AppGate({super.key});

  Future<Widget> _decideStartScreen() async {
    final onboardingDone = await AppPrefs.isOnboardingDone();
    if (!onboardingDone) return const OnboardingScreen();

    final loggedIn = await AuthState.isLoggedIn();
    if (!loggedIn) return const LoginScreen();

    return const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStartScreen(), 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data!;
      },
    );
  }
}