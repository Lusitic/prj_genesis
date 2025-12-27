class AuthState {
  // TODO: FirebaseAuth.currentUser != null 같은 걸로 교체  

  static Future<bool> isLoggedIn() async {
    return false; // 지금은 무조건 로그인 안된 상태로
  }
}