import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_mate/core/enums/app_enums.dart';
import 'package:flutter/material.dart';

class UserData {
  final String uid;
  final String email;
  final String fullName;
  final List<AppAuthProvider> authProvider;
  final Gender gender;
  final DateTime dateOfBirth;
  final DateTime? createAt;
  final TimeOfDay? studyTime;

  UserData({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.authProvider,
    required this.gender,
    required this.dateOfBirth,
    this.studyTime,
    this.createAt,
  });

  factory UserData.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> doc,
  }) {
    final data = doc.data();
    if (data == null) {
      throw Exception("Không có dữ liệu trong tài liệu!");
    }
    List<AppAuthProvider> authProviders = [];
    for (var i = 0; i < data["authProvider"].length; i++) {
      authProviders.add(AppAuthProvider.values.byName(data["authProvider"][i]));
    }
    return UserData(
      uid: doc.id, // Lấy uid từ id của tài liệu
      email: data['email'] as String,
      fullName: data['fullName'] as String,
      authProvider: authProviders,
      gender: Gender.values.byName(data['gender'] as String),
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      createAt: (data['createAt'] as Timestamp).toDate(),
      studyTime: data['studyTime'] == null
          ? null
          : TimeOfDay.fromDateTime((data['studyTime'] as Timestamp).toDate()),
    );
  }

  Map<String, dynamic> toJson({DateTime? createAt}) {
    DateTime now = DateTime.now();
    return {
      "email": email,
      "fullName": fullName,
      "authProvider": authProvider.map((e) => e.name).toList(),
      "gender": gender.name,
      "dateOfBirth": dateOfBirth,
      "createAt": createAt ?? now,
      "updateAt": now,
      "studyTime": studyTime == null
          ? null
          : DateTime(
              now.year,
              now.month,
              now.day,
              studyTime!.hour,
              studyTime!.minute,
            ),
    };
  }
}
