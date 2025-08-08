import 'package:english_mate/data/network/user_firestore_datasource.dart';
import 'package:english_mate/models/user_data.dart';

class UserRepository {
  final UserFirestoreDatasource _userFirestoreDatasource;

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
    try {
      UserData? userData = await _userFirestoreDatasource.getUserData(uid: uid);
      if (userData == null) {
        throw Exception('Không tồn tại user');
      }
      return userData;
    } catch (e) {
      throw Exception('Có lỗi xảy ra!');
    }
  }
}
