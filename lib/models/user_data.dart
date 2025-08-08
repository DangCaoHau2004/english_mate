// Ví dụ: lib/models/user_data.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:flutter/material.dart';

class UserData {
  final String uid;
  final String email;
  final String fullName;
  final AppAuthProvider authProvider;
  final Gender gender;
  final DateTime dateOfBirth;
  final TimeOfDay? studyTime;

  UserData({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.authProvider,
    required this.gender,
    required this.dateOfBirth,
    this.studyTime,
  });

  factory UserData.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> doc,
  }) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Không có dữ liệu trong tài liệu!");
    }

    return UserData(
      uid: doc.id, // Lấy uid từ id của tài liệu
      email: data['email'] as String,
      fullName: data['fullName'] as String,
      authProvider: AppAuthProvider.values.byName(
        data['authProvider'] as String,
      ),
      gender: Gender.values.byName(data['gender'] as String),
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "fullName": fullName,
      "authProvider": authProvider.name,
      "gender": gender.name,
      "dateOfBirth": dateOfBirth,
      "createAt": DateTime.now(),
      "updateAt": DateTime.now(),
    };
  }
}
