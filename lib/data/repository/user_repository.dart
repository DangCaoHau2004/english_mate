import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/data/network/user_firestore_datasource.dart';
import 'package:english_mate/models/user_data.dart';
import 'package:english_mate/core/enums/app_enums.dart';

class UserRepository {
  final UserFirestoreDatasource _userFirestoreDatasource;
  final _col = FirebaseFirestore.instance.collection('users');
  UserRepository({UserFirestoreDatasource? userFirestoreDatasource})
    : _userFirestoreDatasource =
          userFirestoreDatasource ?? UserFirestoreDatasource();

  Future<bool> isNewUser(String uid) async {
    bool? doesUserExist = await _userFirestoreDatasource.doesUserExist(
      uid: uid,
    );
    if (doesUserExist == null) {
      throw Exception('Có lỗi xảy ra!');
    }
    return !doesUserExist;
  }

  Future<void> createUserProfile({required UserData userData}) {
    return _userFirestoreDatasource.createUserProfile(
      uid: userData.uid,
      data: userData.toJson(),
    );
  }

  Future<UserData> getUserData({required String uid}) async {
    UserData? userData = await _userFirestoreDatasource.getUserData(uid: uid);
    if (userData == null) {
      throw Exception('Không tồn tại user');
    }
    return userData;
  }

  Future<void> updateUserData({required UserData userData}) {
    return _userFirestoreDatasource.updateUserData(
      uid: userData.uid,
      data: userData.toJson(createAt: userData.createAt),
    );
  }

  Future<void> linkedAccountWithGoogle() async {
    await _userFirestoreDatasource.linkedAccountWithGoogle();
  }

  Future<void> linkedAccountWithEmail({
    required String email,
    required String password,
  }) async {
    await _userFirestoreDatasource.linkedAccountWithEmail(
      email: email,
      password: password,
    );
  }

  Future<void> unLinkedAccount({required AppAuthProvider authProvider}) async {
    _userFirestoreDatasource.unLinkedAccount(authProvider: authProvider);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchUserDoc({
    required String uid,
  }) {
    return _col.doc(uid).snapshots();
  }
}
