
class UserRepository {
  Future<void> signIn(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}