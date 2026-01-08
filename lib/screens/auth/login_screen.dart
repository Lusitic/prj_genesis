import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // 1) 입력 검증
    final ok = _formKey.currentState?.validate() ?? false;
    if(!ok) return;

    setState(() => _loading = true);

    try {
      // TODO: 실제 로그인 로직 (firebase/server) 연결 위치
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: $e")),
      );
    } finally {
      if(mounted) setState(() => _loading = false);
    }
  }

  void _goSignup() {
    // TODO: Connect to SignupScreen.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Register screen connect to next step.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canPress = !_loading;

    return Scaffold(
      backgroundColor: Color(0xFF1D1E3A),
      //appBar: AppBar(
      //  title: const Text("Login"),
      //),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "Welcome back",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Sign In.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Email
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "example@email.com",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        final s = (v ?? "").trim();
                        if(s.isEmpty) return "Please enter your email.";

                        // 간단한 이메일 체크
                        if(!s.contains('@') || !s.contains('.')) return 'Invaild email format.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    // Password
                    TextFormField(
                      controller: _pwCtrl,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure), 
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      validator: (v) {
                        final s = (v ?? "");
                        if(s.isEmpty) return "Please enter your password.";
                        if(s.length < 6) return "Password must be at least 6.";
                        return null;
                      },
                      onFieldSubmitted: (_) => canPress ? _login() : null,
                    ),
                    const SizedBox(height: 10),
                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Reset password function connect to next step."))
                          );
                        }, 
                        child: const Text("Forgot password?"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Login button
                    FilledButton(
                      onPressed: canPress ? _login : null, 
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: _loading
                        ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text("Login"),
                    ),
                    const SizedBox(height: 12),
                    // Signup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You not have an account?",
                          style: TextStyle(color: Colors.white),),
                        TextButton(
                          onPressed: _goSignup,
                          child: const Text("Sign up"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}