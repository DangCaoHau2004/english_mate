import 'package:english_mate/utils/auth_error_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNetworkDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // đăng nhập với google
  Future<UserCredential?> signInWithGoogleAccount() async {
    try {
      await _googleSignIn.initialize();
      final googleAccount = await _googleSignIn.authenticate();

      final googleAuth = googleAccount.authentication;
      if (googleAuth.idToken == null) {
        return null;
      }

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      return userCredential;
      // Nếu tài khoản đã tồn tại nhưng chưa điền thông tin

      // await FirebaseFirestore.instance
      //     .collection("users")
      //     .doc(userCredential.user!.uid)
      //     .set(userData.toJson());
    } on GoogleSignInException catch (e) {
      throw Exception({e.description});
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  // đăng kí
  Future<UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // đổi tên e code theo văn bản đã định sẵn
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }
}
