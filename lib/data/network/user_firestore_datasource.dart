import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/utils/auth_error_converter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserFirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<bool?> doesUserExist({required String uid}) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.exists;
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> createUserProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set(data);
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<UserData?> getUserData({required String uid}) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      bool doesUserExist = doc.exists;
      if (!doesUserExist) return null;
      UserData userData = UserData.fromFirestore(doc: doc);
      return userData;
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> updateUserData({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).update(data);
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> linkedAccountWithGoogle() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Vui lòng đăng nhập');
      }

      await _googleSignIn.initialize();
      final googleAccount = await _googleSignIn.authenticate();

      final googleAuth = googleAccount.authentication;
      if (googleAuth.idToken == null) {
        throw Exception('Bạn cần đăng nhập với Google');
      }

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      await user.linkWithCredential(credential);
      await _firestore.collection('users').doc(user.uid).update({
        "authProvider": FieldValue.arrayUnion([AppAuthProvider.google.name]),
      });
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> linkedAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Vui lòng đăng nhập');
      }

      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.linkWithCredential(credential);
      await _firestore.collection('users').doc(user.uid).update({
        "authProvider": FieldValue.arrayUnion([AppAuthProvider.email.name]),
      });
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }

  Future<void> unLinkedAccount({required AppAuthProvider authProvider}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Vui lòng đăng nhập');
      }
      final providerId = switch (authProvider) {
        AppAuthProvider.email => 'password',
        AppAuthProvider.google => 'google.com',

        // AppAuthProvider.apple   => 'apple.com',
        // AppAuthProvider.facebook=> 'facebook.com',
        // AppAuthProvider.phone   => 'phone',
      };

      await user.unlink(providerId);
      await _firestore.collection('users').doc(user.uid).update({
        "authProvider": FieldValue.arrayRemove([authProvider.name]),
      });
    } on FirebaseException catch (e) {
      throw Exception(AuthErrorConverter.getErrorMessage(e.code));
    }
  }
}
