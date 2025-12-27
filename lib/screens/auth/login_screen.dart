import 'package:flutter/material.dart';
import '../home/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _loginSuccess(BuildContext context) {
    // TODO: 실제 로그인 처리 후 성공 시
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: FilledButton(
          onPressed: () => _loginSuccess(context),
          child: const Text('로그인(임시)')
        ),
      ),
    );
  }
}