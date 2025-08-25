import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/utils/auth_error_converter.dart';

class UserFirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
}
