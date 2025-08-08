import 'package:english_mate/data/network/auth_network_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthNetworkDatasource _authNetworkDatasource;

  AuthRepository({AuthNetworkDatasource? authNetworkDatasource})
    : _authNetworkDatasource = authNetworkDatasource ?? AuthNetworkDatasource();

  Future<UserCredential> signInWithGoogle() async {
    final UserCredential? user = await _authNetworkDatasource
        .signInWithGoogleAccount();
    try {
      if (user == null) {
        throw Exception("Đăng nhập Google bị hủy");
      }
      return user;
      // nó tồn tại thì trả về data
    } catch (e) {
      throw Exception("Đăng nhập thất bại");
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential? user = await _authNetworkDatasource
          .signInWithEmailAndPassword(email: email, password: password);
      if (user == null) {
        throw Exception("Đăng nhập thất bại");
      }
      return user;
    } catch (e) {
      throw Exception("Đăng nhập thất bại");
    }
  }

  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    // đăng kí
    final UserCredential? user = await _authNetworkDatasource
        .signUpWithEmailAndPassword(email: email, password: password);

    if (user != null) {
      return user;
    } else {
      throw Exception('Đăng ký thất bại');
    }
  }
}
